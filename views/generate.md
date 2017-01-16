##生成正式任务 - biandan3
---

###1. 响应反馈	

####1.1 反馈xml定义

	<ingestTasksReport ReportType="1" >	 
		<errorItemInfo ContentID="66666688888888" 
			ProgramID="3333377777" 
			ItemID="5555556666" 
			TaskID="A51684FF-DE9D-4002-A900-105E46B768F9" 
			ErrorType="1001" 
			ErrorInfo="冲突检测失败，无足够客户端采集"/> 
		<!-- others -->
		<errorItemInfo />
	</ingestTasksReport>
	
<div class="notice">
	<b>TaskID</b>字段会存到PreTaskInfo.taskId字段
</div>

####1.2 参数说明

* TaskID: 生成的正式任务的ID
* ErrorType: 错误类型
* ErrorInfo: 反馈信息

####1.3 ErrorType 和 ErrorInfo 对应关系

0  
执行成功	

1001  
添加任务冲突检测失败，开始时间晚于结束时间	

1002  
添加任务冲突检测失败，无可用采集设备（在此任务时间段内设备都被占用，即任务数已达到最大，每个采集设备支持同时10个任务采集）  	

1003  
此任务已经执行，不能修改和删除	

1004  
必填字段有非法值（具体反馈的时候会带上那个字段)	

1005  
其他错误描述（可扩展)	


### 输入参数:	

	<ingestTask Method='addTask' SignalType='' TaskType='1'
	TaskSource='biandan'>
	<taskContent ContentID=''>
		<programInfo>
			<programItem ProgramID=''
				TaskID='cbe1c7bc-7e8c-47eb-ac19-06b519ac3a67' ProgramName='123123123_07_03'
				StartDate='20120712163500' StopDate='20120712170500' PriorityType='1'
                    Hint='' ProgramPath='' />
            </programInfo>
            <mediaInfo>
                <mediaItem ItemID='' SignalURL='' SignalPort='' SignalPID=''>
                    <sourceInfo SignalID='4E81815C-0312-E730-4459-51F8206E65FC'
                        SignalName='SDI信号1' />
                    <streamingMediaInfo VAFormatID='09DF9AF7-4236-4EDF-4459-15C7FDD80DD7'
                        VAFormatName='0915ts' FileFormatType='' VideoCodec=''
                        SubVideoCodec='' AudioCodec='' />
                    <mediaExtentInfo />
                    <clipPathInfo OwnerID='83cc1c38-c9d5-4109-93a4-3af621dbb9a4'
                        OwnerName='lxl' BizDomainID='3109E58C-AED0-4770-A2DE-B069D6BAF78F'
                        BizDomainName='test' ProjectID='A144F40A-4289-427C-ACAE-FA250E59D0D2'
                        ProjectName='公共域' ResPathID='' ResPathName='123123'
                        Ower20ID='83cc1c38-c9d5-4109-93a4-3af621dbb9a4' Owner20Name='lxl'
                        Res20PathID='' />
                    <destDeviceInfo CapDeviceID='                                    '
                        CapDeviceName='' />
                    <taskExtInfo IfCycleTask='1' CycleType='1'
                        CycleStartDate='20120703163500' CycleStopDate='' IntervalTime='1'
                        ActDayInWeek='42' ActDayInMonth='0' ActDayInYear='0'
                        TaskClassID='4EA0DC37-6367-7EC3-4459-AED8CDB6E960'
                        TaskClassName='aq2                                                                                                                             '
                        IfCapSeg='0' CapSegTime='30' IfBcbb='0' FreshFreq='' IfImportant='0'
                        IfTechAudit='0' IfConfirmed='1' InputMatrixPortName='' IfBackup='0'
                        OrgTaskID='' SatParam='' IfNeedTans='0' TransDelayTime='0'
                        BianMuInfo='' NeedPartInsertDB='0' IfSaveExplorer='0'
                        NeedAutoImportPart='0' 
                        Reseave1='' 
                        Reseave2='' />
                </mediaItem>
            </mediaInfo>
        </taskContent>
    </ingestTask>   

###2. 收录任务字段说明

####任务状态:   

    public static final int SLEEP_RUNSTATUS_TASK = 0;//休眠
	public static final int WAITING_RUNSTATUS_TASK = 1;//等待执行  未分配 没
	public static final int EXECUTING_RUNSTATUS_TASK = 2;//执行中 绿
	public static final int FINISHED_RUNSTATUS_TASK = 3;//执行完成 蓝色
	public static final int ERROR_RUNSTATUS_TASK = 4;//执行出错 橙
	public static final int CANCELED_RUNSTATUS_TASK = 5;//取消执行 
	public static final int DISTRIBUTED_RUNSTATUS_TASK = 6;//已被总控分配 已分配 灰色   
    
###3. 更新说明  

####2012-07-05
---

taskExtInfo 节点新增如下属性:   

    NeedPartInsertDB ="0"  IfSaveExplorer ="0" NeedAutoImportPart ="0"  

from 王毅飞:    

1. Method：添加正式任务：“AddTask”，修改正式任务：“ModTask ”
2. ContentID ：添加正式任务为空，修改正式任务：taskinfoguid 
 
添加：  

1.clipPathInfo 节点 

    ResPathName: task.projectPathUrl    

2.taskExtInfo 节点：

    NeedPartInsertDB: task?.bneedpartinsertdb,  
    IfSaveExplorer: task?.bifsaveexplorer,  
    NeedAutoImportPart: task?.bneedautoimportpart   





