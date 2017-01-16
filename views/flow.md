##收录监控流程显示
---

###流程定义

表ULCSystemConfig，enumConfigType=16,strConfigValue=	

	<SDYFlowProcessNote>
		<arrFlowType>
			<SDYFlowSetTypeNote>
				<!-- value text -->
				<strName>Flow.TaskCompile</strName>
				<!-- display text -->
				<strModule>编单模块</strModule>
			</SDYFlowSetTypeNote>
			<SDYFlowSetTypeNote>
				<strName>Flow.TaskManage</strName>
				<strModule>总控模块</strModule>
			</SDYFlowSetTypeNote>
			<SDYFlowSetTypeNote>
				<strName>Flow.IngestClient</strName>
				<strModule>采集模块</strModule>
			</SDYFlowSetTypeNote>
		</arrFlowType>
	</SDYFlowProcessNote>
	
	var arrFlow = [{name: '', display: ''}, {}, {}]
	arrFlow[0] -> arrFlow[1] -> arrFlow[2]
	
###流程历史纪录, ULCOperateFlow 

    /////////////////////////////////////////////////////////////////////////////
    //收录相关操作流程信息
    //以下为DYULCOperateFlow表结构
    typedef struct tagDYULCOperateFlow
    {
        CString  strIndexGuid;//索引DY_GUID(KEY)

        //关联类型  值参看 DYULC_LINKTYPE   没有必要了  因为 Flow.IngestClient.Running  包含了模块 
        int  iLinkType;        
        CString  strLinkGuid;//关联guid
        int      iOrderNum;//序号
        CString  strUsePerson;//操作人
        COleDateTime  odtUseTime;//操作时间
        CString  strUseRemark;//操作备注
        int      iUseState;//操作方式     可以记录  迁移进度

        //操作方式名称  对应具体名称  eg. Flow.IngestClient.Running  这个地方按照吕建的建议  既可以表示模块，又同时包含具体流程
        CString  strUseState;
        CString  strFlowContent;//此操作相关信息 比如审核、出错信息

        tagDYULCOperateFlow()
        {
            strIndexGuid  =  DYCoCreateGuidString();
            iLinkType = 0;
            iOrderNum = 0;
            odtUseTime = COleDateTime::GetCurrentTime();
            iUseState = 0;
        }
        ~tagDYULCOperateFlow()
        {
        }
    } SDYULCOperateFlow,*PSDYULCOperateFlow;

    typedef CArray<SDYULCOperateFlow, SDYULCOperateFlow&> SDYULCOperateFlow_ARR;
    //
    //以上为DYULCOperateFlow表结构
    ////////////////////////////////////////////////////////////////////////////// 

###流程历史纪录 Module Define.

####1、编单模块的 

__1)   模块名称 Flow.TaskCompile__	

__2）  子流程名称__	

          Flow.TaskCompile.Add      //添加任务(编单软件生成，自动生成循环任务，通过WebService生成)
          Flow.TaskCompile.AddError //添加任务冲突

          Flow.TaskCompile.Audit1   //一审通过
          Flow.TaskCompile.Audit1   //二审通过
          Flow.TaskCompile.Audit1   //三审通过
          Flow.TaskCompile.Audit1   //四审通过
          Flow.TaskCompile.Audit1   //五审通过

          Flow.TaskCompile.Return   //任务退回

####2、总控模块

__1)   模块名称 Flow.TaskManage__  

__2）  子流程名称__ 	

          Flow.TaskManage.Allocate          //分配任务成功
          Flow.TaskManage.AllocateError     //分配任务失败
          Flow.TaskManage.AcceptAllocate    //接收到客户端任务分配成功消息
          Flow.TaskManage.NoAcceptAllocate  //没有接收到客户端任务分配成功消息，超时重分配
          Flow.TaskManage.NoAcceptStartRec  //没有接收到客户端开始录制的消息，超时重分配
          Flow.TaskManage.NoProgress        //没有进度变化，超时重分配
		  
          Flow.TaskManage.SwitchMatrix      //切换矩阵
          Flow.TaskManage.SwitchMatrixError //切换矩阵失败
          Flow.TaskManage.SwitchSate        //切换卫星接收机
          Flow.TaskManage.SwitchSateError   //切换卫星接收机失败

          Flow.TaskManage.AcceptError       //接收到客户端发来的出错消息

          Flow.TaskManage.HandleRec         //手动开始录制
          Flow.TaskManage.HandleStop        //手动停止录制
          Flow.TaskManage.FinishSuccess     //成功结束
          Flow.TaskManage.FinishError       //失败结束

####3、采集模块

__1)   模块名称 Flow.IngestClient__  

__2）  子流程名称__ 	

          Flow.IngestClient.Accept  //接受任务
          Flow.IngestClient.Reject     //拒绝接受任务

          Flow.IngestClient.Start   //任务采集开始
          Flow.IngestClient.Running   //任务正在执行
          Flow.IngestClient.Finish   //任务采集完成 
          Flow.IngestClient.Error   //任务采集出错


####4、迁移模块 

__1） 模块名称 Flow.TaskTrans__	

__2) 子流程名称__  

         Flow.TaskTrans.Running                 //任务迁移入库开始
         Flow.TaskTrans.Error                   //任务迁移入库出错
         Flow.TaskTrans.Finish                  //任务迁移入库完成

         Flow.TaskTrans.RewriteRunning          //任务正在重写
         Flow.TaskTrans.RewriteError            //任务重写出错
         Flow.TaskTrans.RewriteFinish           //任务重写完成

         Flow.TaskTrans.CopyFileRunning         //任务正在复制文件
         Flow.TaskTrans.CopyFileError           //任务复制文件出错
         Flow.TaskTrans.CopyFileFinish          //任务复制文件完成

         Flow.TaskTrans.ImportExploerRunning    //任务正在入库
         Flow.TaskTrans.ImportExploerError      //任务入库出错
         Flow.TaskTrans.ImportExploerFinish     //任务入库完成

         Flow.TaskTrans.TransCodeRunning        //任务正在转码
         Flow.TaskTrans.TransCodeError          //任务转码出错
         Flow.TaskTrans.TransCodeFinish         //任务转码完成

         Flow.TaskTrans.CallInterfaceRunning    //任务正在调用其他模块接口
         Flow.TaskTrans.CallInterfaceError      //任务调用其他模块接口出错
         Flow.TaskTrans.CallInterfaceFinish     //任务调用其他模块接口完成

         Flow.TaskTrans.TaskCobineRunning       //任务正在合并
         Flow.TaskTrans.TaskCobineError         //任务合并出错
         Flow.TaskTrans.TaskCobineFinish        //任务合并完成


####5、提交主干模块

__1） 模块名称 Flow.TaskPreferWeb__	

__2) 子流程名称__	

         Flow.TaskPreferWeb.AddItem             //添加提交记录
         Flow.TaskPreferWeb.BeginPrefer         //开始提交
		 
         Flow.TaskPreferWeb.PreferError         //提交失败
         Flow.TaskPreferWeb.PreferSuccess       //提交成功
		 
         Flow.TaskPreferWeb.FeedBackError       //反馈失败
         Flow.TaskPreferWeb.FeedBackSuccess     //反馈成功



####6、提交PPNE模块

__1） 模块名称 Flow.TaskPreferPPNE__	

__2) 子流程名称__	

         Flow.TaskPreferPPNE.AddItem             //添加提交记录
         Flow.TaskPreferPPNE.BeginPrefer         //开始提交

         Flow.TaskPreferPPNE.PreferError         //提交失败
         Flow.TaskPreferPPNE.PreferSuccess       //提交成功
		 
         Flow.TaskPreferPPNE.FeedBackError       //反馈失败
         Flow.TaskPreferPPNE.FeedBackSuccess     //反馈成功




