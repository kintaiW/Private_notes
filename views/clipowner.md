##收录选素材拥有者
---

<div class="notice">
项目：netmanage2-rest

</div>

###1. URL接口描述

路径:rest/users/tree.json


参数说明：

{

		orderBy: '开始时间',
		return: {
			UserTree: [Json], //返回UserTree数据
			
		}
	}	


###2.数据结构 




参数说明：

json格式：
  {

    version: 2.0/3.0

    data: [{ 

        // .. 频道

        id: ‘’

        name: ‘’

        children: [{

             // .. 栏目

             id: ‘’,

             parentId: ‘’,

             name: ‘’,

             children: [{

                 // … 用户

                 id: ‘’,

                 parentId: ‘’,

                 name: ‘’

           }]

        }]

     }, {

    //… 频道

   }] 

}

UserTree格式： 

public class UserTree {
	
	private String version = "3";
	
	// 存放jsonString
	private String data = null;
}


###3.页面读取

$.getJSON("rest/users/tree.json", function(data) { 

	var treeData = JSON.parse(data.userTree.data);
				
	$.fn.zTree.init($("#treeDemo"), setting,treeData);
});