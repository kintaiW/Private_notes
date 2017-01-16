##迁移申请
---

在浏览素材的时候进行迁移操作。主要用于不同制作网之间的素材共享。支持如下功能:	

* 迁移到FTP(福州台), 即选择任务分类
* 迁移到制作网(广州台, 北京台)
* 迁移到主干(北京台)
* 打点迁移(在浏览素材的时候需要选择入/出点)	

###1. 接口定义	

namespace: /downloads/*	

####1.1 创建IpDownloadTask: => /downloads/create.action - GET
	
	{
		params: {
			taskId: '36位收录任务ID',			
			clipId: '素材ID',
			clipName: '素材名,Clip中获取的',
			trimIn: 0,
			trimOut: 0
		}, //params中得数据都由素材浏览页面准备
		return: {
			taskClass: [TaskClassInfo],
			form: IPTaskForm,
			forward: {
				success: '/downloads/create.jsp'
				error: '/downloads/error.jsp'
			}
		}
	}	

####1.2 保存IpDownloadTask: => /downloads/save.action - Post
	
	{
		params: {
			//看本文档3.1部分的描述
		},
		return: {
			form: IPTaskForm,
			forward: {
				success: '/downloads/show.action?ipTaskId=${ipTaskId}',
				error: '/downloads/error.jsp'
			}
		}
	}	

####1.3 查看IpDownloadTask: => /downloads/show.action?id=${0} - GET	
	
	{
		params: {
			ipTaskId: ''
		},
		return: {
			form: IPTaskForm,
			forward: {
				success: '/downloads/show.jsp',
				error: '/downloads/error.jsp'
			}
		}
	}	


###2. 数据结构

####2.1 涉及数据	

* __SQL2005数据库__: DYIPExchange@192.168.1.47
* __迁移/下载任务__: cn.com.dayang.biandan3.domain.IpDownloadTask [IpDownloadTask] 	
* __接受表单的Form__: cn.com.dayang.biandan3.web.to.IPTaskForm
* __Strut2 Action__: cn.com.dayang.biandan3.web.action.IpDownloadTaskAction


####2.2 domain结构

	public class IpDownloadTask {
		//迁移任务Guid
		private String guiddownloadtask;
		//迁移任务名称,默认收录名称, 根据ulcTaskId获取
		private String strtaskname;

		//设置目标类型
		private long enumdesttype = 2L; //0:下载任务, 2:迁移任务

		//素材信息
		private String asguidclip;//素材Guid
		private String asclipname;//素材名称,对应ULCClipData|ULCClipPart

		//任务分类信息, [任务分类ID,任务分类名称]
		//北京台,还需要选择拥有者信息
		private String strprocess;		
		private String strprocessownerid;//北京台需求
		private String strprocessownerName;//北京台需求

		//申请理由
		private String applyReason;

		//入出点信息
		private long bsettrim = 0L;// 标示是否有入出点信息
		private String asdwtrimin = "0";//入点
		private String asdwtrimout = "0";//

		//迁移任务提交者相关信息，即当前登陆人员
		private String strsponserid;
		private String strsponserName;
		//去掉了提交者栏目

		//时间相关信息
		private Date odtcreatetime;//迁移任务创建时间
		private Date odtendtime;//设置于开始时间相同即可
		
		//迁移文件信息描述
		private String strreadyfilepath;// xml

		// ... ...
	}

####2.4 strReadyFilePath字段格式描述

将素材的路径信息封装成如下xml,然后存入strReadFilePath字段:

	<?xml version="1.0" encoding="UTF-8"?>
	<ReadyFilePath>
		<clipGuid></clipGuid>
		<clipName></clipName>
		<vaStream></vaStream>
		<video></video>
		<audioes></audioes>
		<!-- 是否是hd, 0是, 废弃字段 -->
		<isHD>0</isHD>
	</ReadyFilePath>	

video/avStream/audioes中存放的是资源管理器中的路径信息, 多个则以","号分隔:	
	
	String path = strFileFolderPath + "\\" + strFilename;
	//e.g: Local\\M:\\folder\\ok.wmv	
	
	
<div class="notice">
	使用<b>IPTaskHelper.generateReadyFileXml(...)</b>方法生成，详情见[4.1-IPTaskHelper工具类描述]
</div>


生成正确应该是如下格式:	

	<?xml version="1.0" encoding="UTF-8"?>
	<ReadyFilePath>
		<clipGuid>32位ID</clipGuid>
		<clipName>OK(03_05)</clipName>
		<vaStream>Local\\M:\\folder\\ok.wmv,Local\\M:\\folder\\ok.ts</vaStream>
		<video>Local\\M:\\folder\\ok.avi</video>
		<audioes>Local\\M:\\folder\\ok.wav,Local\\M:\\folder\\ok.wav</audioes>
		<!-- 是否是hd, 0是, 废弃字段 -->
		<isHD>0</isHD>
		<!-- backup 节点用来支持双读双写, 2013-01-11 -->
		<backup>
			<vaStream>Local\\M:\\folder\\ok.wmv,Local\\M:\\folder\\ok.ts</vaStream>
			<video>Local\\M:\\folder\\ok.avi</video>
			<audioes>Local\\M:\\folder\\ok.wav,Local\\M:\\folder\\ok.wav</audioes>
		</backup>
	</ReadyFilePath>	



###3. 数据输入

####3.1 表单信息

	{
		{name: 'ipTaskId', property: 'guiddownloadtask'},
		{name: 'ipTaskName', property: 'strtaskname', desc: '于ULCTask.strname相同'},

		{name: 'clipId', property: 'asguidclip'},
		{name: 'clipName', property: 'asclipname', desc: '对应ULCClipDate|ULCClipPart'},		

		{name: 'trimIn', property: 'asdwtrimin', type: 'int'},
		{name: 'trimOut', property: 'asdwtrimout', type: 'int'},

		{name: 'process', property: 'strprocess', desc: '选择任务分类,北京台读取ini'},
		{name: 'applayReason', property: 'applyReason'}
	}

####3.2 表单初始化数据

	{

	}

####3.3 后台填写信息 
	{
		{name: 'destType', property: 'enumdesttype', type: 'int', value: 2},
		{name: 'sponserId', property: 'strsponserid', value: loginUser.id},
		{name: 'sponserName', property: 'strsponsername', value: loginUser.name}
	}	

####3.4 迁移去项(即，任务分类组件)	

可以直接使用pretasks/field/_taskClass.jsp组件
	
	<%@ page language="java" pageEncoding="UTF-8"%>
	<%@ taglib uri="/struts-tags" prefix="s"%>

	<select name="taskClass" id="taskClass">
		<option value="">
			<s:text name="form.pretasks.category.none" />
		</option>
		<s:iterator id="classes" value="ulcLoader.taskClasses" status="stataus">
			<s:if test="[1].guidtaskclass == null || [1].guidtaskclass.equals('')">
				<option value='<s:property value="classguid + ',' + taskclassname"/>'>
					<s:property value="taskclassname"/>
				</option>
			</s:if>
			<s:elseif test="[1].guidtaskclass.equals(classguid)">
				<option value='<s:property value="classguid + ',' + taskclassname"/>' selected>
					<s:property value="taskclassname"/>
				</option>
			</s:elseif>
			<s:else>
				<option value='<s:property value="classguid + ',' + taskclassname"/>'>
					<s:property value="taskclassname"/>
				</option>
			</s:else>
		</s:iterator>
	</select>	


###4. 工具类

####4.1 IPTaskHelper - IpDownloadTask工具类

	package cn.com.dayang.biandan3.domain.helper;
	//... ...
	public class IPTaskHelper {
		/**
		 * 设置IpDownloadTask任务入出点信息，该方法不会重新创建对象
		 * @param ipTask
		 * @param in 入点
		 * @param out 出点
		 * @return 返回传入的ipTask引用
		 */
		public static IpDownloadTask setTrimInOut(IpDownloadTask ipTask, 
				int in, int out);
		
		/**
		 * 返回的xml格式见本文的: 2.4 章节
		 * @param clip
		 * @param clipEls
		 * @return
		 */
		public static String generateReadyFileXml(Clip clip, 
				List<ClipElement> clipEls);
		// ... ...
	}	

####4.2 IPTaskForm - 迁移任务的FormBean

	package cn.com.dayang.biandan3.web.to;
	// ... ...
	public class IPTaskForm {
		// ... ...
		/**
		 * 从IpDownload创建FormBean
		 * @param ipTask
		 * @return
		 */
		public static IPTaskForm fromDomain(IpDownloadTask ipTask);

		/**
		 * FormBean 生成IpDownloadTask对象
		 * @return
		 */
		public IpDownloadTask to_domain();
		// ... ...
	}	



