package com.yunstudio.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;


public class RepUser implements Serializable {
	
	public static final String USER="user";
	
	public static final String LAST_LOGIN_TIME="lastlogintime";
	
	public static final String LAST_LOGIN_IP="lastloginip";	
	
	private Integer id;

    
    private String username;

    
    private String password;

    
    private String email;

    
    private Integer islock;

    
    private Integer ispassed;
    
    private String notpassreason;

    
    private Date passtime;

    
    private Date regtime;

    
    private String snumber;

    
    private String realname;

    
    private Integer gender;

    
    private String grade;

    
    private String school;

    
    private String major;

    
    private Date birthday;

    
    private String qq;

    
    private String phone;

    
    private String lastloginip;

    
    private Date lastlogintime;

    
    private Integer teacherorstu;
    
    private Integer points;

    
    private Set<RepMessage> repMessages=new HashSet<RepMessage>(0);

    
    private Set<RepResource> repResources=new HashSet<RepResource>(0);

    
    private Set<RepFolder> repFolders=new HashSet<RepFolder>(0);

    
    private Set<RepComment> repComments=new HashSet<RepComment>(0);
    
    private Set<RepTopic> repTopics;


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


	public Integer getIspassed() {
		return ispassed;
	}


	public void setIspassed(Integer ispassed) {
		this.ispassed = ispassed;
	}


	public Date getPasstime() {
		return passtime;
	}


	public void setPasstime(Date passtime) {
		this.passtime = passtime;
	}


	public Date getRegtime() {
		return regtime;
	}


	public void setRegtime(Date regtime) {
		this.regtime = regtime;
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


	public String getGrade() {
		return grade;
	}


	public void setGrade(String grade) {
		this.grade = grade;
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


	public Date getBirthday() {
		return birthday;
	}


	public void setBirthday(Date birthday) {
		this.birthday = birthday;
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


	public Integer getTeacherorstu() {
		return teacherorstu;
	}


	public void setTeacherorstu(Integer teacherorstu) {
		this.teacherorstu = teacherorstu;
	}


	public Set<RepMessage> getRepMessages() {
		return repMessages;
	}


	public void setRepMessages(Set<RepMessage> repMessages) {
		this.repMessages = repMessages;
	}


	public Set<RepResource> getRepResources() {
		return repResources;
	}


	public void setRepResources(Set<RepResource> repResources) {
		this.repResources = repResources;
	}


	public Set<RepFolder> getRepFolders() {
		return repFolders;
	}


	public void setRepFolders(Set<RepFolder> repFolders) {
		this.repFolders = repFolders;
	}


	public Set<RepComment> getRepComments() {
		return repComments;
	}


	public void setRepComments(Set<RepComment> repComments) {
		this.repComments = repComments;
	}


	public String getNotpassreason() {
		return notpassreason;
	}


	public void setNotpassreason(String notpassreason) {
		this.notpassreason = notpassreason;
	}


	public Integer getPoints() {
		return points;
	}


	public void setPoints(Integer points) {
		this.points = points;
	}


	public Set<RepTopic> getRepTopics() {
		return repTopics;
	}


	public void setRepTopics(Set<RepTopic> repTopics) {
		this.repTopics = repTopics;
	}


}
