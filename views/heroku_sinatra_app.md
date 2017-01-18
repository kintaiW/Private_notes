##heroku部署sinatra说明
---


###1. 部署环境
* __操作系统__: Ubuntu14.04.5  
* __Ruby环境__: 2.3.0p0(2015-12-25 revision 53290)
* __云服务器__: Heroku


###2. 部署内容
* __app.rb__: 项目文件
* __views__(目录): 内容,markdown文档  
	* 文章格式:首行必须以 "##" 开头(标记及在markdown中用于描述h2标签)
* __public__(目录): 前端,图片资源  
* __config.ru__: 配置文件
	* 根据Heroku文档要求,必须指定Sinatra 


###3. coming soon 
