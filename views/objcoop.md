##Objective-C OOP
---	

###概述  	

通过Java来理解Objective-C中的OOP, 为此制作了一个表格便于理解:

<table>
	<caption>Objective-C & Java 面向对象中的关键字</caption>
	<thead>
		<th></th>
		<th>Objective C</th>
		<th>Java</th>
	</thead>
	<tbody>
		<tr>
			<td>继承</td>
			<td>@interface NewObject : NSObject</td>
			<td>class NewObject extends Object</td>
		</tr>
		<tr>
			<td>当前对象的引用</td>
			<td>self 指针</td>
			<td>this 关键字</td>
		</tr>
		<tr>
			<td>父类的引用</td>
			<td>super 关键字</td>
			<td>super 关键字</td>
		</tr>
		<tr>
			<td>属性访问器</td>	
			<td>

				<ul>
					<li><h4>ARC</h4></li>
					<li>@property(strong/copy, [readwrite|readonly], [nonatomic])</li>
					<li>@sythesized</li>
					<li><h4>非ARC</h4></li>
					<li>@property(retain/copy/weak, [readwrite|readonly], nonatomic)</li>
					<li>@sythesized</li>
				</ul>
				也可以自己写getter/setter方法
			</td>
			<td>
				getter/setter
			</td>
		</tr>
		<tr>
			<td>Java中的接口</td>
			<td>Protocol</td>
			<td>interface</td>
		</tr>
		<tr>
			<td>委托(事件监听), 都是根据接口实现</td>
			<td>Delegate</td>
			<tr>EventListener<td>
		</tr>
		<tr>
			<td>打开类(MetaData)</td>
			<td>Categroy - 类别, ObjC中使用类别扩展已有类</td>
			<td>不支持</td>
		</tr>
	</tbody>
</table>	

__Important:__  
	
* 不支持_多重集成_
* Objective-C提供categories和protocals特性来解决多重继承的问题.	

其他语言如何解决多重集成问题:	

* Java: 使用interface解决多重继承问题
* Ruby: 使用Module, mixin来解决








