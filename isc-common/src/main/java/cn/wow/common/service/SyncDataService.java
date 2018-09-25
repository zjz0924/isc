package cn.wow.common.service;

import cn.wow.common.vo.AppDetailVO;

public interface SyncDataService {

	public void syncList(String token) throws Exception;
	
	public AppDetailVO syncDetail(String token, String appKey) throws Exception;
	
}
