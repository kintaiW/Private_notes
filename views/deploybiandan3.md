##biandan3部署说明
---



###1. 部署环境:	

* __操作系统__: Window Server 2003/2008, Linux  
* __Java环境__: JDK 1.6 或以上  
* __Tomcat环境__: Tomcat 6.x 或以上
	1. 请不要选择Tomcat5.5安装版
	2. Tomcat的使用请参考[《Tomcat环境配置 for Dayang》][tomcat]
* __数据库__: SQL Server 2005 或 Oracle  
* __流媒体服务器__: 提供素材播放功能
*  __FTP服务器__: 提供素材上传功能，可以有多个FTP发布点

<div class="notice">
	<strong>注意:</strong>
	在部署前请先确保仔细阅读过
	<a href="http://nodeblog.cloudfoundry.com/blogs/tomcat_environment">
		《Tomcat环境配置 for Dayang》
	</a>
</div>

###2. 部署内容	

* __biandan3__: 项目文件
* __DYULC30WebService__(必须): C/S收录WebService，提供如下功能
	1. 收录任务的生成，即"预约单" -> "正式任务"
	2. 3.0中素材路径的获取
* __netmanage3-rest__(默认): 3.0网管WebService, 仅提供给B/S用, 提供如下功能
* __netmanage2-rest__(可选): 2.0网管WebService, 部署2.0网管项目时需要用这个WebService,对应DYNetmanage20和DYUserVerify20
* __DyeResourceInfo__(可选): 2.0资源管理器WebService, 对应DYCommonDatabase20

###3. 术语约定	

1. __[内容]__ : 使用大括号括起来的是需要填写的内容, 不需要保留大括号
	* 例如: [项目名称]/WEB-INF/classes, 如果是biandan3项目, 则是 __biandan3__/WEB-INF/classes
2. __${变量名称}__ : 这个是变量名称, 各种变量约定如下
	* __${project}__: 代表项目文件夹, 如biandan3项目的${project}则是{biandan3/}
	* __${classpath}__: 代表${project}/WEB-INF/classes文件夹: 例如: biandan3的${classpath}: biandan3/WEB-INF/classes
	* __${tomcat}__: 代表tomcat根目录

###4. 部署netmanage3-rest
---	

本项目提供3.0资源管理WebService

####4.1 提供功能 	

1. 用户验证
2. 获取用户信息
3. 获取业务域信息
4. 获取资源域信息

####4.2 安装	

1. 将netmanage3-rest.war 复制到_${tomcat}/web-apps_文件夹中，然后启动tomcat。此时tomcat会将netmanager-rest.war解压缩。
2. 关闭tomcat
3. 配置数据库链接:	

打开${classpath}/jdbc-netmanage30.properties文件,修改如下内容:	

	jdbc.db-netmanage30.url=jdbc:sqlserver://192.168.1.18:1433;DatabaseName=DYNetManage30_20110722
	jdbc.db-netmanage30.username=sa
	jdbc.db-netmanage30.password=

将__DatabaseName__, __username__, __password__ 替换成本地环境即可。

4. 开启tomcat, 访问<http://localhost:8080/netmanage3/>, 如果能看到如下页面，则标示可以正常使用:	

![netmanage3访问成功](/images/deploybiandan3/login.png "Login")

####4.3 测试项目	

#####4.3.1 测试登陆:	

1. 在首页输入正确的用户名密码，则会看到如下页面:	

	![登陆成功](/images/deploybiandan3/login-suc.png "Login Success")		

2. 如果登陆失败,则会看到如下页面:	

	![登陆失败](/images/deploybiandan3/login-fail.png "Login Fail")		


###5. biandan3项目部署
---	

####5.1 安装	

将biandan3.zip解压缩到 __${tomcat}/web-apps__ 目录即可。

####5.2 配置项目	

#####5.2.1 配置文件说明:	

配置文件都在${classpath}/config目录下:	

* mssqlDriver.properties: SQL Server数据库的配置
* netmanage_url.properties: 配置网管WebService访问地址
* ws.properties: 配置DYULC30WebService访问路径
* mms.properties: 配置流媒体播放服务器访问地址
* version.properties: 配置网管/资源管理器的版本信息，默认是3.0(不需要改动)


#####5.2.2 配置数据库链接 	

打开__${classpath}/config/mssqlDrvier.properties,按照说明修改相关内容即可。

######5.2.3 配置网管WebService 	

打开__${classpath}/config/netmanage_url.properties__文件,  
修改如下项:	

	netmanage.version=3
	rest.netmanage3.uri=http://192.168.1.6:9095/rest/	

修改为:	
	
	netmanage.version=3
	rest.netmanage3.uri=http://localhost:8080/netmanage3-rest/rest/		

######5.2.4 配置网管WebService访问地址 	

打开__${classpath}/config/ws.properties__文件, 
将如下项修改成本地环境即可:	
	
	dyul30webservice.uri=http://192.168.1.45:2178/DYUlcWebService 	

######5.2.5 配置流媒体服务器链接	

<div class="info">
暂时不需要,coming soon...	
</div>

######5.2.6 配置流媒体服务器链接	

<div class="info">
暂时不需要,coming soon...	
</div>


[tomcat]: http://nodeblog.cloudfoundry.com/blogs/tomcat_environment "Tomcat配置说明"