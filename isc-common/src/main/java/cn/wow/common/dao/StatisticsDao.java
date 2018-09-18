package cn.wow.common.dao;

import java.util.List;
import java.util.Map;

public interface StatisticsDao {

	public List<Map<Integer, Object>> statisticsNum(Object params);
	
	public List<Map<String, Object>> statisticsCertificate(Object params);
	
	// 支出统计
	public List<Map<Integer, Object>> statisticsPay(Object params);
	
	// 每月详情统计
	public List<Map<String, Object>> monthStatistic(Object params);
}