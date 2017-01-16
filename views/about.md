##About this app
---	

###Why create this web site?	

这个应用主要用来纪录收录组文档。采用markdown语法编写内容，方便排版。	

作者: 吕健  
内容提供者: 吕健, 王毅飞  


###Technology	

* __markdown语法__: <http://qingbo.net/picky/502-markdown-syntax.html>
* __代码高亮PrettifyJS__: <http://google-code-prettify.googlecode.com/>
* __Ruby 1.9.2__: <http://ruby-china.org/wiki>
* __Sinatrarb__: <http://www.sinatrarb.com/intro-zh.html>
* __Ruby Gems__:
	* _discount_: 提供markdown语法解析功能
	* _json:_ 提供json解析功能
	* _thin_: Ruby的Web服务器，加快Sinatrarb运行速度	
	* _chinese\_pinyin_: 提供汉字转拼音功能
* __CodeMirror2__: <del>提供在线代码编辑功能,支持ipad</del>
	* <http://codemirror.net/>
* __jQuery__: 1.7.1
	* _quicksearch_: 提供ul/table过滤功能 <https://github.com/riklomas/quicksearch>
	

###Tools	

* __Git__: 版本控制工具，用于记录文档的版本信息
	* <http://progit.org/book/zh/>
* __Sublime Text 2__: 跨平台的CodeEditor(推荐)
	* <http://www.sublimetext.com/2>
* __TextMate__: Mac OS上的CodeEditor
* <del>__MarkdownPad__: Window平台下的可视化markdown编辑器(下载很慢噢!)</del>
	* <del><http://markdownpad.com/></del>


###RoadMap

####0.1.0 

* 支持markdown语法解析
* 支持代码语法高亮
* 支持文章列表显示，需要手动修改views/layout.erb文件
* 使用git对文章进行管理和存储

####0.2.x

* 根据首行2号标题的内容生成, 自动生成文章列表。
* 根据文件名,自动生成文章的url链接
* 解决window下的运行问题(?)
* 文章列表中自动高亮当前正在阅读的文章

####0.3.x(current)

* 支持按拼音过滤标题(support)
* 记忆上一次访问的页面
* <del>支持Tag功能</del>
* <del>支持Tag过滤</del>
* <del>在服务器保存文章列表</del>

####0.4.x	

* <del>在线编辑</del>
* <del>服务器端自动Git提交</del>
* 支持IE8以上的浏览器
* <del>支持ipad访问, 支持横屏竖屏两种模式</del>
