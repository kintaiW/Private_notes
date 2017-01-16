##sitemesh	
---

###页面模版代码： 导入sitmesh.jar包   定义decorators包，main.jsp


例如：	



	<%@ page contentType="text/html; charset=UTF-8"%>
	<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%> 
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib uri="/struts-tags" prefix="s"%>
	
	<!DOCTYPE html>
	<html>
	  <head>
	    <meta charset="utf-8">
	    <title><decorator:title default="装饰器页面..." /></title>
	    <meta name="description" content="">
	    <meta name="author" content="">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">    
	
	    <!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
	    <!--[if lt IE 9]>
	      <script src="js/libs/modernizr-1.7.js"></script>
	    <![endif]-->
	
	    <!-- Le styles -->
	    <link href="/biandan3/css/bootstrap.css" rel="stylesheet">
		<link rel="stylesheet" href="/biandan3/css/home.css" type="text/css" media="screen">
	    <style type="text/css">
	      body {
	        padding-top: 60px;
	      }
	    </style>
	
	    <!-- Le fav and touch icons -->
	    <link rel="shortcut icon" href="/biandan3/images/favicon.ico">
	    <link rel="apple-touch-icon" href="/biandan3/images/apple-touch-icon.png">
	    <link rel="apple-touch-icon" sizes="72x72" href="/biandan3/images/apple-touch-icon-72x72.png">
	    <link rel="apple-touch-icon" sizes="114x114" href="/biandan3/images/apple-touch-icon-114x114.png">
	
		<script src="/biandan3/js/libs/jquery/1.7.1/jquery.js" type="text/javascript" charset="utf-8"></script>
		<script src="/biandan3/js/libs/bootstrap/bootstrap-tabs.js" type="text/javascript" charset="utf-8"></script>
		<script src="/biandan3/js/libs/bootstrap/bootstrap-buttons.js" type="text/javascript" charset="utf-8"></script>
		<script src="/biandan3/js/libs/bootstrap/bootstrap-twipsy.js" type="text/javascript" charset="utf-8"></script>
		<script src="/biandan3/js/libs/bootstrap/bootstrap-popover.js" type="text/javascript" charset="utf-8"></script>
		<script src="/biandan3/js/libs/bootstrap/bootstrap-modal.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript" defer="defer" src="/biandan3/js/datepicker/WdatePicker.js"></script>
		
	  </head>
	
	  <body id="<decorator:getProperty property="body.id" />" >  
	  	
	          
	          <p class="pull-right">
					当前登录: 
					<a href="#">lvjian</a> | 
					<a href="#quit">退出</a>
			  	</p>
	        </div>
	      </div>
	    </div>
	
	    
	      <div class="content">
				<ul class="breadcrumb">
					<li><a href="#">收录任务</a> <span class="divider">/</span></li>
					<li class="active">我的收录任务</li>
				</ul>
	
				<!-- Main hero unit for a primary marketing message or call to action -->		
	        <decorator:body />
	        <footer>
	          <p>&copy; Company 2011</p>
	        </footer>
	      </div>
	    </div>
	
	  </body>
	</html>




###WEN-INFO中定义配置文件decorators.xml	

例如：	

	
	<decorators defaultdir="/decorators">
		<excludes>
			<pattern>/index.jsp</pattern>
		</excludes>
	       <decorator name="main" page="main.jsp">
	           <pattern>*</pattern>
	       </decorator>
	</decorators> 

	
###web.xml中添加filter配置

例如：	

    <filter>
		<filter-name>sitemesh</filter-name>
		<filter-class>com.opensymphony.module.sitemesh.filter.PageFilter</filter-class>
	</filter>

	<filter-mapping>
		<filter-name>sitemesh</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>

  
  







