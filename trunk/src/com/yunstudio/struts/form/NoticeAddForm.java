package com.yunstudio.struts.form;

import java.util.Date;

public class NoticeAddForm {

	private Integer id;
    private String title;
    private Date addtime;
    private String content;
    private Integer sort;
    private Integer ispassed;

	public Integer getIspassed() {
		return ispassed;
	}
	public void setIspassed(Integer ispassed) {
		this.ispassed = ispassed;
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

}
