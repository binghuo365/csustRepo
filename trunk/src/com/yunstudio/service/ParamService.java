package com.yunstudio.service;

import com.yunstudio.entity.RepParam;

public interface ParamService extends BaseService<RepParam>{
	RepParam getParams();
	/**
	 * 更新保存在内存中的参数，
	 * 每次修改数据库中的参数时就更新，
	 * 减少访问数据库的次数
	 * 
	 */
	void updateStaticParams();
}
