package com.yunstudio.entity;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import org.apache.commons.lang3.builder.ToStringBuilder;


/** 
 *        @hibernate.class
 *         table="rep_role"
 *         dynamic-update="true"
 *         batch-size="30"
 *     
*/
public class RepRole implements Serializable {
    private Integer id;
    private String name;
    private String description;
    private Integer sort;
    private Set<RepAdmin> repAdmins=new HashSet<RepAdmin>(0);
    private Set<RepPermission> repPermissions=new HashSet<RepPermission>(0);
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
	public Set<RepAdmin> getRepAdmins() {
		return repAdmins;
	}
	public void setRepAdmins(Set<RepAdmin> repAdmins) {
		this.repAdmins = repAdmins;
	}
	public Set<RepPermission> getRepPermissions() {
		return repPermissions;
	}
	public void setRepPermissions(Set<RepPermission> repPermissions) {
		this.repPermissions = repPermissions;
	}
    

}
