+++
date = "2015-03-09"
title = "Meteor.js 简介"
slug = "introduction-meteor-js"

+++

*自从2014年11月接触 Meteor.js 以来，一直被它的概念和方式吸引着。并一心学习并想写写关于 Meteor 的文章。此篇也不是 Meteor 的教程，只是简介。*

##### 什么是 Meteor.js？

> *"Meteor is a complete open source platform for building web and mobile apps in pure JavaScript."*

> *www.meteor.com*

Meteor 是一个开源的开发平台，通过使用 JavaScript 语言，快速地搭建现代的 web 和 mobile 应用。服务器基于 Node.js，官网也介绍了[很多特性](www.meteor.com)和[七大原则](http://docs.meteor.com/#/basic/sevenprinciples)，其中我认为重要的几点是：

##### 一种语言 前端/后端/web/mobile

你如果想创建一个 web 或 mobile 应用，你可能需要学习除了前端 HTML、CSS、JavaScript 和 之外，还需掌握比如 PHP、Ruby、Python 等其中一个语言来开发服务器端代码，还需要学习 Objective-C 或 Java 语言来开发 iOS 或 Andriod app。而对于 Meteor 应用，你只要 JavaScript 语言就可以编写可在客户端和服务器端（Node.js 环境）运行的应用，而且也可以用 PhoneGap/Cordova 来将应用变成可在 iOS 或 Andriod 上运行的 app。所以，用同一个 codebase 来搭建 web, iOS 和 Android 应用是非常高效便捷的。

##### 实时性响应性 Real-time/Reactivity

Meteor 应用具有响应性。每当数据改变时，客户端页面会及时同步自动更新页面。与传统方式不同，每当客户端发送一个链接或指令后，传递回服务器，服务器根据指令读取数据库生成 HTML 页面传递回客户端。想象一下，在两台电脑的两个浏览器打开同一个网页时，当页面有更新时，传统方式是需要浏览者刷新各自的浏览器来查看页面更新；而响应性可以确保不同电脑的两个浏览器可以同步自动更新网页局部来体现页面更新。而传统开发这功能真是使开发者挠头，而 Meteor 可以帮助开发者轻易地完成实时性的应用开发。

##### Package system

Meteor 有良好的 package system，除了一些核心 core packages（比如，account-ui、accounts-weibo 等）之外，还有第三方开发维护的 packages，你可以在 [atomsphere.com](https://atmospherejs.com/) 中找到非常棒的第三方 packages，比如：Iron Router、Bootstrap、Sass、CoffeeScript 等等。Meteor 基于 Node.js，但有自己的 package system，不能直接使用 npm 中的资源，但可以安装 meteorhacks:npm 去解决这个问题。

还有一些核心 packages，比如：

**[accounts](https://www.meteor.com/accounts)** 提供了用户注册、登录验证的功能，也支持包括 Twitter、微博、GitHub 等其他平台的登录。

**[blaze](https://www.meteor.com/blaze)** 是 Meteor 核心功能之一，创建响应性的用户界面。与 Angular、Backbone、Ember、React、Polymer 或 Knockout 有相似的同能。

##### 社区支持

除了 Meteor 的官方论坛 [https://forums.meteor.com/](https://forums.meteor.com/) 之外，还有其他很多资源：

- [《Discover Meteor》](https://www.discovermeteor.com/)  —— 最好的 Meteor 图书（[中文版链接](https://zh.discovermeteor.com/)）
- [Offical Documentation](https://docs.meteor.com/) —— Meteor 官方文档
- [Meteor 101 中文教学视频](http://www.maiziedu.com/lesson/3446) —— Meteor101 教学视频 by [Kevin G. Zhang](https://github.com/kevingzhang)
- [StackOverflow](http://stackoverflow.com/questions/tagged/meteor) —— Questions & Answers on StackOverflow tagged Meteor
- [Crater.io](http://crater.io/) —— Meteor news, updates and discussion
- [MeteorHacks](https://meteorhacks.com/) —— Meteor Tutorials, Hacks & Projects with @arunoda
- [Meteor Meetups](http://meteor.meetup.com/)  —— Meteor 交流会
- 其他 Meteor 资源列表：
  - https://www.yauh.de/best-learning-resources-for-meteorjs
  - https://www.discovermeteor.com/blog
  - http://javascriptissexy.com/learn-meteor-js-properly
  - https://github.com/ericdouglas/Meteor-Learning
  - https://gentlenode.com/journal/meteor
