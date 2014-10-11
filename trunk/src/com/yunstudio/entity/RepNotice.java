package com.yunstudio.entity;

import java.io.Serializable;
import java.util.Date;


public class RepNotice implements Serializable {

    
    public Date getPasstime() {
		return passtime;
	}


	public void setPasstime(Date passtime) {
		this.passtime = passtime;
	}


	public Integer getIspassed() {
		return ispassed;
	}


	public void setIspassed(Integer ispassed) {
		this.ispassed = ispassed;
	}


	private Integer id;

    
    private String title;

    
    private Date addtime;

    
    private String content;

    
    private Integer sort;

    
    private RepAdmin repAdmin;
    
    
    private Integer ispassed;
    
    private String notpassreason;

    private Date passtime;
    
    private String author;
    
    private Integer viewtimes;
    
    public RepNotice(){}

	public RepNotice(Integer id, String title, Date addtime, Integer viewtimes) {
		super();
		this.id = id;
		this.title = title;
		this.addtime = addtime;
		this.viewtimes=viewtimes;
	}
	


	public RepNotice(Integer id, String title) {
		super();
		this.id = id;
		this.title = title;
	}


	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
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


	public Integer getSort() {
		return sort;
	}


	public void setSort(Integer sort) {
		this.sort = sort;
	}


	public RepAdmin getRepAdmin() {
		return repAdmin;
	}


	public void setRepAdmin(RepAdmin repAdmin) {
		this.repAdmin = repAdmin;
	}


	public String getAuthor() {
		return author;
	}


	public void setAuthor(String author) {
		this.author = author;
	}


	public String getNotpassreason() {
		return notpassreason;
	}


	public void setNotpassreason(String notpassreason) {
		this.notpassreason = notpassreason;
	}


	public Integer getViewtimes() {
		return viewtimes;
	}


	public void setViewtimes(Integer viewtimes) {
		this.viewtimes = viewtimes;
	}


}
