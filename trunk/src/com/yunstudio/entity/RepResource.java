package com.yunstudio.entity;

import java.io.File;
import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.struts2.ServletActionContext;

import com.yunstudio.utils.StringUtil;


public class RepResource implements Serializable {

    
    @Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}


	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		RepResource other = (RepResource) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}


	private Integer id;

    
    private String title;

    
    private String path;
    
    private Long length;

    
    private Date addtime;

    
    private Date updatetime;

    
    private Integer likenum;

    
    private Integer downloadnum;

    
    private Integer ispassed;

    private String notpassreason;
    
    private Date passtime;

    
    private String description;

    
    private RepUser repUser;

    
    private RepGscatalog repGscatalog;

    
    private RepAdmin repAdmin;

    
    private RepZycatalog repZycatalog;
    
    private RepTopic repTopic;

    private String translateurl;
    
    private String content;
    
    private String topimg;
    
    private String uploader;
    
    private Integer commentSize;
    
    private Integer pointsneed;
    
    private boolean isTranslated;
    
    private Set<RepTag> repTags=new HashSet<RepTag>(0);

    private Set<RepFolder> repFolders=new HashSet<RepFolder>(0);

    private Set<RepComment> repComments=new HashSet<RepComment>(0);
    
    public RepResource(){}


	public RepResource(String path,String translateurl) {
		super();
		this.path = path;
		this.translateurl=translateurl;
	}
	public RepResource(String path,String title,String translateurl) {
		super();
		this.path = path;
		this.title=title;
		this.translateurl=translateurl;
	}

	public RepResource(Integer id, String title, Integer likenum,
			Integer downloadnum, Integer ispassed, Date passtime,
			String repUserName, String repAdminName, String repGscatalogName,
			String repZycatalogName, String repTopicTitle, String uploader,
			String translateurl,Integer commentSize,String realname) {
		super();
		this.id = id;
		this.title = title;
		this.likenum = likenum;
		this.downloadnum = downloadnum;
		this.ispassed = ispassed;
		this.passtime = passtime;
		if(!StringUtil.isNullOrEmpty(repUserName)){
			this.repUser=new RepUser();
			this.repUser.setUsername(repUserName);
		}
		if(!StringUtil.isNullOrEmpty(repGscatalogName)){
			this.repGscatalog=new RepGscatalog();
			this.repGscatalog.setName(repGscatalogName);
		}
		if(!StringUtil.isNullOrEmpty(repAdminName)||!StringUtil.isNullOrEmpty(realname)){
			this.repAdmin=new RepAdmin();
			this.repAdmin.setUsername(repAdminName);
			this.repAdmin.setRealname(realname);
		}
		if(!StringUtil.isNullOrEmpty(repZycatalogName)){
			this.repZycatalog=new RepZycatalog();
			this.repZycatalog.setName(repZycatalogName);
		}
		if(!StringUtil.isNullOrEmpty(repTopicTitle)){
			this.repTopic=new RepTopic();
			this.repTopic.setTitle(repTopicTitle);
		}
		this.uploader = uploader;
		this.translateurl=translateurl;
		this.commentSize=commentSize;
	}



	public RepResource(Integer id, String title) {
		super();
		this.id = id;
		this.title = title;
	}


	/*public RepResource(Integer id, String title,String path) {
		super();
		this.id = id;
		this.title = title;
		this.path=path;
	}*/

	public RepResource(Integer id, String title, String path, Long length,
			Date updatetime, Integer likenum, Integer downloadnum,
			Integer ispassed, String notpassreason, Date passtime,
			String description, RepGscatalog repGscatalog,
			RepZycatalog repZycatalog, RepTopic repTopic, String translateurl,
			String content, String topimg, String uploader,
			Integer commentSize, Set<RepTag> repTags,
			Set<RepComment> repComments) {
		super();
		this.id = id;
		this.title = title;
		this.path = path;
		this.length = length;
		this.updatetime = updatetime;
		this.likenum = likenum;
		this.downloadnum = downloadnum;
		this.ispassed = ispassed;
		this.notpassreason = notpassreason;
		this.passtime = passtime;
		this.description = description;
		this.repGscatalog = repGscatalog;
		this.repZycatalog = repZycatalog;
		this.repTopic = repTopic;
		this.translateurl = translateurl;
		this.content = content;
		this.topimg = topimg;
		this.uploader = uploader;
		this.commentSize = commentSize;
		this.repTags = repTags;
		this.repComments = repComments;
	}


	public RepResource(Integer id, String title, Date updatetime,
			Date passtime, String description, String content, 
			String topimg, Integer downloadnum) {
		super();
		this.id = id;
		this.title = title;
		this.updatetime = updatetime;
		this.passtime = passtime;
		this.description = description;
		this.content = content;
		this.topimg = topimg;
		this.downloadnum=downloadnum;
		
	}


	public RepResource(Integer id, String title, Date updatetime,
			Date passtime, String description, String content, 
			String topimg, Integer downloadnum, Long length, String path,
			String username,Integer ispassed,String notpassreason) {
		super();
		this.id = id;
		this.title = title;
		this.updatetime = updatetime;
		this.passtime = passtime;
		this.description = description;
		this.content = content;
		this.topimg = topimg;
		this.downloadnum=downloadnum;
		this.length=length;
		this.path=path;
		this.ispassed=ispassed;
		this.notpassreason=notpassreason;
		
		if(!StringUtil.isNullOrEmpty(username)){
			RepUser u=new RepUser();
			u.setUsername(username);
			this.setRepUser(u);
		}
	}


	public RepResource(Integer id, Integer userid) {
		super();
		this.id = id;
		RepUser user=new RepUser();
		user.setId(userid);
		this.repUser=user;
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


	public String getPath() {
		return path;
	}


	public void setPath(String path) {
		this.path = path;
	}


	public Long getLength() {
		return length;
	}


	public void setLength(Long length) {
		this.length = length;
	}


	public Date getAddtime() {
		return addtime;
	}


	public void setAddtime(Date addtime) {
		this.addtime = addtime;
	}


	public Date getUpdatetime() {
		return updatetime;
	}


	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}


	public Integer getLikenum() {
		return likenum;
	}


	public void setLikenum(Integer likenum) {
		this.likenum = likenum;
	}


	public Integer getDownloadnum() {
		return downloadnum;
	}


	public void setDownloadnum(Integer downloadnum) {
		this.downloadnum = downloadnum;
	}


	public Integer getIspassed() {
		return ispassed;
	}


	public void setIspassed(Integer ispassed) {
		this.ispassed = ispassed;
	}


	public Date getPasstime() {
		return passtime;
	}


	public void setPasstime(Date passtime) {
		this.passtime = passtime;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public RepUser getRepUser() {
		return repUser;
	}


	public void setRepUser(RepUser repUser) {
		this.repUser = repUser;
	}


	public RepGscatalog getRepGscatalog() {
		return repGscatalog;
	}


	public void setRepGscatalog(RepGscatalog repGscatalog) {
		this.repGscatalog = repGscatalog;
	}


	public RepAdmin getRepAdmin() {
		return repAdmin;
	}


	public void setRepAdmin(RepAdmin repAdmin) {
		this.repAdmin = repAdmin;
	}


	public RepZycatalog getRepZycatalog() {
		return repZycatalog;
	}


	public void setRepZycatalog(RepZycatalog repZycatalog) {
		this.repZycatalog = repZycatalog;
	}


	public Set<RepTag> getRepTags() {
		return repTags;
	}


	public void setRepTags(Set<RepTag> repTags) {
		this.repTags = repTags;
	}


	public Set<RepFolder> getRepFolders() {
		return repFolders;
	}


	public void setRepFolders(Set<RepFolder> repFolders) {
		this.repFolders = repFolders;
	}


	public Set<RepComment> getRepComments() {
		return repComments;
	}


	public void setRepComments(Set<RepComment> repComments) {
		this.repComments = repComments;
	}


	public void setTranslateurl(String translateurl) {
		this.translateurl = translateurl;
	}


	public String getTranslateurl() {
		return translateurl;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getTopimg() {
		return topimg;
	}


	public void setTopimg(String topimg) {
		this.topimg = topimg;
	}


	public RepTopic getRepTopic() {
		return repTopic;
	}


	public void setRepTopic(RepTopic repTopic) {
		this.repTopic = repTopic;
	}


	public String getUploader() {
		return uploader;
	}


	public void setUploader(String uploader) {
		this.uploader = uploader;
	}




	public String getNotpassreason() {
		return notpassreason;
	}




	public void setNotpassreason(String notpassreason) {
		this.notpassreason = notpassreason;
	}


	public Integer getCommentSize() {
		return commentSize;
	}


	public void setCommentSize(Integer commentSize) {
		this.commentSize = commentSize;
	}


	public Integer getPointsneed() {
		return pointsneed;
	}


	public void setPointsneed(Integer pointsneed) {
		this.pointsneed = pointsneed;
	}


	public boolean isTranslated() {
		String rootPath=ServletActionContext.getServletContext()
				.getRealPath("").replace("\\", "/");
		File file=new File(rootPath+translateurl);
		return file.exists();
	}


	public void setTranslated(boolean isTranslated) {
		this.isTranslated = isTranslated;
	}

    
}
