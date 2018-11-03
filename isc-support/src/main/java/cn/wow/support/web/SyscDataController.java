package cn.wow.support.web;

import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.Page;

import cn.wow.common.domain.Certificate;
import cn.wow.common.service.CertificateService;
import cn.wow.common.service.SyncDataService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.ImportExcelUtil;
import cn.wow.common.utils.JsonUtil;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.vo.AppDetailTrendVO;
import cn.wow.common.vo.AppDetailVO;
import cn.wow.common.vo.AppNumVO;

/**
 * 同步极光统计
 *
 */
@Controller
@RequestMapping(value = "syscData")
public class SyscDataController {

	private static Logger logger = LoggerFactory.getLogger(SyscDataController.class);

	// 文件上传根路径
	@Value("${img.root.url}")
	protected String rootPath;

	@Autowired
	private SyncDataService syncDataService;
	@Autowired
	private CertificateService certificateService;

	private static String tokenVal;

	private static Date lastSyncTime;

	private List<AppNumVO> exportList = new ArrayList<AppNumVO>();

	private static final String NEW_SORT = "new";
	private static final String DESC_ORDER = "desc";

	@ResponseBody
	@RequestMapping(value = "/sync")
	public AjaxVO sync(HttpServletRequest request, String token) {
		long t1 = System.currentTimeMillis();

		AjaxVO vo = new AjaxVO();
		vo.setMsg("同步成功");

		if (!StringUtils.isNotBlank(token)) {
			vo.setSuccess(false);
			vo.setMsg("同步失败：token的值不能为空");
			return vo;
		} else {
			tokenVal = token;
		}

		try {
			syncDataService.syncList(token);
			lastSyncTime = new Date();
		} catch (Exception ex) {
			ex.printStackTrace();
			vo.setSuccess(false);
			vo.setMsg("同步失败：" + ex.getMessage());
		}

		logger.info("同步花费时间：" + (System.currentTimeMillis() - t1) + " ms");
		return vo;
	}

	@RequestMapping(value = "/list")
	public String list(HttpServletRequest request, Model model, String name, String sort, String order, Long certId) {

		Map<String, Object> map = new PageMap(request);
		int pageSize = 20;
		int pageNum = (Integer) map.get("pageNum");

		if (StringUtils.isBlank(sort)) {
			sort = "new";
		}

		if (StringUtils.isBlank(order)) {
			order = "desc";
		}

		try {
			// 从json文件中读取
			Collection<AppNumVO> totalList = JsonUtil.fromJson(readJsonFile(), ArrayList.class, AppNumVO.class);

			List<AppNumVO> tempList = new ArrayList<AppNumVO>();
			if (StringUtils.isNotBlank(name)) {
				for (AppNumVO vo : totalList) {
					if (vo.getAppName().contains(name)) {
						tempList.add(vo);
					}
				}
			} else {
				tempList.addAll(totalList);
			}

			if (certId != null) {
				List<AppNumVO> tList = new ArrayList<AppNumVO>();
				for (AppNumVO vo : tempList) {
					if (vo.getCertId() != null && vo.getCertId().longValue() == certId.longValue()) {
						tList.add(vo);
					}
				}
				tempList.clear();
				tempList.addAll(tList);
			}

			if (NEW_SORT.equals(sort)) {
				if (DESC_ORDER.equals(order)) {
					Collections.sort(tempList, AppNumVO.newDescComparator);
				} else {
					Collections.sort(tempList, AppNumVO.newAscComparator);
				}

			} else {
				if (DESC_ORDER.equals(order)) {
					Collections.sort(tempList, AppNumVO.totalDescComparator);
				} else {
					Collections.sort(tempList, AppNumVO.totalAscComparator);
				}
			}

			exportList.clear();
			exportList.addAll(tempList);

			int fromIndex = pageSize * (pageNum - 1);
			int toIndex = pageSize * pageNum;
			if (fromIndex > tempList.size()) {
				fromIndex = 0;
				if (tempList.size() > pageSize) {
					toIndex = pageSize;
				} else {
					toIndex = tempList.size();
				}
			}
			if (toIndex > tempList.size()) {
				toIndex = tempList.size();
			}

			Page<AppNumVO> dataList = new Page<AppNumVO>(pageNum, pageSize);
			dataList.setTotal(tempList.size());
			dataList.addAll(tempList.subList(fromIndex, toIndex));

			// 证书信息
			Map<String, Object> certificateMap = new PageMap(false);
			certificateMap.put("custom_order_sql", "name asc");
			certificateMap.put("isDelete", "0");
			List<Certificate> certificateList = certificateService.selectAllList(certificateMap);

			model.addAttribute("certId", certId);
			model.addAttribute("certificateList", certificateList);
			model.addAttribute("dataList", dataList);
			model.addAttribute("sort", sort);
			model.addAttribute("order", order);
			model.addAttribute("name", name);
			model.addAttribute("token", tokenVal);
			model.addAttribute("lastSyncTime", lastSyncTime);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "jiguang/list";
	}

	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, Model model, String appKey) {

		try {
			AppDetailVO vo = syncDataService.syncDetail(tokenVal, appKey);

			// 时间列表
			List<String> dateList = new ArrayList<String>();
			// 值列表
			List<Integer> valueList = new ArrayList<Integer>();

			if (vo != null) {
				List<AppDetailTrendVO> trendList = vo.getTrend();
				for (AppDetailTrendVO trendVO : trendList) {
					dateList.add(trendVO.getDate().substring(8));
					valueList.add(trendVO.getNewUser());
				}
			}

			model.addAttribute("monthTitle", new SimpleDateFormat("yyyy-MM").format(new Date()));
			model.addAttribute("date", JsonUtil.toJson(dateList));
			model.addAttribute("val", JsonUtil.toJson(valueList));
			model.addAttribute("newUser", vo.getBase().getReguser());
			model.addAttribute("amountUser", vo.getBase().getAmountuser());
			model.addAttribute("activeUser", vo.getBase().getActiveuser());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "jiguang/detail";
	}

	private String readJsonFile() throws Exception {
		// 文件上传路径
		String fileName = rootPath + "/json/app_statistic.json";

		// 读取字节转换到字符
		FileInputStream fileInputStream = new FileInputStream(fileName);
		InputStreamReader reader = new InputStreamReader(fileInputStream, "UTF-8");
		StringBuilder builder = new StringBuilder();
		char[] buf = new char[64];
		int count = 0;
		try {
			while ((count = reader.read(buf)) != -1) {
				builder.append(buf, 0, count);
			}
		} catch (Exception e) {

		} finally {
			reader.close();
		}

		return builder.toString();
	}

	/**
	 * 导出列表
	 */
	@RequestMapping(value = "/export")
	public void export(HttpServletRequest request, HttpServletResponse response) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd");
		String filename = "极光统计清单-" + sdf2.format(new Date());

		try {
			// 设置头
			ImportExcelUtil.setResponseHeader(response, filename + ".xlsx");

			Workbook wb = new SXSSFWorkbook(100); // 保持100条在内存中，其它保存到磁盘中
			// 工作簿
			Sheet sh = wb.createSheet("APP清单");
			sh.setColumnWidth(0, (short) 8000);
			sh.setColumnWidth(1, (short) 8000);
			sh.setColumnWidth(2, (short) 5000);
			sh.setColumnWidth(3, (short) 5000);

			Map<String, CellStyle> styles = ImportExcelUtil.createStyles(wb);

			String[] titles = { "APP名称", "证书名称", "今日新增用户", "总用户" };
			int r = 0;

			Row timeRow = sh.createRow(r++);
			timeRow.setHeight((short) 450);
			Cell tCell1 = timeRow.createCell(0);
			tCell1.setCellStyle(styles.get("cell"));
			tCell1.setCellValue("上次同步时间：");

			Cell tCell2 = timeRow.createCell(1);
			tCell2.setCellStyle(styles.get("cell"));
			tCell2.setCellValue(sdf.format(lastSyncTime));

			Row titleRow = sh.createRow(r++);
			titleRow.setHeight((short) 450);
			for (int k = 0; k < titles.length; k++) {
				Cell cell = titleRow.createCell(k);
				cell.setCellStyle(styles.get("header"));
				cell.setCellValue(titles[k]);
			}

			for (int j = 0; j < exportList.size(); j++) {// 添加数据
				Row contentRow = sh.createRow(r);
				contentRow.setHeight((short) 400);
				AppNumVO vo = exportList.get(j);

				Cell cell1 = contentRow.createCell(0);
				cell1.setCellStyle(styles.get("cell"));
				cell1.setCellValue(vo.getAppName());

				Cell cell2 = contentRow.createCell(1);
				cell2.setCellStyle(styles.get("cell"));
				cell2.setCellValue(vo.getCertName());

				Cell cell3 = contentRow.createCell(2);
				cell3.setCellStyle(styles.get("cell"));
				if (vo.getItem() != null) {
					cell3.setCellValue(vo.getItem().getAmountNewToday());
				}

				Cell cell4 = contentRow.createCell(3);
				cell4.setCellStyle(styles.get("cell"));
				if (vo.getItem() != null) {
					cell4.setCellValue(vo.getItem().getUserAmount());
				}

				r++;
			}

			OutputStream os = response.getOutputStream();
			wb.write(os);
			os.flush();
			os.close();

		} catch (Exception e) {
			logger.error("App清单导出失败");

			e.printStackTrace();
		}
	}
}
