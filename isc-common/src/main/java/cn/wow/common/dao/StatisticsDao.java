package cn.wow.common.dao;

import java.util.List;
import java.util.Map;

public interface StatisticsDao {

	public List<Map<Integer, Object>> statisticsNum(Object params);
	
	public List<Map<String, Object>> statisticsCertificate();
	
	public List<Map<Integer, Object>> statisticsPay(Object params);
}