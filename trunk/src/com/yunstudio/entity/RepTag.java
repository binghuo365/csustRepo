package com.yunstudio.entity;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import org.apache.commons.lang3.builder.ToStringBuilder;


public class RepTag implements Serializable {

    
    private Integer id;

    
    private String name;

    
    private Set<RepResource> repResources=new HashSet<RepResource>(0);
    
    public RepTag(){}


	public RepTag(Integer id) {
		super();
		this.id = id;
	}


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


	public Set<RepResource> getRepResources() {
		return repResources;
	}


	public void setRepResources(Set<RepResource> repResources) {
		this.repResources = repResources;
	}


}


