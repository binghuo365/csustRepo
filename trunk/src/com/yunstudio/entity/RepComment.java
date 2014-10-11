package com.yunstudio.entity;

import java.io.Serializable;
import java.util.Date;


public class RepComment implements Serializable {
    private Integer id;
    private Date addtime;
    private String content;
    private Integer ispassed;
    private String notpassreason;
    private Date passtime;
    private RepUser repUser;
    private RepResource repResource;
    
    public RepComment(){}
    
	public RepComment(Integer id, Date addtime, String content,
			Integer ispassed, String notpassreason, Date passtime,
			String username, String title) {
		super();
		this.id = id;
		this.addtime = addtime;
		this.content = content;
		this.ispassed = ispassed;
		this.notpassreason = notpassreason;
		this.passtime = passtime;
		
		this.repUser =new RepUser();
		this.repUser.setUsername(username);
		
		this.repResource =new RepResource();
		this.repResource.setTitle(title);
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Date getAddtime() {
		return addtime;
	}
	public void setAddtime(Date addtime) {
		this.addtime = addtime;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	public RepUser getRepUser() {
		return repUser;
	}
	public void setRepUser(RepUser repUser) {
		this.repUser = repUser;
	}
	public RepResource getRepResource() {
		return repResource;
	}
	public void setRepResource(RepResource repResource) {
		this.repResource = repResource;
	}
	public String getNotpassreason() {
		return notpassreason;
	}
	public void setNotpassreason(String notpassreason) {
		this.notpassreason = notpassreason;
	}
}
