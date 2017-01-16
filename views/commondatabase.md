##大洋资源管理器访问 
---

大洋资源管理器的访问直接在__biandan3__中直接添加.	


###3.0大洋资源管理器数据库配置

__${classpath}__/config/mssqlDriver.properties新增数据库配置:	

	#DyCommonDatabase
	jdbc.oracle.commondatabase.url=jdbc:sqlserver://192.168.1.18:1433;DatabaseName=dycommondatabase30
	jdbc.oracle.commondatabase.name=sa
	jdbc.oracle.commondatabase.password=


###根据ClipIp获取wmv素材信息		

####接口描述:	

	package cn.com.dayang.biandan3.service;
	import cn.com.dayang.biandan3.service.to.ClipElement;

	public interface DyResourceClient {

		public ClipElement findWmvElement(String clipId);
		// ... ...
	}


####Sql语句:	
	
	use dycommondatabase30;
	select el.guidClip, el.strMainFilePath, el.emunClass, el.GuidFileStorage, fs.strFileName  
		from ClipElement as el, ClipaudioFileSerial as fs 
		where el.guidClip = '4F4AEDA2-424A-25BC-4459-735F33AFB8C5' 
			and fs.guidFileStorage = el.GuidFileStorage 
			and strFileName like '%.wmv';

####domain:

	package cn.com.dayang.resource.domain;

	public class ClipElement implements java.io.Serializable {

		private String clipId = null;
		private String name = null;
		private String folderPath = null;
		private int classType = 0;//标识素材种类:0: video,2: audtio,3: av stream
		// ... ...
	}	

<div class="info">
这部分需要使用SQLQuery来进行查询,参考文档: <br />
<a href="http://witcheryne.iteye.com/blog/1143326" target>
	http://witcheryne.iteye.com/blog/1143326
</a>	
</div>

####Action中引用接口:	

	package cn.com.dayang.biandan3.web.json;
	import cn.com.dayang.biandan3.service.DyResourceClient;
	// ... ...
	public class ClipsJsonAction extends AppAction {
		
		private String clipId = null;

		@Autowired
		private DyResourceClient resourceClient = null;
		// ... ...
	}	

<div class="notice">
<strong>注意</strong>: autowired, DyResourceClient的Spring Bean的id应该为resourceClient
</div>

###根据ClipIp获取所有素材信息	

####接口描述:	

	package cn.com.dayang.biandan3.service;
	import cn.com.dayang.biandan3.service.to.ClipElement;

	public interface DyResourceClient {

		public ClipElement findAllElements(String clipId);
		// ... ...
	}

####clipElement.classType字段描述  	

* __0__: 标识Video, 在_strReadyFilePath_中存入video中
* __2__: 标识audios, 在_strReadyFilePath_中存入audios中
* __3__: 标识av复合, 在_strReadyFilePath_中存入avStream中


###素材路径的处理

实用_ResourceFilePath_来处理素材路径:

	import cn.com.dayang.resource.to.ResourceFilePath

	// ... ...
	String filePath = "Local\\Z:\\公共域\\VIDEOAUDIO";
	ResourceFilePath path = ResourceFilePath.createInstance(filePath);

	//获取盘符
	String driver = path.getDriverChar();
	assertEquals("Z", driver);

	//移除前缀
	String realPath = path.getRealPath();
	assertEquals("Z:\\公共域\\VIDEOAUDIO", realPath);

	//获取相对路径
	String relPath = path.getRelativePath();
	assertEquals("\\公共域\\VIDEOAUDIO", relPath);	





