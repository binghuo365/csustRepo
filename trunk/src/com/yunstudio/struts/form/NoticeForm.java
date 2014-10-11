package com.yunstudio.struts.form;

public class NoticeForm {

	private Integer id;
    private String title;
    private String addtime;
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
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}

}
