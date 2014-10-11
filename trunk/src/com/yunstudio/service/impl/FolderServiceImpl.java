package com.yunstudio.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.yunstudio.dao.FolderDao;
import com.yunstudio.entity.RepFolder;
import com.yunstudio.service.FolderService;
@Service("folderService")
public class FolderServiceImpl extends BaseServiceImpl<RepFolder> implements FolderService {
	private FolderDao folderDao;

	public FolderDao getFolderDao() {
		return folderDao;
	}

	@Resource(name="folderDao")
	public void setFolderDao(FolderDao folderDao) {
		this.folderDao = folderDao;
		super.setBaseDao(folderDao);
	}

}
