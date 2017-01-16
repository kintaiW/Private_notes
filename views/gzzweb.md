##采集工作站
---

###1.设备接口描述

####1.1获取所有设备  get方法：  =>api/device - GET  

参数说明:	

	{
        ParameterType: json

		
		return: {
			devices: ['deviceName 1', 'device2', .... , 'deviceName n']
		}
	}  


####1.2发送开启所有设备XML  allstart方法： =>api/cmds/allstart - POST  

参数说明:	

	{
        cmd: 'start'
        
        device : 'deviceName'
        port : '0' // 默认0
        ip : 'deviceIp'   
        
        TargetDest = "DYULC.PHEDEVICE."+ device +".FOO"; 
        cmd = queuecmd.start(device, ip, port);

        sender.queue(TargetDest, cmd.toxml);  //发送xml

		
	}


####1.3发送关闭所有设备XML  allstop方法: =>=>api/cmds/allstop - POST  

参数说明:	

	{
        cmd: 'stop'
        
        device : 'deviceName'
        port : '0' // 默认0
        ip : 'deviceIp'   
        
        TargetDest = "DYULC.PHEDEVICE."+ device +".FOO"; 
        cmd = queuecmd.stop(device, ip, port);

        sender.queue(TargetDest, cmd.toxml);  //发送xml

		
	}

###2.已解决的问题  
2.1POST form提交
使用post提交时后台头部定义  
        @Consumes("application/x-www-form-urlencoded")  
前台ajax提交使用data方法提交参数


2.2  页面可同时播放3个以上的OCX回显  
2.3  XML发送已经调通，可发送全部开启和全部关闭的XML指令

  

 
  
###3.未解决问题  
3.1由于接口未统一，无法发送开启或关闭个别设备的XML
  

