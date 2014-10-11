package com.yunstudio.entity;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

public class RepTopic implements Serializable {
	private Integer id;
	
	private String title;
	
	private String description;
	
	private RepGscatalog repGscatalog;
	
	private RepZycatalog repZycatalog;
	
	private RepUser repUser;
	
	private Set<RepResource> repResources=new HashSet<RepResource>(0);
	
	public RepTopic(){}
	
	

	public RepTopic(Integer id) {
		super();
		this.id = id;
	}
	



	public RepTopic(Integer id, String title, Integer gid,Integer zid,
			String gname,String zname) {
		super();
		this.id = id;
		this.title = title;
		this.repGscatalog = new RepGscatalog();
		this.repGscatalog.setId(gid);
		this.repGscatalog.setName(gname);
		this.repZycatalog = new RepZycatalog();
		this.repZycatalog.setId(zid);
		this.repZycatalog.setName(zname);
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public RepGscatalog getRepGscatalog() {
		return repGscatalog;
	}

	public void setRepGscatalog(RepGscatalog repGscatalog) {
		this.repGscatalog = repGscatalog;
	}

	public RepZycatalog getRepZycatalog() {
		return repZycatalog;
	}

	public void setRepZycatalog(RepZycatalog repZycatalog) {
		this.repZycatalog = repZycatalog;
	}

	public Set<RepResource> getRepResources() {
		return repResources;
	}

	public void setRepResources(Set<RepResource> repResources) {
		this.repResources = repResources;
	}



	public RepUser getRepUser() {
		return repUser;
	}



	public void setRepUser(RepUser repUser) {
		this.repUser = repUser;
	}
}
