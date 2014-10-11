package com.yunstudio.entity;

import java.io.Serializable;
import java.util.Date;


public class RepLog implements Serializable {

    
    private Integer id;

    
    private String operationip;

    
    private String operationtype;
    
    private Date operationtime;

    
    private String description;

    
    private RepAdmin repAdmin;
    
    private String operator;


	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}


	public String getOperationip() {
		return operationip;
	}


	public void setOperationip(String operationip) {
		this.operationip = operationip;
	}


	public String getOperationtype() {
		return operationtype;
	}


	public void setOperationtype(String operationtype) {
		this.operationtype = operationtype;
	}


	public Date getOperationtime() {
		return operationtime;
	}


	public void setOperationtime(Date operationtime) {
		this.operationtime = operationtime;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public RepAdmin getRepAdmin() {
		return repAdmin;
	}


	public void setRepAdmin(RepAdmin repAdmin) {
		this.repAdmin = repAdmin;
	}


	public String getOperator() {
		return operator;
	}


	public void setOperator(String operator) {
		this.operator = operator;
	}


}
