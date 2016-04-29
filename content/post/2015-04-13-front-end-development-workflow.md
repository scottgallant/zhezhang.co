+++
date = "2015-04-13T00:00:00+00:00"
draft = false
title = "Front-end Development Workflow"

+++
> 前端开发是一项复杂的持续发展的工程。

前端开发涉及到很多方面的知识，需要开发者持续不断地学习新技术，才能与时俱进，保持良好的开发能力。能熟练运用一些不错的开发工具后，才能更好更有效地进行个人或团队的前端开发工作。长话短说，在此根据自己的一些个人经验，粗略地列出前端开发工作流程和所涉及到的工具。

##### Terminal

如果你是一名开发工程师，相信你应该每天都在使用 Terminal。如果你是 Mac OS 用户，Terminal 的替代品是 [iTerm2](http://iterm2.com/)，有很多比如分屏、热键、搜索、自动完成、粘贴历史等等[特性](http://iterm2.com/features.html)。

*如果你是 Windows 用户，可以尝试使用 [cmder](http://bliker.github.io/cmder/)。*

另外，Mac 系统默认使用的 shell 是 bash，可以尝试使用功能强大的名为 [zsh](www.zsh.org) shell。除了 zsh 之外，还可安装 [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)，一个开源的、社区维护的管理 zsh 配置的框架，你可以充分利用数百个插件和主题，来加快你的工作流。

##### Editor

除了 Geeks 最大爱的 vim 或 emacs，你也许用过 TextMate、Coda、Espresso、TextWrangler 等, 其他现代流行的编辑器包括且不局限于：

- **[Sublime Text](http://www.sublimetext.com/)** Python 编写，快速、cross-platform、[插件](https://packagecontrol.io/)众多
- **[Atom](https://atom.io/)** GitHub 出品，开源，基于 Node.js
- **[Brackets](http://brackets.io/)** Adobe 出品，开源，用 JavaScript，HTML 和 CSS 编写
- **[WebStorm](https://www.jetbrains.com/webstorm/)** 开发 JavaScript、Node.js、Meteor 等前后台开发的商业软件

##### Git

Git 版本控制，下载地址为 http://git-scm.com/downloads

##### Node.js & npm

Node.js 的诞生为互联网开启了各种可能性，不仅让 JavaScript 运行在服务器端，而且产生了各种开发工具、开发平台和第三方 package，通过其自带的 npm 工具，可以安装 Bower、Grunt、Gulp、LESS、UglifyJS、Autoprefixer、Yeoman 等等工具，使前端开发变得轻松简单。

安装 Node.js 和 npm 可以访问[官方下载](https://nodejs.org/download/)页面。如果是 Mac 下，也可以通过 Homebrew 安装：

```
brew install node
```

##### Bower

在前端开发时，经常会用到各种第三方代码，比如 jQuery、Bootstrap，通常你可以直接访问各自官网，下载压缩包或源文件，然后复制到你的开发目录中。这种方式费时费力，通过 Bower 前端代码包管理器，就可以通过命令行来下载管理这些第三方 package 了。尤其在团队合作时，通过 `bower.json` 文件，规定项目所用到的第三方 package 和版本，团队之间分享该文件，通过 `bower install` 就可以下载安装所需代码包。如遇版本升级时，通过 `bower update <package-name>` 更新代码包即可。

安装 Bower：

```
npm install -g bower
```

全局安装 Bower，这样在命令行就可以直接使用 `bower` 命令。

在新项目目录中，通过运行一下命令来初始化 `bower.json` 文件：

```
bower init
```

之后，就可以来安装下载第三方代码包，比如：

```
bower install jquery --save
```

在团队之间合作时，成员通过运行：

```
bower install
```

根据 `bower.json` 文件描述，即可自动下载项目所需代码，并保存在 `bower_components` 文件夹中。

##### Grunt，Gulp 或 npm

Grunt 和 Gulp 是 两个 task runner，能完成相同的工作，编译 Sass、LESS、Stylus CSS、Jade，Autoprefixer，合并压缩 CSS 文件和 JavaScript 文件等。Grunt 较 Gulp 先出现，有更多的 package，不过个人偏向于简明的 Gulp。不论选择哪个，用好它就可以将前端开发做的高效优质。

其实，npm 也可以作为前端 build 工具完成以上工作，请参考[这篇文章](http://jsforallof.us/2015/02/12/utilising-node-and-npm-for-front-end-development-workflow/)，和[这篇文章](http://blog.keithcirkel.co.uk/how-to-use-npm-as-a-build-tool/)。

需要哪些东西需要构建用于 production 环境：

- Stylesheets - Sass/LESS/Stylus -> CSS
- JavaScripts - CoffeeScript
- Templates - Jade
- Images
- ...

拿 Gulp 来举例。安装 Gulp：

```
npm install -g gulp
```

在项目文件夹中，将 gulp 添加到 `package.json` 中。

```
npm install gulp --save-dev
```

然后新建一个 `gulpfile.js` 文件，gulp 使用该文件进行构建操作。

打开 `gulpfile.js`，首先将 gulp 添加到该文件中：

```javascript
var gulp = require('gulp');
```

下面可以安装一些项目所需的 gulp 插件，来完成所需任务。如果项目 CSS 是用 Stylus 来写的，那么安装 `gulp-stylus`：

```
npm install gulp-stylus --save-dev
```

然后在 `gulpfile.js` 中引用，并使用该插件来编译 Stylus：

```
// Include the required packages.
var gulp = require('gulp');
var stylus = require('gulp-stylus');

// Get .styl file and render
gulp.task('css', function () {
  gulp.src('./css/one.styl')
    .pipe(stylus())
    .pipe(gulp.dest('./css/build'));
});
```

除此之外，还有一些常用的 Gulp 工具：

- gulp-autoprefixer
- gulp-connect
- gulp-less
- gulp-sass
- gulp-jshint
- gulp-uglify
- gulp-rename
- gulp-util

等等。

可以参考以下文章了解更多 Gulp 知识。

- http://www.smashingmagazine.com/2014/06/11/building-with-gulp/
- http://viget.com/extend/gulp-browserify-starter-faq

关于前端开发就先写这么多，前端开发不是一项看着简单的工程，还有很多很多东西，需要学习。借用一句话来作为这篇文章的结尾：

> Stay Hungry, Stay foolish.

祝好。
