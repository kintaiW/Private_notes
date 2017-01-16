##大洋播放器ActiveX
---

一个很恶心，但又不得不用的mms流媒体播放器。支持视频打点。只能在Win + IE环境夏使用。

由北京技术研究提供,在biandan项目中被使用。

###1. 文件组成&安装

####1.1 最新版本

* __D3BSPlayerU.cab__: 提供自动安装包，封装ocx；
* __D3BSPlayer-2.0.1.1.exe__: 手动安装包，在客户无法自动安装的时候使用；  

以上文件可以在__biandan__和__biandan3__的__${web-root}/clip__目录夏找到.

####1.2 安装问题

安装后如果出现无法加载情况，需要降低IE的安全属性

###2. 如何使用

####2.1 如何在jsp中加载

	<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<%
	String path = request.getContextPath();
	%>
	<script type="text/javascript">
		$(document).ready(function(){
			if(!$.browser.msie) {
				$('#playerWrapper').html('<p>对不起，播放器目前支持IE浏览器，您当前使用的浏览器不被支持，无法进行视频播放。<p>');
			}
		});
	</script>
	<div id="playerWrapper">
		<object id="player" name="player" 
			classid="CLSID:A7CE02E8-0081-424E-8F15-963B5CC359E0" 
			codebase="<%=path%>/clip/D3BSPlayerU.cab" 
			height="410" width="640" 
			style="background-color: black"> 
		</object>
		<div id="player-download" style="padding: 5px; 10px; font-size: 12px;">
			&nbsp;
			<a href="<%= path%>/clip/D3BSPlayer-2.0.1.1.exe">
				如果不能正确加载播放器，请点击这里下载安装程序
			</a>
		</div>	
	</div>	

####2.2 如何使用
	
	<script type="text/javascript">
		player.open('mms://192.168.1.6/*/clipname', 0, 0);
	</script>

####2.3 监听事件
	
	<!-- 打开流成功后立即播放 -->
	<script for=player event=OpenFinish(bFlag) type="text/javascript"> 
		player.Play();
	</script>
	<!-- 删除入出点, 清空打点信息 -->
	<script for=player event=DelInOut type="text/javascript">		
		$('#ipt-trimin, #ipt-trimout').val(0); 
	</script>
	<!-- 打入点 -->
	<script FOR=player Event=TrimIn(inpoint) type="text/javascript">
    	$('#ipt-trimin').val(inpoint);
	</script>
	<!-- 打出点 -->
	<script FOR=player Event=TrimOut(outpoint) type="text/javascript">
        $('#ipt-trimout').val(outpoint);
	</script>
	

	