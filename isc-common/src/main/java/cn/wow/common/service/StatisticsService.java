package cn.wow.common.service;

import java.util.List;
import java.util.Map;

import cn.wow.common.vo.NumItem;

public interface StatisticsService {

	// 数量统计
	public List<NumItem> statisticsNum();
	
	// 统计证书
	public List<NumItem> statisticsCertificate(Map<String, Object> queryMap);
	
	// 数量统计
	public NumItem statisticsNum(Map<String, Object> queryMap);
	
	// 收支统计
	public NumItem statisticsPay(Map<String, Object> queryMap);
	
	// 支出详情
	public List<NumItem> statisticsPayDetail(Map<String, Object> queryMap);
	
	
	// 每月详情统计
	public List<Map<String, Object>> monthStatistic(Map<String, Object> queryMap);
}
