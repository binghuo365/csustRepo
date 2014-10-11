package com.yunstudio.service;

import java.util.List;

import com.yunstudio.entity.RepGscatalog;

public interface GsCatalogService extends BaseService<RepGscatalog> {

	List<RepGscatalog> findGscatalogByName(String name);

}
