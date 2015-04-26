+++
date = "2015-04-21"
title = "Deploy"
draft = true

+++

[Hugo](www.gohugo.io) is a fast & modern static website engine written in GO language.

最近刚刚接触 Hugo，感觉它非常灵活有趣，速度也很快，所以把自己的博客转成了 Hugo 平台，用 Git `push` 到 Digital Ocean 上。安装搭建配置使用的方法步骤过程如下：

1. 首先在本地，安装 GO、HUGO，下载主题，添加文章，预览网站，初始 Git repo；
2. 在服务器上，安装 GO、HUGO，配置主机，初始 Git repo，准备 Hook；
3. 将本地 HUGO 网站，Git push 到服务器上；服务器自动运行，生成静态网页；
4. 完毕。

开始前，我假设你有了解 Git 的基本知识，使用 Mac，在 Digital Ocean VPS 上搭建过博客，有 GO 语言，与
