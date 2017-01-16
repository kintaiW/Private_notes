##JAVAMAIL
---

###定义MailSenderInfo类

例子：  

	    // 发送邮件的服务器的IP和端口    
	    private String mailServerHost;    
	    private String mailServerPort = "25";    
	    // 邮件发送者的地址    
	    private String fromAddress;    
	    // 邮件接收者的地址    
	    private String toAddress;    
	    // 登陆邮件发送服务器的用户名和密码    
	    private String userName;    
	    private String password;    
	    // 是否需要身份验证    
	    private boolean validate = false;    
	    // 邮件主题    
	    private String subject;    
	    // 邮件的文本内容    
	    private String content;    
	    // 邮件附件的文件名    
	    private String[] attachFileNames;
	    
	    
	    public Properties getProperties(){    
	        Properties p = new Properties();    
	        p.put("mail.smtp.host", this.mailServerHost);    
	        p.put("mail.smtp.port", this.mailServerPort);    
	        p.put("mail.smtp.auth", validate ? "true" : "false");    
	        return p;    
	      }    
	      public String getMailServerHost() {    
	        return mailServerHost;    
	      }    
	      public void setMailServerHost(String mailServerHost) {    
	        this.mailServerHost = mailServerHost;    
	      }   
	      public String getMailServerPort() {    
	        return mailServerPort;    
	      }   
	      public void setMailServerPort(String mailServerPort) {    
	        this.mailServerPort = mailServerPort;    
	      }   
	      public boolean isValidate() {    
	        return validate;    
	      }   
	      public void setValidate(boolean validate) {    
	        this.validate = validate;    
	      }   
	      public String[] getAttachFileNames() {    
	        return attachFileNames;    
	      }   
	      public void setAttachFileNames(String[] fileNames) {    
	        this.attachFileNames = fileNames;    
	      }   
	      public String getFromAddress() {    
	        return fromAddress;    
	      }    
	      public void setFromAddress(String fromAddress) {    
	        this.fromAddress = fromAddress;    
	      }   
	      public String getPassword() {    
	        return password;    
	      }   
	      public void setPassword(String password) {    
	        this.password = password;    
	      }   
	      public String getToAddress() {    
	        return toAddress;    
	      }    
	      public void setToAddress(String toAddress) {    
	        this.toAddress = toAddress;    
	      }    
	      public String getUserName() {    
	        return userName;    
	      }   
	      public void setUserName(String userName) {    
	        this.userName = userName;    
	      }   
	      public String getSubject() {    
	        return subject;    
	      }   
	      public void setSubject(String subject) {    
	        this.subject = subject;    
	      }   
	      public String getContent() {    
	        return content;    
	      }   
	      public void setContent(String textContent) {    
	        this.content = textContent;    
	      }    

###定义SimpleMailSender，以文本格式发送邮件	
例如：  

	public boolean sendTextMail(MailSenderInfo mailInfo) {
			// 判断是否需要身份认证
			MyAuthenticator authenticator = null;
			Properties pro = mailInfo.getProperties();
			if (mailInfo.isValidate()) {
				// 如果需要身份认证，则创建一个密码验证器
				authenticator = new MyAuthenticator(mailInfo.getUserName(),
						mailInfo.getPassword());
			}
			// 根据邮件会话属性和密码验证器构造一个发送邮件的session
			Session sendMailSession = Session
					.getDefaultInstance(pro, authenticator);
			try {
				// 根据session创建一个邮件消息
				Message mailMessage = new MimeMessage(sendMailSession);
				// 创建邮件发送者地址
				Address from = new InternetAddress(mailInfo.getFromAddress());
				// 设置邮件消息的发送者
				mailMessage.setFrom(from);
				// 创建邮件的接收者地址，并设置到邮件消息中
				Address to = new InternetAddress(mailInfo.getToAddress());
				mailMessage.setRecipient(Message.RecipientType.TO, to);
				// 设置邮件消息的主题
				mailMessage.setSubject(mailInfo.getSubject());
				// 设置邮件消息发送的时间
				mailMessage.setSentDate(new Date());
				// 设置邮件消息的主要内容
				String mailContent = mailInfo.getContent();
				mailMessage.setText(mailContent);
				// 发送邮件
				Transport.send(mailMessage);
	
				System.out.println("发送成功！！！！！！！！！！！！！！");
				return true;
			} catch (MessagingException ex) {
				ex.printStackTrace();
				System.out.println("发送失败！！！！！！！！！！！！！！");
			}
			System.out.println("发送失败！！！！！！！！！！！！！！");
			return false;
		}

###发送邮件方法  
例如：  
	MailSenderInfo mailInfo = new MailSenderInfo();    
	     mailInfo.setMailServerHost("smtp.163.com"); //邮件服务器   
	     mailInfo.setMailServerPort("25");    
	     mailInfo.setValidate(true);    
	     mailInfo.setUserName("nevergiveup530@163.com");    //发送帐号
	     mailInfo.setPassword("krazywong");                 //密码
	     mailInfo.setFromAddress("nevergiveup530@163.com"); //发送帐号
	     mailInfo.setToAddress("wyf13601111@gmail.com");    //接收帐号
	     mailInfo.setSubject("邮件测试");                    //标题
	     mailInfo.setContent("内容！！！！！");               //邮件内容
	     SimpleMailSender sms = new SimpleMailSender();  
	     sms.sendTextMail(mailInfo);//发送文体格式    