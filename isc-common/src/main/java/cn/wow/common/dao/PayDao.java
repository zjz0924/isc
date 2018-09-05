package cn.wow.common.dao;

import java.util.Map;

public interface PayDao extends SqlDao{
	
	// 统计总额
	public double statisticTotal(Map<String, Object> map);
}