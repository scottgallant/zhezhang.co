+++
date = "2015-01-12T00:00:00+00:00"
draft = false
title = "在 DigitalOcean 搭建 Ghost 博客平台"

+++
[Ghost](https://ghost.org/) 是一个基于 Node.js 平台的免费开源的简洁优雅的博客平台。随着 WordPress 起初作为博客平台逐渐发展到内容管理系统，逐渐变得臃肿起来，已经开始定位于更广大的内容平台，而 Ghost 这个开源项目使用当下流行的 Node.js，只专注于博客，轻量、美观、支持 markdown 文章编辑、支持多用户协作，赢得了众人关注。[DigitalOcean](https://www.digitalocean.com/?refcode=f3851a9bdb88) 是非常优秀的 VPS 服务器提供商，价格不高但服务不错。这篇文章向大家介绍如何在 DigitalOcean 上搭建 Ghost 博客平台。

##### 目录

1. [设置服务器 Ubuntu](#1)
2. [安装 Node.js](#2)
3. [安装 Nginx](#3)
4. [安装和配置 Ghost](#4)
5. [用 PM2 管理](#5)

##### 1. 设置服务器 Ubuntu <a name="1"></a>

在 DigitalOcean 的控制面板中新建一个 Droplet（VPS 服务器）并选择 Ubuntu 14.04 版本作为服务器的操作系统。

创建好 Droplet 后，会得到其对应的 IP 地址，使用 SSH 来连接你的服务器。

```
ssh root@YOUR-SERVER-IP
```

如果第一次以密码方式登录服务器，会提示你更改你的 root 密码。出于安全考虑，你不应该使用 `root` 来进行日常操作；而应该建立一个新用户，并给予超级用户权限通过 `sudo` 来运行需管理权限的命令。这里，我们添加一个新用户 user 并将其添加到 sudo 组中。

```
adduser user
gpasswd -a user sudo
```

有了新用户之后，有必要通过修改 SSH 配置文件，来禁止 root 进行 SSH 登录，以增加服务器的安全性。

```
nano /etc/ssh/sshd_config
```

用 `nano` 编辑 SSH 配置文件，找到 `PermitRootLogin yes` 这一行， 改为 `PermitRootLogin no`，` Ctrl + X` 保存退出，输入 `y`，然后 `ENTER`。

##### 2. 安装 Node.js <a name="2"></a>

选择 NodeSource 源来确保为 Ubuntu 系统安装最新版本的 Node.js，首先运行：

```
curl -sL https://deb.nodesource.com/setup | sudo bash -
```

然后用如下命令安装 Node.js 和 npm。

```
sudo apt-get install -y nodejs
```

如果你分别运行 `node -v` 和 `npm -v`，如果安装成功的话，会得到 Node.js 和 npm 版本号：

```bash
$ node -v
v.0.10.35
$ npm -v
1.4.28
```

有些 `npm` 包还需要依赖 `build-essentials` 包，所以也一并安装：

```
sudo apt-get install -y build-essential
```

##### 3. 安装和配置 Nginx <a name="3"></a>

Nginx 是非常流行的免费、开源且高性能的服务器软件，我们可以通过运行如下命令安装 Nginx：

```
sudo apt-get update
sudo apt-get install nginx
```

开始、停止或重启 Nginx 服务器命令分别为：

```
sudo service nginx start
sudo service nginx stop
sudo service nginx restart
```

##### 4. 安装 Ghost <a name="4"></a>

修改你博客域名的 DNS 记录，将域名指向你的 VPS 服务器。在域名管理页面中，修改域名的 NS (Name Server) 域名服务器地址为：

```
NS1.DIGITALOCEAN.COM
NS2.DIGITALOCEAN.COM
NS3.DIGITALOCEAN.COM
```

回到 DigitalOcean 的控制面板的，在 DNS 页面中，添加你的域名。

现在你有了 Ubuntu 14.04 的服务器，安装了 Node.js 和 Nginx，设置好的域名（以 your-domain.com 为例），接下来我们安装 Ghost。

通常，我们把每个网站文件保存在单独的文件夹中，放在 `/srv/www` 里，一个网站对应一个文件夹。例如，我们在 `/srv/www` 文件夹中新建一个名为 ghost 的文件夹来存放 Ghost 应用。

```
sudo mkdir -p /srv/www/ghost
```

接着，你可以用你喜欢的 SFTP 工具或 `scp` 方式上传你电脑中的 Ghost 文件到服务器的 `/srv/www/ghost` 文件夹中，或者在终端窗口输入如下命令将最新版本的 Ghost 的安装包下载到服务器上，并 `unzip` 解压缩到文件夹中。

```

cd /srv/www/ghost
sudo wget https://ghost.org/zip/ghost-latest.zip  
sudo unzip ghost-latest.zip
```

如果服务器还未安装 `unzip`，通过一下命令安装：

```
sudo apt-get install unzip
```

创建好文件夹后，给予文件夹合适的权限。

```
sudo chown -R $USER:$USER /srv/www/ghost
sudo chmod -R 755 /srv/www
```


然后安装 Ghost 应用：

```
sudo npm install --production
```

然后运行如下命令检验是否安装成功：

```
npm start
```

接着，`Ctrl+C` 停止 Ghost。下一步，我们要为服务器上的网站设置其 Server Block（对应 Apache 的 VirtualHosts）虚拟主机，并将配置文件保存在 `/etc/nginx/sites-available` 文件夹中。安装 Nginx 时，有一个默认网站的 `default` 配置文件，我们选择保留该文件作为参考之用。我们新建一个名为 ghost 的配置文件：

```
cd /etc/nginx/sites-available
sudo touch ghost
sudo nano ghost
```

复制粘贴下面代码，记得将 your-domain.com 改为你的域名：

```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header HOST $http_host;
        proxy_set_header X-NginX-Proxy true;

        proxy_pass http://127.0.0.1:2368;
        proxy_redirect off;
    }
}
```

`Ctrl+X` 退出，`y`, `Enter`。

然后创建一个链接到 `/etc/nginx/sites-enabled/`

```bash
sudo ln -s /etc/nginx/sites-available/ghost /etc/nginx/sites-enabled/
```

运行 Ghost 之前，修改 config.js 文件：

```
sudo nano /srv/www/ghost/config.js
```

修改 production 的 url 为你的域名，`Ctrl+X` 退出，点 `y` 然后 `Enter`。


```bash
npm start --production
```

在浏览器中输入 your-domain.com，访问你的 Ghost 博客！

##### 5. 使用 PM2 管理 <a name="5"></a>

Ghost 会在终端 Session 结束之后停止运行，为了保持 Ghost 在关闭终端之后依然在后台运行，有几种方法，[forever](https://npmjs.org/package/forever)、[PM2](https://github.com/Unitech/pm2) 或 [supervisor](http://supervisord.org/)。

Node 进程管理器 [PM2](https://github.com/Unitech/pm2) 更先进，除了能保持 Ghost 始终运行，也能轻松设置在系统重启的情况下，重启 Ghost。

首先 `Ctrl+C` 停止 Ghost 应用，然后安装和运行 PM2：

```bash
sudo npm install pm2 -g
cd /srv/www/ghost
NODE_ENV=production pm2 start index.js --name "Ghost"
```

可以用 `pm2 stop Ghost` 停止 或 `pm2 restart Ghost` 重启 Ghost。

另一个特性是在系统重启之后自动运行 Ghost，这是 forever 所没有的。

```
pm2 startup ubuntu
[PM2] You have to run this command as root
[PM2] Execute the following command :
[PM2] sudo env PATH=$PATH:/usr/bin pm2 startup ubuntu -u user
```

PM2 提示应该以 `root` 来运行如下程序，所以根据提示运行：
```
sudo env PATH=$PATH:/usr/bin pm2 startup ubuntu -u user
```

然后保存当前的进程，在服务器重启后，会自动运行当前的 node 进程。

```bash
pm2 save
[PM2] Dumping processes
```

在浏览器访问 your-domain.com/ghost/signup 来新建用户，之后就可以登录到后台管理界面。

现在，开始写博客吧！
