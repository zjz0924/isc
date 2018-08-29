package cn.wow.support.web;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.wow.common.domain.App;
import cn.wow.common.domain.Certificate;
import cn.wow.common.domain.SignRecord;
import cn.wow.common.service.AppService;
import cn.wow.common.service.SignRecordService;
import cn.wow.common.service.StatisticsService;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.vo.NumItem;

@Controller
@RequestMapping(value = "statistic")
public class StatisticController extends AbstractController {

	private static Logger logger = LoggerFactory.getLogger(StatisticController.class);

	@Autowired
	private SignRecordService signRecordService;

	@Autowired
	private AppService appService;

	@Autowired
	private StatisticsService statisticsService;

	/**
	 * 收入记录
	 */
	@RequestMapping(value = "/income")
	public String income(HttpServletRequest httpServletRequest, Model model, String name, String startCreateTime,
			String endCreateTime, String type) {

		Map<String, Object> map = new PageMap(httpServletRequest);
		map.put("custom_order_sql", "create_time desc");
		map.put("isDelete", "0");
		map.put("nottype", 3);

		if (StringUtils.isNotBlank(type)) {
			map.put("type", type);
			model.addAttribute("type", type);
		}

		if (StringUtils.isNotBlank(startCreateTime)) {
			map.put("startCreateTime", startCreateTime + " 00:00:00");
			model.addAttribute("startCreateTime", startCreateTime);
		}
		if (StringUtils.isNotBlank(endCreateTime)) {
			map.put("endCreateTime", endCreateTime + " 23:59:59");
			model.addAttribute("endCreateTime", endCreateTime);
		}
		List<SignRecord> dataList = signRecordService.selectAllList(map);

		model.addAttribute("dataList", dataList);
		return "statistic/income_list";
	}

	/**
	 * 到期app
	 */
	@RequestMapping(value = "/expire")
	public String Expire(HttpServletRequest request, Model model, String type) {

		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "expire_date asc");
		map.put("isDelete", "0");

		String endExpireDate = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		if (StringUtils.isBlank(type)) {
			type = "1";
		}

		// 5天后
		if ("1".equals(type)) {

			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE, +5);
			endExpireDate = sdf.format(cal.getTime());

		} else if ("2".equals(type)) { // 3天后

			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE, +3);
			endExpireDate = sdf.format(cal.getTime());

		} else { // 1天后

			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE, +1);
			endExpireDate = sdf.format(cal.getTime());
		}

		map.put("endExpireDate", endExpireDate);

		List<App> dataList = appService.selectAllList(map);
		model.addAttribute("dataList", dataList);
		model.addAttribute("resUrl", resUrl);
		model.addAttribute("type", type);
		return "statistic/expire_list";

	}

	/**
	 * 收支统计
	 */
	@RequestMapping(value = "/statistic")
	public String statistic(HttpServletRequest request, Model model, String startCreateTime, String endCreateTime) {

		Map<String, Object> map = new PageMap(request);

		if (StringUtils.isNotBlank(startCreateTime)) {
			map.put("startCreateTime", startCreateTime + " 00:00:00");
			map.put("startPayDate", startCreateTime);
			model.addAttribute("startCreateTime", startCreateTime);
		}
		if (StringUtils.isNotBlank(endCreateTime)) {
			map.put("endCreateTime", endCreateTime + " 23:59:59");
			map.put("endPayDate", endCreateTime);
			model.addAttribute("endCreateTime", endCreateTime);
		}

		// 数量统计
		NumItem numData= statisticsService.statisticsNum(map);
		model.addAttribute("numData", numData);
		
		// 收支统计
		NumItem payData= statisticsService.statisticsPay(map);
		model.addAttribute("payData", payData);
		
		return "statistic/statistic";
	}
}
