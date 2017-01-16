##biandan3迁移流程
---

###涉及的Domain对象:  

* cn.com.dayang.biandan3.IpDownloadTask
* 状态字段: __bcheckstatus: long__
	* -1. 退回 0. 未审核, 1. 通过一级审核  2. 通过二级审核 3. 通过三级审核 
* 需要新增字段:
	* __flowStatus:String__, 流程状态
	* __currentFlowId:String(36)__, WorkflowBean的ID

###IPDownloadTask表新增列

	use DYIPExchange;

	alter table IPDownloadTask add currentFlowId varchar(36);
	alter table IPDownloadTask add flowStatus varchar(128);	

###流程变更

####特殊约定

最后一次审核时,必须将bcheckstatus = 3. 只有bcheckstatus = 3时,迁移客户端才会对该任务进行迁移处理.

####如何使用

直接继承AbstractFlowAction即可处理.如果需要特殊操作,可以使用GroovyWorkflowFactory,对Workflow进行创建

	Workflow workflow = factory.createWorkflow("IpDownloadTask_Def.groovy");	


####流程定义
	
<div class="notice">
	流程定义参考 ${classpath}/groovy/workflow/IpDownloadTask_Def.groovy 文件内容.
</div>

	package workflow;

	def rollback_map = [
		perms: {flow, subject, inputsMap ->
			return true;
		},
		execute: {flow, subject, inputsMap ->
			flow.status = "returned";
			inputsMap['ipTask'].bcheckstatus = -1;
		}
	]

	/**
		定义迁移任务的流程
	*/
	workflow = [
		name: 'IpDownloadTask',
		start: 'saved',
		saved: [
			isStart: true,
			audit1: [
				perms: {flow, subject, inputsMap->
					return true;
				},
				execute: {flow, subject, inputs ->
					flow.status = "audit1";
				}
			]
			rollback: rollback_map
		],
		audited1: [
			audit2: [
				perms: {flow, subject, inputsMap->
					return true;
				},
				execute: {flow, subject, inputs ->
					flow.status = "audited2";
				}
			],
			rollback: rollback_map
		],
		audited2: [
			audit3: [
				perms: {flow, subject, inputsMap->
					return true;
				},
				execute: {flow, subject, inputs ->
					//这里必须做标识. 迁移客户端会监视这个字段
					//当bcheckstatus=3时,则执行迁移动作
					inputsMap['ipTask'].bcheckstatus = 3;
					flow.status = "audited3";
				}
			],
			rollback: rollback_map
		],
		audited3: [
			isEnd: true
		],
		returned: [
			isEnd: true
		]
	];

	return workflow;
