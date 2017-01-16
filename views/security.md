##biandan3的安全认证

###使用技术:

Apache Shiro v1.2.0: <http://shiro.apache.org/>	

* EverNote笔记: <https://www.evernote.com/pub/lvjian/shiro>
* References: <http://shiro.apache.org/reference.html>
* Web Support: <http://shiro.apache.org/web.html#Web-ApacheShiroWebSupport>
* API Doc: <http://shiro.apache.org/static/current/apidocs/>

###项目新增内容 	

<div class="notice">
新增内容见
	<a href="https://www.evernote.com/pub/lvjian/shiro">
		EverNote笔记
	</a>
中的《biandan3项目中集成Shiro - SSH + Apache Shiro》	
</div>

###Shiro中的登陆

biandan3的登陆已经迁移到Shiro下,详情见:  
cn.com.dayang.auth.webwork.action.AppAction;	

__核心代码:__
	
	UsernamePasswordToken token = new UsernamePasswordToken(name, password);

	try {
		SecurityUtils.getSubject().login(token);
			
		Subject subject = SecurityUtils.getSubject();
			
		String userId = (String)subject.getPrincipal();
		User user = userService.getById(userId);
		Session session = subject.getSession(true);
		session.setAttribute(LoginAction.USER_KEY, user);
			
	} catch (AuthenticationException e) {
		this.addActionError("invalid username or password. Please try again.");
	}
	
__页面中如何获取User:__	

1.ServletContext:

	${currentUser}

2.非Servlet上下文:

	User user = (User)SecurityUtils.getSubject()
		.getSession().getAttribue(LoginAction.USER_KEY);

###基于urls过滤的权限配置

${classpath}/spring/shiro.xml中配置urls相关信息:  
_bean#shiroFilter > property[@filterChainDefinitions] > value_ 中配置urls

	<bean id="shiroFilter" class="org.apache.shiro.spring.web.ShiroFilterFactoryBean">
		<!-- ... ... -->
	    <property name="filterChainDefinitions">
	        <value>	      
	        	# static file chains
	        	/js/* = anon
	            /css/* = anon
	            /img/* = anon
	            /images/* = anon
	            /applets/* = anon
	          	
	          	# login/logout chain
	          	/login.action = anon
	          	
	            # some example chain definitions:
	            /admin/** = authc, roles[admin]
	            /docs/** = authc, perms[document:read]
	            
	            /** = user
	            # more URL-to-FilterChain definitions here
	        </value>
	    </property>
	</bean>

<div class="notice">
	如何配置urls,参考: <a href="http://shiro.apache.org/web.html#Web-webini">Web Ini Configuration</a>
</div>

### User & ShiroUser说明		

项目设计暂时放弃合并User的想法，User对应netmanage-rest中获取的用户信息，ShiroUser是BS网管内部的用户。

* User只包含大洋网管的数据
* ShiroUser包含BS网管角色和权限信息。 
* ShiroUser通过dyId与User进行对应。
* 登陆时，会将User和ShiroUser放到Session中	




[shiro]: http://shiro.apache.org/ "Apache Shiro"
[biandan3-shiro]: https://www.evernote.com/pub/lvjian/shiro "shiro in biandan3"