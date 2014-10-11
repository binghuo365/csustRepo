package com.yunstudio.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 分页对象，包含页数，当前页码，开始查询页，总记录数等
 * @author tocean
 *
 */
public class Page implements Serializable {
	public static final String _COOKIE_PAGE_SIZE="_cookie_page_size";
	
	public static final String PAGENO="pageNo";
	
	public static final String QUERYORDERBY="queryOrderBy";
	
	public static final String PAGESIZE="pageSize";

	private static final long serialVersionUID = 1L;

	private int total;			//总页数
	
	private int page;			//页码
	
	private int startIndex;

	private long records;		//总共记录数

	private List rows; 			//数据
	
	private int pageSize;
	
	public Page() {
		this.startIndex=1;
		this.page = 1;
		this.total = 1;
		this.rows =new ArrayList();
		this.records = 0;
	}
	
	public Page(int startIndex,int total, int page, long records,  List rows) {
		super();
		this.startIndex=startIndex;
		this.page = page;
		this.total = total;
		this.rows = rows;
		this.records = records;
	}
	
	static public int calStartIndex(int page,int pageSize)
	{
		return (page-1)*pageSize;
	}
	
	
	public int getPageSize() {
		return pageSize;
	}
	
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	
	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public List getRows() {
		return rows;
	}

	public void setRows(List rows) {
		this.rows = rows;
	}

	public long getRecords() {
		return records;
	}

	public void setRecords(long records) {
		this.records = records;
	}

	/**
	 *  判断是否有下一页
	 */
	public boolean getHasNextPage() {
		return this.getPage() < this.getTotal();
	}

	/**
	 * 判断是否有前一页
	 */
	public boolean getHasPreviousPage() {
		return this.getPage()>1;
	}

	public int getStartIndex() {
		return startIndex;
	}
	public void setStartIndex(int startIndex) {
		this.startIndex = startIndex;
	}

}
