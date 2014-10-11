package com.yunstudio.entity;

import java.io.Serializable;
import java.util.Date;


@SuppressWarnings("serial")
public class RepMessage implements Serializable {

    
    private Integer id;

    
    private String title;

    
    private Date addtime;

    
    private String content;

    
    private Integer ispassed;

    private String notpassreason;
    
    private Integer isreplied;
    
    
    private Date passtime;

    
    private Date reptime;

    
    private String repcontent;

    
    private Integer sort;

    
    private RepUser repUser;

    
    private RepAdmin repAdmin;
    
    private String replyer;
    
    private String asker;


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


	public Integer getIspassed() {
		return ispassed;
	}


	public void setIspassed(Integer ispassed) {
		this.ispassed = ispassed;
	}


	public Integer getIsreplied() {
		return isreplied;
	}


	public void setIsreplied(Integer isreplied) {
		this.isreplied = isreplied;
	}
    
	public Date getPasstime() {
		return passtime;
	}


	public void setPasstime(Date passtime) {
		this.passtime = passtime;
	}


	public Date getReptime() {
		return reptime;
	}


	public void setReptime(Date reptime) {
		this.reptime = reptime;
	}


	public String getRepcontent() {
		return repcontent;
	}


	public void setRepcontent(String repcontent) {
		this.repcontent = repcontent;
	}


	public Integer getSort() {
		return sort;
	}


	public void setSort(Integer sort) {
		this.sort = sort;
	}


	public RepUser getRepUser() {
		return repUser;
	}


	public void setRepUser(RepUser repUser) {
		this.repUser = repUser;
	}


	public RepAdmin getRepAdmin() {
		return repAdmin;
	}


	public void setRepAdmin(RepAdmin repAdmin) {
		this.repAdmin = repAdmin;
	}


	public String getReplyer() {
		return replyer;
	}


	public void setReplyer(String replyer) {
		this.replyer = replyer;
	}


	public String getNotpassreason() {
		return notpassreason;
	}


	public void setNotpassreason(String notpassreason) {
		this.notpassreason = notpassreason;
	}


	public String getAsker() {
		return asker;
	}


	public void setAsker(String asker) {
		this.asker = asker;
	}


    

}
