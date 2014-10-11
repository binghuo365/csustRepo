package com.yunstudio.entity;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;


public class RepGscatalog implements Serializable {

    
    private Integer id;

    
    private String name;

    
    private String description;

    
    private RepGscatalog father;

    
    private Set<RepGscatalog> children=new HashSet<RepGscatalog>(0);

    
    private Set<RepResource> repResources=new HashSet<RepResource>(0);
    
    private Set<RepTopic> repTopics=new HashSet<RepTopic>(0);
    
    public RepGscatalog(){}
    
    


	public RepGscatalog(Integer id) {
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


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}





	public Set<RepResource> getRepResources() {
		return repResources;
	}


	public void setRepResources(Set<RepResource> repResources) {
		this.repResources = repResources;
	}


	public RepGscatalog getFather() {
		return father;
	}


	public void setFather(RepGscatalog father) {
		this.father = father;
	}


	public Set<RepGscatalog> getChildren() {
		return children;
	}


	public void setChildren(Set<RepGscatalog> children) {
		this.children = children;
	}


	public Set<RepTopic> getRepTopics() {
		return repTopics;
	}


	public void setRepTopics(Set<RepTopic> repTopics) {
		this.repTopics = repTopics;
	}


}
