##流媒体配置说明
---

###1. 概述

####1.1 功能描述

* 支持多网段多发布点映射
* 支持多盘符映射

####1.2 相关文件

* __配置文件__: ${classpath}/config/mms.properties
* __配置读取类__: cn.com.dayang.biandan3.common.MMSConfigReader
* __JUnit测试__: biandan3.common.MMSConfigReaderTest

####1.3 程序中的用法:
	
	String userIp = "172.19.0.15";
	String videoDriver = "M";//素材所在盘符
	MMSConfigReader mms = MMSConfigReader.getInstance();
	String mmsUrl = mms.getMMSURI(userIp, videoDriver);

###2. 如何配置

####2.1 mms.properties文件中修改
	
	#filename: stream_media.properties, encoding=UTF-8
	#encoding: utf-8
	#配置流媒体服务器映射关系
	#网段的配置,多个以逗号分割
	mms.mappings=172,10,59

	#于mms.mappings中的内容相对应,规则如下:
	# mms.ip.[mappingsItem]
	# 如, 172 要对应 172.19.0.150
	# 	则 mappingsItem = 172
	mms.ip.172=172.19.0.150
	mms.ip.10=10.172.1.150
	mms.ip.59=59.56.179.66

	# 如果找与mappings的对应关系
	# 则默认选择default
	mms.ip.default=172.19.0.150

	# 配置网络盘符名称
	mms.drivers=m,n

	# mms.uri.[driverName], 其中driverName需要与mms.drivers中的对应
	# "%1$s" 为ip的占位符，不用处理
	mms.uri.m=mms://%1$s/m/*
	mms.uri.n=mms://%1$s/n/*

	#以上uri都无匹配的时候，默认采用这个地址
	mms.uri.default=mms://%1$s/FZTV-Media/*