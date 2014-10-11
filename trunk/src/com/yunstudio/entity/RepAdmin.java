package com.yunstudio.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;


public class RepAdmin implements Serializable {
	
	public static final String ADMIN="admin";
	
	public static final String LAST_LOGIN_TIME="lastlogintime";
	
	public static final String LAST_LOGIN_IP="lastloginip";
	
    private Integer id;
    private String username;
    private String password;
    private String email;
    private Integer islock=0;
    private Date addtime;
    private String snumber;
    private String realname;
    private Integer gender;
    private String school;
    private String major;
    private String qq;
    private String phone;
    private String lastloginip;
    private Date lastlogintime;
    private RepRole repRole;
    private Set<RepMessage> repMessages=new HashSet<RepMessage>(0);
    private Set<RepLog> repLogs=new HashSet<RepLog>(0);
    private Set<RepResource> repResources=new HashSet<RepResource>(0);
    private Set<RepNotice> repNotices=new HashSet<RepNotice>(0);
	
    
    public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Integer getIslock() {
		return islock;
	}
	public void setIslock(Integer islock) {
		this.islock = islock;
	}
	public Date getAddtime() {
		return addtime;
	}
	public void setAddtime(Date addtime) {
		this.addtime = addtime;
	}
	public String getSnumber() {
		return snumber;
	}
	public void setSnumber(String snumber) {
		this.snumber = snumber;
	}
	public String getRealname() {
		return realname;
	}
	public void setRealname(String realname) {
		this.realname = realname;
	}
	public Integer getGender() {
		return gender;
	}
	public void setGender(Integer gender) {
		this.gender = gender;
	}
	public String getSchool() {
		return school;
	}
	public void setSchool(String school) {
		this.school = school;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getLastloginip() {
		return lastloginip;
	}
	public void setLastloginip(String lastloginip) {
		this.lastloginip = lastloginip;
	}
	public Date getLastlogintime() {
		return lastlogintime;
	}
	public void setLastlogintime(Date lastlogintime) {
		this.lastlogintime = lastlogintime;
	}
	public RepRole getRepRole() {
		return repRole;
	}
	public void setRepRole(RepRole repRole) {
		this.repRole = repRole;
	}
	public Set<RepMessage> getRepMessages() {
		return repMessages;
	}
	public void setRepMessages(Set<RepMessage> repMessages) {
		this.repMessages = repMessages;
	}
	public Set<RepLog> getRepLogs() {
		return repLogs;
	}
	public void setRepLogs(Set<RepLog> repLogs) {
		this.repLogs = repLogs;
	}
	public Set<RepResource> getRepResources() {
		return repResources;
	}
	public void setRepResources(Set<RepResource> repResources) {
		this.repResources = repResources;
	}
	public Set<RepNotice> getRepNotices() {
		return repNotices;
	}
	public void setRepNotices(Set<RepNotice> repNotices) {
		this.repNotices = repNotices;
	}

}
