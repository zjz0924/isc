package cn.wow.common.service;

import java.util.List;

import cn.wow.common.vo.NumItem;

public interface StatisticsService {

	// 数量统计
	public List<NumItem> statisticsNum();
	
	// 统计证书
	public List<NumItem> statisticsCertificate();
}
