package com.yunstudio.entity;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;


public class RepPermission implements Serializable {

	private Integer id;

    
    private String name;

    
    private String description;

    
    private Integer sort;
    
    private String actionname;

    
    private Set<RepRole> repRoles=new HashSet<RepRole>(0);


	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public Integer getSort() {
		return sort;
	}


	public void setSort(Integer sort) {
		this.sort = sort;
	}


	public Set<RepRole> getRepRoles() {
		return repRoles;
	}


	public void setRepRoles(Set<RepRole> repRoles) {
		this.repRoles = repRoles;
	}


	public String getActionname() {
		return actionname;
	}


	public void setActionname(String actionname) {
		this.actionname = actionname;
	}

    
}
