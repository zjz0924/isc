package cn.wow.support.web;

import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.wow.common.domain.Account;
import cn.wow.common.domain.App;
import cn.wow.common.domain.SignRecord;
import cn.wow.common.service.AppService;
import cn.wow.common.service.OperationLogService;
import cn.wow.common.service.SignRecordService;
import cn.wow.common.service.StatisticsService;
import cn.wow.common.utils.Contants;
import cn.wow.common.utils.DateUtils;
import cn.wow.common.utils.ImportExcelUtil;
import cn.wow.common.utils.JsonUtil;
import cn.wow.common.utils.operationlog.OperationType;
import cn.wow.common.utils.operationlog.ServiceType;
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

	@Autowired
	private OperationLogService operationLogService;

	// 查询的条件，用于导出
	private Map<String, Object> queryMap = new PageMap(false);

	/**
	 * 收入记录
	 */
	@RequestMapping(value = "/income")
	public String income(HttpServletRequest httpServletRequest, Model model, String name, String startCreateTime,
			String endCreateTime, String type, String payType, String startEffectiveDate, String endEffectiveDate,
			String startExpireDate, String endExpireDate) {

		Map<String, Object> map = new PageMap(httpServletRequest);
		map.put("custom_order_sql", "create_time desc");
		map.put("isDelete", "0");
		map.put("nottype", 3);

		queryMap.clear();
		queryMap.put("custom_order_sql", "create_time desc");
		queryMap.put("isDelete", "0");
		queryMap.put("nottype", 3);

		if (StringUtils.isNotBlank(type)) {
			map.put("type", type);
			queryMap.put("type", type);
			model.addAttribute("type", type);
		}

		if (StringUtils.isNotBlank(payType)) {
			map.put("payType", payType);
			queryMap.put("payType", payType);
			model.addAttribute("payType", payType);
		}

		if (StringUtils.isNotBlank(startCreateTime)) {
			map.put("startCreateTime", startCreateTime + " 00:00:00");
			queryMap.put("startCreateTime", startCreateTime + " 00:00:00");
			model.addAttribute("startCreateTime", startCreateTime);
		}

		if (StringUtils.isNotBlank(endCreateTime)) {
			map.put("endCreateTime", endCreateTime + " 23:59:59");
			queryMap.put("endCreateTime", endCreateTime + " 23:59:59");
			model.addAttribute("endCreateTime", endCreateTime);
		}

		if (StringUtils.isNotBlank(startEffectiveDate)) {
			map.put("startEffectiveDate", startEffectiveDate);
			queryMap.put("startEffectiveDate", startEffectiveDate);
			model.addAttribute("startEffectiveDate", startEffectiveDate);
		}

		if (StringUtils.isNotBlank(endEffectiveDate)) {
			map.put("endEffectiveDate", endEffectiveDate);
			queryMap.put("endEffectiveDate", endEffectiveDate);
			model.addAttribute("endEffectiveDate", endEffectiveDate);
		}

		if (StringUtils.isNotBlank(startExpireDate)) {
			map.put("startExpireDate", startExpireDate);
			queryMap.put("startExpireDate", startExpireDate);
			model.addAttribute("startExpireDate", startExpireDate);
		}

		if (StringUtils.isNotBlank(endExpireDate)) {
			map.put("endExpireDate", endExpireDate);
			queryMap.put("endExpireDate", endExpireDate);
			model.addAttribute("endExpireDate", endExpireDate);
		}

		List<SignRecord> dataList = signRecordService.selectAllList(map);

		// 总金额
		double total = signRecordService.statisticTotal(queryMap);

		model.addAttribute("dataList", dataList);
		model.addAttribute("total", total);
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
		NumItem numData = statisticsService.statisticsNum(map);
		model.addAttribute("numData", numData);

		// 收支统计
		NumItem payData = statisticsService.statisticsPay(map);
		model.addAttribute("payData", payData);

		return "statistic/statistic";
	}

	/**
	 * 每月详情统计
	 */
	@RequestMapping(value = "/monthStatistic")
	public String monthStatistic(HttpServletRequest request, Model model, String month) {

		Map<String, Object> queryMap = new PageMap(false);
		SimpleDateFormat sdf = new SimpleDateFormat("dd");
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM");
		
		Date date = null;
		try {
			if (StringUtils.isBlank(month)) {
				date = new Date();
			} else {
				date = sdf1.parse(month + "-01");
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}

		queryMap.put("startCreateTime", DateUtils.getMonthStart(date));
		queryMap.put("endCreateTime", DateUtils.getMonthEnd(date));

		List<Map<String, Object>> dataList = statisticsService.monthStatistic(queryMap);
		model.addAttribute("dataList", dataList);
		
		// 时间列表
		List<String> dateList = new ArrayList<String>();
		// 值列表
		List<Double> valueList = new ArrayList<Double>();
		
		for (Map<String, Object> map : dataList) {
			Date dateVal = (Date) map.get("datelist");
			dateList.add(sdf.format(dateVal));
			
			valueList.add((Double) map.get("price"));
		}
		
		model.addAttribute("month", date);
		model.addAttribute("monthTitle", sdf1.format(date));
		model.addAttribute("date", JsonUtil.toJson(dateList));
		model.addAttribute("val", JsonUtil.toJson(valueList));
		return "statistic/month_statistic";
	}

	/**
	 * 导出清单
	 */
	@RequestMapping(value = "/exportList")
	public void exportList(HttpServletRequest request, HttpServletResponse response) {
		Account currentAccount = (Account) request.getSession().getAttribute(Contants.CURRENT_ACCOUNT);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd");
		String filename = "收入清单-" + sdf2.format(new Date());

		try {
			// 设置头
			ImportExcelUtil.setResponseHeader(response, filename + ".xlsx");

			Workbook wb = new SXSSFWorkbook(100); // 保持100条在内存中，其它保存到磁盘中
			// 工作簿
			Sheet sh = wb.createSheet("收入清单");
			sh.setColumnWidth(0, (short) 4000);
			sh.setColumnWidth(1, (short) 2000);
			sh.setColumnWidth(2, (short) 4000);
			sh.setColumnWidth(3, (short) 4000);
			sh.setColumnWidth(4, (short) 6000);
			sh.setColumnWidth(5, (short) 6000);
			sh.setColumnWidth(6, (short) 3000);
			sh.setColumnWidth(7, (short) 3000);
			sh.setColumnWidth(8, (short) 6000);

			Map<String, CellStyle> styles = ImportExcelUtil.createStyles(wb);

			String[] titles = { "APP", "类型", "生效时间", "过期时间", "套餐", "证书", "支付方式", "金额/元", "创建时间" };
			int r = 0;

			Row titleRow = sh.createRow(0);
			titleRow.setHeight((short) 450);
			for (int k = 0; k < titles.length; k++) {
				Cell cell = titleRow.createCell(k);
				cell.setCellStyle(styles.get("header"));
				cell.setCellValue(titles[k]);
			}

			++r;

			List<SignRecord> dataList = signRecordService.selectAllList(queryMap);
			for (int j = 0; j < dataList.size(); j++) {// 添加数据
				Row contentRow = sh.createRow(r);
				contentRow.setHeight((short) 400);
				SignRecord signRecord = dataList.get(j);

				Cell cell1 = contentRow.createCell(0);
				cell1.setCellStyle(styles.get("cell"));
				if (signRecord.getApp() != null) {
					cell1.setCellValue(signRecord.getApp().getName());
				}

				Cell cell2 = contentRow.createCell(1);
				cell2.setCellStyle(styles.get("cell"));
				if (signRecord.getType() == 1) {
					cell2.setCellValue("新增");
				} else if (signRecord.getType() == 2) {
					cell2.setCellValue("续费");
				}

				Cell cell3 = contentRow.createCell(2);
				cell3.setCellStyle(styles.get("cell"));
				cell3.setCellValue(sdf1.format(signRecord.getEffectiveDate()));

				Cell cell4 = contentRow.createCell(3);
				cell4.setCellStyle(styles.get("cell"));
				cell4.setCellValue(sdf1.format(signRecord.getExpireDate()));

				Cell cell5 = contentRow.createCell(4);
				cell5.setCellStyle(styles.get("cell"));
				if (signRecord.getCombo() != null) {
					cell5.setCellValue(signRecord.getCombo().getName());
				}

				Cell cell6 = contentRow.createCell(5);
				cell6.setCellStyle(styles.get("cell"));
				if (signRecord.getCertificate() != null) {
					cell6.setCellValue(signRecord.getCertificate().getName());
				}

				Cell cell7 = contentRow.createCell(6);
				cell7.setCellStyle(styles.get("cell"));
				if (signRecord.getCombo() != null) {
					cell7.setCellValue(signRecord.getPayType());
				}

				Cell cell8 = contentRow.createCell(7);
				cell8.setCellStyle(styles.get("cell"));
				cell8.setCellValue(signRecord.getPrice());

				Cell cell9 = contentRow.createCell(8);
				cell9.setCellStyle(styles.get("cell"));
				cell9.setCellValue(sdf.format(signRecord.getCreateTime()));

				r++;
			}

			OutputStream os = response.getOutputStream();
			wb.write(os);
			os.flush();
			os.close();

			String logDetail = "导出支出清单";
			operationLogService.save(currentAccount.getUserName(), OperationType.EXPORT, ServiceType.PAY, logDetail);

		} catch (Exception e) {
			logger.error("App清单导出失败");

			e.printStackTrace();
		}
	}

}
