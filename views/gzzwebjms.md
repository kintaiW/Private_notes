##gzzweb采集工作站 二 JMS Dev 
--- 

B/S和C/S采用JMS方式进行交互, 服务器选用[Apache ActiveMQ 5.4.3][mq]. 本文档值描述JMS在gzzweb中是如何配置的,以及如何使用  
Spring提供JmsTemplate, AdapterMessageListener, MessageListenerContainer等工具来简化JMS操作. 

目录:   

1. ActiveMQ服务器管理简述
2. ActiveMQ与Spring集成
3. jms.xml结构说明
    1. 配置jndi
    2. 连接工厂
    3. 目的地
    4. __主题/列队的JmsTemplate配置__
    5. 配置MessageConverter
    6. 配置MessageListenerContainer 

###一. ActiveMQ服务器管理简述    

大洋上海研发部的ActiveMQ架设在192.168.1.6机器上. 访问如下地址即可访问到MQ的管理页面:    

http://192.168.1.6:8161/admin/

###二. ActiveMQ与Spring集成 

<div class="notice">
    <p>pom.xml是Maven的配置文件.</p>
    其他配置文件都在src/main/resources目录下
    <ul>
        <li>spring/jms.xml: 是Spring + ActiveMQ的配置</li>
        <li>jms.properties: jms.xml中的参数配置,配置ActiveMQ连接信息</li>
    </ul>
</div>

####Maven pom.xml中安装ActiveMQ,Spring相关jar包

pom.xml片段 
    
    <!-- ... ->
    <dependency>
        <groupId>javax.jms</groupId>
        <artifactId>jms</artifactId>
        <version>1.1</version>
    </dependency>
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-jms</artifactId>
        <version>${spring.framework.version}</version>
    </dependency>
    <dependency>
        <groupId>org.apache.activemq</groupId>
        <artifactId>activemq-core</artifactId>
        <version>5.4.3</version>
    </dependency>   
    <!-- ... -->    
 
###jms.xml配置说明:       

####1. JndiTemplate提供JNDI配置模板:    

	<beans:bean id="jndiTemplate" class="org.springframework.jndi.JndiTemplate">
		<beans:property name="environment">
			<beans:props>
				<beans:prop key="java.naming.factory.initial">
                org.apache.activemq.jndi.ActiveMQInitialContextFactory
                </beans:prop>
				<!-- 上下线使用这个 -->
				<beans:prop key="topic.DYULC.INGESTMANAGE.TOPIC">DYULC.INGESTMANAGE.TOPIC</beans:prop>
				<!-- 控制全部设备用着个 -->
				<beans:prop key="topic.DYULC.PHEDEVICE.TOPIC">DYULC.PHEDEVICE.TOPIC</beans:prop>
			</beans:props>
		</beans:property>
	</beans:bean>   

* 指定JMS的InitialContextFactory: org.apache.activemq.jndi.ActiveMQInitialContextFactory
* 制定topic配置 

####2. 配置JMS连接工厂  

    <beans:bean id="connectionFactory" class="org.apache.activemq.ActiveMQConnectionFactory">
		<beans:property name="brokerURL">
			<!-- <value>failover:(tcp://10.2.1.104:61616,tcp://10.2.1.18:61616)?initialReconnectDelay=100&randomize=true</value> -->
			<beans:value>tcp://192.168.1.6:61616</beans:value>
		</beans:property>		
	</beans:bean>   

<div class="notice">
<p>
    <b>tcp://192.168.1.6:61616</b>是连接单台MQ的做法,生产环境一般需要连接MQ集群,需要使用如下地址:
</p>
<pre>
    failover:(tcp://10.2.1.104:61616,tcp://10.2.1.18:61616)?initialReconnectDelay=100&randomize=true
</pre>
</div>  

####3. 配置Destination的处理方式,以及默认Destination    

	<!-- 通过jndi来创建Destination -->
	<beans:bean id="destinationResolver"
		class="org.springframework.jms.support.destination.JndiDestinationResolver">
		<!-- 设置目标jndi配置 -->
		<beans:property name="jndiTemplate" ref="jndiTemplate" />
		<!-- 
			动态创建的Queues和Topics会被缓存，当cache值为true的时候，jndi中配置的destination需要都是唯一的
		 -->
		<beans:property name="cache" value="false" />
		<!-- 默认为false -->
		<beans:property name="fallbackToDynamicDestination" value="false" />		
	</beans:bean>
	
	<beans:bean id="dest" class="org.springframework.jndi.JndiObjectFactoryBean">
		<beans:property name="jndiTemplate">
			<beans:ref bean="jndiTemplate" />
		</beans:property>
		<beans:property name="jndiName">
			<beans:value>DYULC.INGESTMANAGE.TOPIC</beans:value>
		</beans:property>
	</beans:bean>   

####4. 主题/列队的JmsTemplate配置   

    <!-- 类似于JDBCTemplate， JmsTempate用于简化JMS编码工作 -->
	<beans:bean id="queueTpl" class="org.springframework.jms.core.JmsTemplate">		
		<!-- 当前默认创建的是P2P目的 -->
		<beans:property name="pubSubDomain">
			<beans:value>false</beans:value>
		</beans:property>
		<beans:property name="connectionFactory">
			<beans:bean class="org.springframework.jms.connection.SingleConnectionFactory">
				<beans:property name="targetConnectionFactory">
					<beans:ref bean="connectionFactory" />
				</beans:property>
			</beans:bean>
		</beans:property>
	</beans:bean>
	
	<beans:bean id="topicTpl" class="org.springframework.jms.core.JmsTemplate">		
		<!-- 当前默认创建的是Pub/Sub模式目的 -->
		<beans:property name="pubSubDomain">
			<beans:value>true</beans:value>
		</beans:property>
		<beans:property name="connectionFactory">
			<beans:bean class="org.springframework.jms.connection.SingleConnectionFactory">
				<beans:property name="targetConnectionFactory">
					<beans:ref bean="connectionFactory"/>
				</beans:property>
			</beans:bean>
		</beans:property>
		<beans:property name="defaultDestination" ref="dest" />
	</beans:bean>   

<div class="notice">
Spring提供的,最核心的编程API. gzzweb项目将其封装成sender和receiver进行使用:
</div>  

	<beans:bean id="sender" class="com.dayang.gzzweb.jms.Sender">
		<beans:property name="topicTpl" ref="topicTpl" />
		<beans:property name="queueTpl" ref="queueTpl" />
	</beans:bean>
	
	<beans:bean id="receiver" class="com.dayang.gzzweb.jms.TopicListener">
	</beans:bean>   


####5. 配置MessageConverter 

在使用Spring提供的AdapterMessageListener时,需要配置MessageConverter. 在Converter中将JMSMessage转换成Pojo.转换后的pojo会传入AdapterMessageLisntener的实现类中被使用. 

配置:   

	<beans:bean id="xmlMessageConverter"
		class="com.dayang.gzzweb.jms.converters.XmlMessageConverter">
	</beans:bean>   

实现类: 

    package com.dayang.gzzweb.jms.converters;

    import javax.jms.JMSException;
    import javax.jms.Message;
    import javax.jms.Session;
    import javax.jms.TextMessage;

    import org.springframework.jms.support.converter.MessageConversionException;
    import org.springframework.jms.support.converter.MessageConverter;

    import com.dayang.common.XmlHelper;
    import com.dayang.gzzweb.jms.XmlMessage;

    public class XmlMessageConverter implements MessageConverter {

        public Object fromMessage(Message message) throws JMSException,
                MessageConversionException {
            TextMessage tm = (TextMessage)message;
            String text = tm.getText();
            String xml = XmlHelper.fixChar(text);
            
            XmlMessage msg = XmlMessage.fromXml(xml);
            
            return msg;
        }

        public Message toMessage(Object obj, Session session) throws JMSException,
                MessageConversionException {
            XmlMessage msg = (XmlMessage)obj;
            TextMessage ret = session.createTextMessage(msg.toXml());
            
            return ret;
        }
        
    }   

####5. 配置MessageListenerContainer 

Spring提供MessageListenerContainer解决线程开启,消息接收,消息转换等功能. 

	<beans:bean id="messageAdapterListener" class="org.springframework.jms.listener.adapter.MessageListenerAdapter">
	    <beans:constructor-arg ref="receiver"></beans:constructor-arg>
	    <!-- 如果不定义本属性，则调用handleMessage -->
	    <beans:property name="defaultListenerMethod" value="onMessage" />
	    <!-- 如果不需要消息转换器，则将messageConverter值设置为null, 在receive方法中使用Message作为参数 -->
	    <beans:property name="messageConverter" ref="xmlMessageConverter" />
	</beans:bean>
	
	<!--	
		Topic container, 在订阅模式下concurrency需要设置为1 
		创建online消息监听容器，监听用户上线和离线消息
	 -->
	<beans:bean id="jmsAdapterContainer" class="org.springframework.jms.listener.DefaultMessageListenerContainer">
		<beans:property name="connectionFactory" ref="connectionFactory" />
		<beans:property name="destinationResolver" ref="destinationResolver" />
		<beans:property name="destination" ref="dest"/>
		<!-- 并发监听线程数 -->
		<beans:property name="concurrentConsumers" value="1" />
		<!-- 接受者 -->
		<beans:property name="messageListener" ref="messageAdapterListener" />
	</beans:bean>   


<div class="info">
gzzweb中提供的接口,需要参考JMS API封装文档
</div>

[mq]: http://activemq.apache.org/activemq-543-release.html ActiveMQ
