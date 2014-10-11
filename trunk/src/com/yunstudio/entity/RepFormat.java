package com.yunstudio.entity;

import java.io.Serializable;


public class RepFormat implements Serializable {

    
    private Integer id;

    
    private String name;

    
    private Integer size;


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


	public Integer getSize() {
		return size;
	}


	public void setSize(Integer size) {
		this.size = size;
	}


}
