##Hibernate 文档
---

### hiberante.cfg.xml定义

hiberante.cfg.xml文件=	


	<?xml version='1.0' encoding='UTF-8'?>
	<!DOCTYPE hibernate-configuration PUBLIC "-//Hibernate/Hibernate Configuration DTD//EN" "http://hibernate.sourceforge.net/hibernate-configuration-2.0.dtd">

	<hibernate-configuration>

		<session-factory>
			<property name="hibernate.connection.driver_class">com.microsoft.sqlserver.jdbc.SQLServerDriver</property>
			<property name="hibernate.connection.url">jdbc:sqlserver://192.168.1.18:1433;DatabaseName=test_dyulc30_hw</property>
			<property name="hibernate.connection.username">sa</property>
			<property name="hibernate.connection.password">1</property>
			<property name="hibernate.connection.pool.size">20</property>
			<property name="hibernate.show_sql">true</property>
			<property name="jdbc.fetch_size">50</property>
			<property name="jdbc.batch_size">25</property>
			<property name="jdbc.use_scrollable_resultset">false</property>
			<property name="hibernate.dialect">org.hibernate.dialect.SQLServerDialect</property>



			<mapping resource="cn/com/dayang/biandan3/domain/TaskInfo.hbm.xml" />
			<mapping resource="cn/com/dayang/biandan3/domain/PreTaskInfo.hbm.xml" />
			<mapping resource="cn/com/dayang/biandan3/domain/ClipPart.hbm.xml" />
			


		</session-factory>


</hibernate-configuration>
	
### HibernateSchemaExport 代码定义	

        try {
		SAXReader reader = new SAXReader();
		
		 URL path = HibernateSchemaExport.class.getResource("hiberante.cfg.xml");
		 
		config = new Configuration().configure(path);
		SchemaExport schemaExport = new SchemaExport(config);
		schemaExport.create(true, true);
		
		SessionFactory sessionFactory = config.buildSessionFactory();
		session = sessionFactory.openSession();
		
		tx = session.beginTransaction();
		tx.commit();
		
	} catch (Exception ex) {
		ex.printStackTrace();
		tx.rollback();
	}