package com.yunstudio.utils;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

public class MailUtil {

	public static int port = 25;// smtp端口
	public static String server = "smtp.163.com";// smtp服务器地址
	public static String fromName = "长沙理工大学教学资源库";// 发送者
	public static String user = "csust_repository@163.com";// 发送者地址
	public static String password = "csust_yun123";// 密码
	public static String transportType="smtp";
	
	public static void sendEmail(String toAddress, String subject, String content) {
		try {
			// 获得一个Properties对象，用来得到类似邮件服务器、用户名、密码这样的信息。
			Properties props = new Properties();
			props.put("mail."+transportType+".host", server);
			props.put("mail."+transportType+".port", String.valueOf(port));
			props.put("mail."+transportType+".auth", "true");
			Transport transport = null;
			// 通过getDefaultInstance()方法来取得一个单一的可以被共享的默认Session
			Session session = Session.getDefaultInstance(props, null);
			// 从Session中为所使用的协议取得一个指定的实例
			transport = session.getTransport(transportType);
			transport.connect(server, user, password);
			// 创建一个Message来发送Session
			MimeMessage msg = new MimeMessage(session);
			msg.setSentDate(new Date());
			// 创建一个地址（为Message的from字段创建address对象）
			InternetAddress fromAddress = null;
			try {
				//可能还有问题，等会测试
				fromAddress = new InternetAddress(user,MimeUtility
					     .encodeText(fromName, "utf-8", "B"));
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			msg.setFrom(fromAddress);
			// 为Message的to字段创建address对象
			InternetAddress[] toAddresses = new InternetAddress[1];
			toAddresses[0] = new InternetAddress(toAddress);
			// 使用setRecipients()方法辨识Message的收件人
			msg.setRecipients(Message.RecipientType.TO, toAddresses);
			msg.setSubject(subject, "UTF-8");
			msg.setText(content, "UTF-8","html");
			msg.saveChanges();
			// 使用一个Transport类来完成邮件发送
			transport.sendMessage(msg, msg.getAllRecipients());
		} catch (NoSuchProviderException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

	public static int getPort() {
		return port;
	}

	public static void setPort(int port) {
		MailUtil.port = port;
	}

	public static String getServer() {
		return server;
	}

	public static void setServer(String server) {
		MailUtil.server = server;
	}

	public static String getFromName() {
		return fromName;
	}

	public static void setFromName(String fromName) {
		MailUtil.fromName = fromName;
	}

	public static String getUser() {
		return user;
	}

	public static void setUser(String user) {
		MailUtil.user = user;
	}

	public static String getPassword() {
		return password;
	}

	public static void setPassword(String password) {
		MailUtil.password = password;
	}

	public static String getTransportType() {
		return transportType;
	}

	public static void setTransportType(String transportType) {
		MailUtil.transportType = transportType;
	}

}