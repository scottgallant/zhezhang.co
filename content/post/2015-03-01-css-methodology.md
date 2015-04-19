+++
date = "2015-03-01"
title = "CSS Methodology"

+++

怎样去写 CSS ？

CSS 很容易，可如何清晰地组织编写 CSS，有很多种方法论（Methodology）：BEM、OOCSS、SMACSS 和 SUIT CSS 等。你会为下一个项目选择哪种方法呢？自己的项目或者你所在的团队的项目，都在使用什么方法来组织、命名和编写 CSS 文件呢。

#### 方法论（Methodology）

方法论不是为 W3C 的 CSS 标准规范本身添加了新内容，而是如何组织编写开发清晰、易读、易理解、可扩展的 CSS 文件和命名规则的一种约定。不论是自己一人的项目，还是多人合作的项目，尤其对于后者，一个有共同约定的条理清晰的合作方式，更能让整个项目的开发团队有更良好的工作效率。随着项目不断壮大，代码的复杂程度也不断增加，有必要建立一套这样的方法论。

目前，已经很流行的 CSS 方法论有：

- OOCSS https://github.com/stubbornella/oocss/wiki
- BEM https://en.bem.info/method/
- SMACSS https://smacss.com
- SUIT CSS https://github.com/suitcss/suit

当然，这只是所有方法论中特别流行的几种，不管你选择哪种方法，或者不选择任何方法，在你编写 CSS 时，请都要保持一致。代码不是写好能用就完事，是要维护，是要扩展的。尤其在多人协作开发的团队中，减少维护成本，特别重要。

如果你感兴趣，同时看看其他人是怎么写 CSS 的吧：

- [GitHub’s CSS](http://markdotto.com/2014/07/23/githubs-css/) - @mdo
- [CodePen’s CSS](http://codepen.io/chriscoyier/blog/codepens-css) - Chris Coyier
- [CSS at Groupon](http://mikeaparicio.com/2014/08/10/css-at-groupon/) - Mike Aparicio
- [CSS at Lonely Planet](http://ianfeather.co.uk/css-at-lonely-planet/) - Ian Feather
- [Medium’s CSS is actually pretty f***ing good.](https://medium.com/@fat/mediums-css-is-actually-pretty-fucking-good-b8e2a6c78b06) - @fat
- [CSS at Hootsuite](http://code.hootsuite.com/css-at-hootsuite/) - Steve Mynett
- [Buffer's CSS](http://blog.brianlovin.com/buffers-css/) - Brian Lovin
- [CSS at Trello](http://blog.trello.com/refining-the-way-we-structure-our-css-at-trello/) - Bobby Grace

看看这些网站，运用了不同的 CSS 方法，不同的 preprosessor，不同的文件结构和命名规则，就像用相似的食材（CSS 样式属性），用不同的工具和烹饪方法（SASS/LESS/Stylus、Linting、Prefixing 等），做出味道不同但同样美味可口的菜肴，现在该你自己决定，喜欢什么口味了。
