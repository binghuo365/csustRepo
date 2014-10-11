package com.yunstudio.entity;

import java.io.Serializable;


public class RepParam implements Serializable {

    
    private Integer id;

    
    private Integer tisneedpass;

    
    private Integer sisneedpass;

    
    private Integer tuploadneedpass;

    
    private Integer suploadneedpass;

    
    private Integer tctneedpass;

    
    private Integer sctneedpass;

    
    private Integer askneedpass;

    
    private Integer visitordownload;

    
    private String format;
    
    private Integer dloadneedpoints;


	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}

	/**
	 * 老师注册是否需要审核(0：不需要，1：需要)
	 * @return
	 */
	public Integer getTisneedpass() {
		return tisneedpass;
	}


	public void setTisneedpass(Integer tisneedpass) {
		this.tisneedpass = tisneedpass;
	}

	/**
	 * 学生注册是否需要审核(0：不需要，1：需要 )
	 * @return
	 */
	public Integer getSisneedpass() {
		return sisneedpass;
	}

	
	public void setSisneedpass(Integer sisneedpass) {
		this.sisneedpass = sisneedpass;
	}

	/**
	 * 老师上传是否需要审核(0：不需要，1：需要 )
	 * @return
	 */
	public Integer getTuploadneedpass() {
		return tuploadneedpass;
	}


	public void setTuploadneedpass(Integer tuploadneedpass) {
		this.tuploadneedpass = tuploadneedpass;
	}

	/**
	 * 学生上传是否需要审核(0：不需要，1：需要 )
	 * @return
	 */
	public Integer getSuploadneedpass() {
		return suploadneedpass;
	}


	public void setSuploadneedpass(Integer suploadneedpass) {
		this.suploadneedpass = suploadneedpass;
	}

	/**
	 * 老师评论是否需要审核(0：不需要，1：需要 )
	 * @return
	 */
	public Integer getTctneedpass() {
		return tctneedpass;
	}


	public void setTctneedpass(Integer tctneedpass) {
		this.tctneedpass = tctneedpass;
	}

	/**
	 * 学生评论是否需要审核(0：不需要，1：需要)
	 * @return
	 */
	public Integer getSctneedpass() {
		return sctneedpass;
	}


	public void setSctneedpass(Integer sctneedpass) {
		this.sctneedpass = sctneedpass;
	}

	/**
	 * 请求帮助是否需要审核(0：不需要，1：需要)
	 * @return
	 */
	public Integer getAskneedpass() {
		return askneedpass;
	}

	
	public void setAskneedpass(Integer askneedpass) {
		this.askneedpass = askneedpass;
	}


	/**
	 * 上传所支持的文件后缀名格式类型（用逗号分隔）
	 * @return
	 */
	public String getFormat() {
		return format;
	}


	public void setFormat(String format) {
		this.format = format;
	}

	/**
	 * 游客是否可以下载(0：不可以，1：可以)
	 * @return
	 */
	public Integer getVisitordownload() {
		return visitordownload;
	}


	public void setVisitordownload(Integer visitordownload) {
		this.visitordownload = visitordownload;
	}


	public Integer getDloadneedpoints() {
		return dloadneedpoints;
	}


	public void setDloadneedpoints(Integer dloadneedpoints) {
		this.dloadneedpoints = dloadneedpoints;
	}


}
