package com.yunstudio.entity;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import org.apache.commons.lang3.builder.ToStringBuilder;


public class RepFolder implements Serializable {

    
    private Integer id;

    
    private String name;

    
    private String description;

    
    private RepFolder father;

    private RepUser repUser;
    
    private Set<RepFolder> children=new HashSet<RepFolder>(0);

    
    private Set<RepResource> repResources=new HashSet<RepResource>(0);

    public RepFolder(){}

	public RepFolder(Integer id, String name) {
		super();
		this.id = id;
		this.name = name;
	}

	public RepFolder(Integer id, Set<RepResource> repResources) {
		super();
		this.id = id;
		this.repResources = repResources;
	}

	/*public RepFolder(Integer id, String name, RepFolder father, Set<RepResource> set) {
		super();
		this.id = id;
		this.name = name;
		this.father = father;
		
		this.setRepResources(set);
		
	}
*/
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



	public RepFolder getFather() {
		return father;
	}


	public void setFather(RepFolder father) {
		this.father = father;
	}


	public Set<RepFolder> getChildren() {
		return children;
	}


	public void setChildren(Set<RepFolder> children) {
		this.children = children;
	}


	public Set<RepResource> getRepResources() {
		return repResources;
	}


	public void setDescription(String description) {
		this.description = description;
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
