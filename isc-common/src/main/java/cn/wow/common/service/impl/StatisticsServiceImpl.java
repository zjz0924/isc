package cn.wow.common.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.wow.common.dao.StatisticsDao;
import cn.wow.common.service.StatisticsService;
import cn.wow.common.utils.DateUtils;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.vo.NumItem;

@Service
@Transactional
public class StatisticsServiceImpl implements StatisticsService {

	@Autowired
	private StatisticsDao statisticsDao;

	// 数量统计
	public List<NumItem> statisticsNum() {
		List<NumItem> dataList = new ArrayList<NumItem>();

		Map<String, Object> queryMap = new PageMap(false);
		List<Map<Integer, Object>> total = statisticsDao.statisticsNum(queryMap);

		queryMap.put("startCreateTime", resetDate(1, DateUtils.getToday()));
		queryMap.put("endCreateTime", resetDate(2, DateUtils.getToday()));
		List<Map<Integer, Object>> today = statisticsDao.statisticsNum(queryMap);

		queryMap.put("startCreateTime", resetDate(1, DateUtils.getYestoday()));
		queryMap.put("endCreateTime", resetDate(2, DateUtils.getYestoday()));
		List<Map<Integer, Object>> yesterday = statisticsDao.statisticsNum(queryMap);

		queryMap.put("startCreateTime", resetDate(1, DateUtils.getWeekStart()));
		queryMap.put("endCreateTime", resetDate(2, DateUtils.getWeekEnd()));
		List<Map<Integer, Object>> week = statisticsDao.statisticsNum(queryMap);

		queryMap.put("startCreateTime", resetDate(1, DateUtils.getMonthStart()));
		queryMap.put("endCreateTime", resetDate(2, DateUtils.getMonthEnd()));
		List<Map<Integer, Object>> month = statisticsDao.statisticsNum(queryMap);

		this.assembleData(dataList, total, "总数");
		this.assembleData(dataList, today, "今天");
		this.assembleData(dataList, yesterday, "昨天");
		this.assembleData(dataList, week, "本周");
		this.assembleData(dataList, month, "本月");

		return dataList;
	}

	// 统计证书
	public List<NumItem> statisticsCertificate(Map<String, Object> queryMap) {
		List<NumItem> dataList = new ArrayList<NumItem>();

		List<Map<String, Object>> data = statisticsDao.statisticsCertificate(queryMap);
		if (data != null && data.size() > 0) {
			for (Map<String, Object> map : data) {
				String name = map.get("name").toString();
				Long total = (long) map.get("total");
				Long today = (long) map.get("today");

				NumItem item = new NumItem();
				item.setName(name);
				item.setAdd(total.intValue());
				item.setRenew(today.intValue());
				dataList.add(item);
			}
		}
		return dataList;
	}

	// 数量统计
	public NumItem statisticsNum(Map<String, Object> queryMap) {
		List<Map<Integer, Object>> data = statisticsDao.statisticsNum(queryMap);

		List<NumItem> dataList = new ArrayList<NumItem>();
		this.assembleData(dataList, data, "统计");

		return dataList.get(0);
	}

	// 收支统支
	public NumItem statisticsPay(Map<String, Object> queryMap) {
		List<Map<Integer, Object>> data = statisticsDao.statisticsPay(queryMap);
		NumItem item = new NumItem();

		if (data != null && data.size() > 0) {
			for (Map<Integer, Object> map : data) {
				Long type = (Long) map.get("name");
				double sum = (double) map.get("price");

				if (type == 1) {
					item.setAddSum(sum);
				} else {
					item.setRenewSum(sum);
				}
			}
		} else {
			item.setRenewSum(0d);
			item.setAddSum(0d);
		}

		return item;
	}

	public List<Map<String, Object>> monthStatistic(Map<String, Object> queryMap) {
		return statisticsDao.monthStatistic(queryMap);
	}

	private String resetDate(int type, String str) {
		if (type == 1) {
			return str + " 00:00:00";
		} else {
			return str + " 23:59:59";
		}
	}

	private void assembleData(List<NumItem> dataList, List<Map<Integer, Object>> data, String name) {
		NumItem item = new NumItem();
		item.setName(name);

		if (data != null && data.size() > 0) {
			for (Map<Integer, Object> map : data) {
				Long type = (Long) map.get("type");
				Long num = (Long) map.get("num");
				double sum = (double) map.get("price");

				if (type == 1) {
					item.setAdd(num.intValue());
					item.setAddSum(sum);
				} else if (type == 2) {
					item.setRenew(num.intValue());
					item.setRenewSum(sum);
				} else {
					item.setSumplement(num.intValue());
					item.setSumplementSum(sum);
				}
			}
		}
		dataList.add(item);
	}

}
