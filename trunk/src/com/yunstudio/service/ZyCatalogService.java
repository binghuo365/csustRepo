package com.yunstudio.service;

import java.util.List;

import com.yunstudio.entity.RepZycatalog;

public interface ZyCatalogService extends BaseService<RepZycatalog> {
	List<RepZycatalog> findZycatalogByName(String name);
}
