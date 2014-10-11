package com.yunstudio.entity;

public interface WebConstant {
	class Hql {
		/**
		 * 通过专业类别查找资源，按下载量排列
		 */
		public static final String queryResourceByZyOrderByDowload = 
				"select new RepResource(r.id, r.title, r.updatetime, "
				+ "r.passtime, r.description, r.content, r.topimg, r.downloadnum) "
				+ "from RepResource r where r.ispassed=1 and r.repZycatalog.id=? "
				+ "order by r.downloadnum desc,r.id desc";

		/**
		 * 通过专业类别查找资源，按最新排列
		 */
		public static final String queryResourceByZyOrderByNew = 
				"select new RepResource(r.id, r.title, r.updatetime, "
				+ "r.passtime, r.description, r.content, r.topimg, r.downloadnum) "
				+ "from RepResource r where r.ispassed=1 and r.repZycatalog.id=? "
				+ "order by r.id desc";

		/**
		 * 通过类型类别查找资源，按下载量排列
		 */
		public static final String queryResourceByGsOrderByDownload = 
				"select new RepResource(r.id, r.title, r.updatetime, "
				+ "r.passtime, r.description, r.content, r.topimg, r.downloadnum) "
				+ "from RepResource r where r.ispassed=1 and r.repGscatalog.id=? "
				+ "order by r.downloadnum desc,r.id desc";
		/**
		 * 同类型类别查找资源，按最新排列(用于二级页面)
		 */
		public static final String queryResourceByGsOrderByNew = 
				"select new RepResource(r.id, r.title, r.updatetime, "
				+ "r.passtime, r.description, r.content, r.topimg, r.downloadnum," +
				" r.length, r.path,u.username,r.ispassed,r.notpassreason) "
				+ "from RepResource r left join r.repUser u where r.ispassed=1 and r.repGscatalog.id=? "
				+ "order by r.id desc";
		/**
		 * 无条件查找资源(用于搜索页面)
		 */
		public static final String queryResource = 
				"select new RepResource(r.id, r.title, r.updatetime, "
				+ "r.passtime, r.description, r.content, r.topimg, r.downloadnum, " +
				"r.length, r.path, u.username,r.ispassed,r.notpassreason) "
				+ "from RepResource r left join r.repUser u";
		/**
		 * 查找资源，按最新排列
		 */
		public static final String queryResourceOrderByNew = 
				"select new RepResource(r.id, r.title, r.updatetime, "
				+ "r.passtime, r.description, r.content, r.topimg, r.downloadnum) "
				+ "from RepResource r where  r.ispassed=1 order by r.passtime desc,r.id desc";

		/**
		 * 查找资源，按下载量排列
		 */
		public static final String queryResourceOrderByDownload = 
				"select new RepResource(r.id, r.title, r.updatetime, "
				+ "r.passtime, r.description, r.content, r.topimg, r.downloadnum) "
				+ "from RepResource r where r.ispassed=1 order by r.downloadnum desc,r.id desc";
		/**
		 * 查询一个资源的几乎全部需要在三级页面展示的信息,通过id查找
		 */
		public static final String queryResourceFullById=
				"select new RepResource(r.id, r.title, r.path, long length," +
				"r.updatetime, r.likenum, r.downloadnum,r.ispassed," +
				" r.notpassreason, r.passtime,	r.description, r.repGscatalog g, r.repZycatalog z, " +
				"r.repTopic to, r.translateurl,r.content, r.topimg, r.uploader, r.commentSize, " +
				"r.repTags ts, " +
				"r.RepComments c) from RepResource r where r.id=?";
		/**
		 * 查找资源，通过id查找，并且只查找id和title
		 */
		public static final String queryResourceIdAndTitleById=
				"select new RepResource(r.id, r.title) from RepResource r where r.id=?";

		/**
		 * 查找公告，按最新排列
		 */
		public static final String queryNoticeOrderByNew = 
				"select new RepNotice(n.id, n.title, n.addtime, n.viewtimes) "
				+ "from RepNotice n where n.ispassed=1 order by n.id desc";

		/**
		 * 查找公告，按浏览次数排列
		 */
		public static final String queryNoticeByViewtimes = 
				"select new RepNotice(n.id, n.title, n.addtime, n.viewtimes) "
				+ "from RepNotice n where n.ispassed=1 order by n.viewtimes desc, n.id desc";
		
		/**
		 * 查找公告，通过id查找，并且只查找id和title
		 */
		public static final String queryNoticeIdAndTitleById=
				"select new RepNotice(n.id, n.title) from RepNotice n where n.id=?";

	}

	class RequestAttrKey {
		public static final String PAGE="page";

		public static final String HOTEST_NOTICE = "hotestnotice";

		public static final String NEWEST_NOTICE = "newestnotice";

		public static final String HOTEST_RESOURCE = "hotestresource";

		public static final String HOTEST_VIDEO = "hotestvideo";

		public static final String NEWEST_RESOURCE = "newestresource";

		public static final String ZYCATALOG = "zycatalog";

		public static final String CATALOGID = "catalogid";
		
		public static final String ZY_JSON_ARRAY="zyjsonarray";
		
		public static final String GS_JSON_ARRAY="gsjsonarray";
		
		public static final String FOLDER_JSON_ARRAY="folderjsonarray";
		
		public static final String CHECKED_GSCATALOG_IDS="checkedgscatalogids";
		
		public static final String CHECKED_ZYCATALOG_IDS="checkedzycatalogids";
		
		public static final String PARAMS="params";
		
		public static final String MESSAGE="message";

		public static final String RETURN_URL="returnUrl";
		
		public static final String FOLDER_ID="folderid";

		public static final String FOLDERLIST = "folderlist"; 
		
		public static final String RESOURCE_LIST="resourcelist";

		public static final String FATHER_FOLDER = "fatherfolder";
	}

	class RequestParamKey {
		public static final String CATALOGID = "catalogid";

		public static final String PAGE_NUM = "pageNum";
		
		public static final String PAGE_SIZE="pageSize";
		
		public static final String ID="id";
		
		public static final String QUERY_ORDER_BY="queryOrderBy";

		public static final String VALIDATE_CODE="validateCode";
		
	}

	class SessionAttrKey{
		public static final String USER="user";
		
		public static final String ADMIN="admin";
		
		public static final String MESSAGE="message";
		
		public static final String VALIDATE_CODE="validateCode";
		
		public static final String USER_LAST_LOGIN_TIME="userlastlogintime";
		
		public static final String USER_LAST_LOGIN_IP="userlastloginip";
	}
}
