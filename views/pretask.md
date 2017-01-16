##收录预约编单

###测试用户

项目暂时未添加用户登陆控制的功能，暂时使用如下用户:

* _ID_: 0B35A236-D174-4388-9CD2-C4E42215F0C0	
* _用户名_: fy

###特殊字段说明

####1. odtperferdate
创建时间, createDate, 在创建的时候被设置。	

####2. dwduration
任务时长，使用fps表示, 一般 25 fps/s.  
可以调用 _getLengthStr()_ 方法来获取 00:00:00:00 (h:m:s:fps) 格式的数据。	

#####2.1 getLengthStr()方法:	
	
	public String getLengthStr() {
		lengthStr = CommonUtils.frameToTime(this.dwduration);

		return lengthStr;
	}	
#####2.2 CommonUtils

在转换的时候需要使用调用_cn.com.dayang.biandan3.common.CommonUtils_中的方法: 

#####2.2.1 普通调用:	

	import cn.com.dayang.biandan3.common.CommonUtils;
	// ... ...
	CommonUtils.frameToTime(dwduration);	
	
#####2.2.2 在Struts 2页面中调用:
	
	<%-- ... ... --%>
	<s:bean name="cn.com.dayang.biandan3.common.CommonUtils" var="commonUtils">
	</s:bean>
	<%-- ... ... --%>
	<s:property value="#commonUtils.frame2time(dwduration)"/>	
	
	
###如何在biandan3中取2.0网管的用户树

#### /users/json/tree.action - GET

cn.com.dayang.biandan3.web.json.UserTreeJsonAction中实现该接口  

输出的json格式:	

	{	
		version: '2',
		//string 类型, 需要使用JSON.parse转换
		data: [{...},{....}, ...] 
	}	
	
data 格式
