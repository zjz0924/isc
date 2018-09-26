package cn.wow.support.web;

import java.io.OutputStream;
import java.text.SimpleDateFormat;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.wow.common.domain.Account;
import cn.wow.common.domain.Pay;
import cn.wow.common.service.OperationLogService;
import cn.wow.common.service.PayService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.Contants;
import cn.wow.common.utils.ImportExcelUtil;
import cn.wow.common.utils.operationlog.OperationType;
import cn.wow.common.utils.operationlog.ServiceType;
import cn.wow.common.utils.pagination.PageMap;

@Controller
@RequestMapping(value = "pay")
public class PayController extends AbstractController {

	private static Logger logger = LoggerFactory.getLogger(PayController.class);

	@Autowired
	private PayService payService;
	
	@Autowired
	private OperationLogService operationLogService;
	
	// 查询的条件，用于导出
	private Map<String, Object> queryMap = new PageMap(false);

	@RequestMapping(value = "/list")
	public String list(HttpServletRequest httpServletRequest, Model model, String startCreateTime,
			String endCreateTime, String startPayDate, String endPayDate) {
		
		Map<String, Object> map = new PageMap(httpServletRequest);
		map.put("custom_order_sql", "pay_date desc");
		map.put("isDelete", "0");
		
		queryMap.clear();
		queryMap.put("custom_order_sql", "pay_date desc");
		queryMap.put("isDelete", "0");
		
		if (StringUtils.isNotBlank(startPayDate)) {
			map.put("startPayDate", startPayDate);
			queryMap.put("startPayDate", startPayDate);
			model.addAttribute("startPayDate", startPayDate);
		}
		
		if (StringUtils.isNotBlank(endPayDate)) {
			map.put("endPayDate", endPayDate);
			queryMap.put("endPayDate", endPayDate);
			model.addAttribute("endPayDate", endPayDate);
		}
		
		if (StringUtils.isNotBlank(endCreateTime)) {
			map.put("endCreateTime", endCreateTime + " 23:59:59");
			queryMap.put("endCreateTime", endCreateTime + " 23:59:59");
			model.addAttribute("endCreateTime", endCreateTime);
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

		List<Pay> dataList = payService.selectAllList(map);

		// 总金额
		double total = payService.statisticTotal(queryMap);
		
		model.addAttribute("dataList", dataList);
		model.addAttribute("total", total);
		return "pay/pay_list";
	}

	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, Model model, String id) {
		if (StringUtils.isNotBlank(id)) {
			Pay pay = payService.selectOne(Long.parseLong(id));
			model.addAttribute("facadeBean", pay);
		}

		return "pay/pay_detail";
	}

	@ResponseBody
	@RequestMapping(value = "/save")
	public AjaxVO save(HttpServletRequest request, Model model, String id, String remark, Double price, String payDate) {
		Pay pay = null;
		AjaxVO vo = new AjaxVO();
		vo.setMsg("编辑成功");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		try {
			if (StringUtils.isNotBlank(id)) {
				pay = payService.selectOne(Long.parseLong(id));

				if (pay != null) {
					pay.setRemark(remark);
					pay.setPrice(price);
					pay.setPayDate(sdf.parse(payDate));
					payService.update(getCurrentUserName(), pay);
				}
			} else {
				pay = new Pay();
				pay.setRemark(remark);
				pay.setPrice(price);
				pay.setCreateTime(new Date());
				pay.setIsDelete(0);
				pay.setPayDate(sdf.parse(payDate));
				payService.save(getCurrentUserName(), pay);

				vo.setMsg("添加成功");
			}
		} catch (Exception ex) {
			ex.printStackTrace();

			logger.error("支出保存失败", ex);
			vo.setMsg("保存失败，系统异常");
			vo.setSuccess(false);
			return vo;
		}

		return vo;
	}

	@ResponseBody
	@RequestMapping(value = "/delete")
	public AjaxVO delete(HttpServletRequest request, String id) {
		AjaxVO vo = new AjaxVO();
		vo.setMsg("删除成功");

		try {
			Pay pay = payService.selectOne(Long.parseLong(id));

			if (pay != null) {
				payService.deleteByPrimaryKey(getCurrentUserName(), pay);
			} else {
				vo.setMsg("删除失败，记录不存在");
				vo.setSuccess(false);
				return vo;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			logger.error("支出删除失败", ex);

			vo.setMsg("删除失败，系统异常");
			vo.setSuccess(false);
			return vo;
		}

		return vo;
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
		String filename = "支出清单-" + sdf2.format(new Date());
		
		try {
			// 设置头
			ImportExcelUtil.setResponseHeader(response, filename + ".xlsx");

			Workbook wb = new SXSSFWorkbook(100); // 保持100条在内存中，其它保存到磁盘中
			// 工作簿
			Sheet sh = wb.createSheet("支出清单");
			sh.setColumnWidth(0, (short) 4000);
			sh.setColumnWidth(1, (short) 4000);
			sh.setColumnWidth(2, (short) 4000);
			sh.setColumnWidth(3, (short) 9000);
			
			Map<String, CellStyle> styles = ImportExcelUtil.createStyles(wb);

			String[] titles = {"支付时间", "备注", "金额/元", "创建时间"};
			int r = 0;
			
			Row titleRow = sh.createRow(0);
			titleRow.setHeight((short) 450);
			for(int k = 0; k < titles.length; k++){
				Cell cell = titleRow.createCell(k);
				cell.setCellStyle(styles.get("header"));
				cell.setCellValue(titles[k]);
			}
			
			++r;
			
			List<Pay> dataList = payService.selectAllList(queryMap);
			for (int j = 0; j < dataList.size(); j++) {// 添加数据
				Row contentRow = sh.createRow(r);
				contentRow.setHeight((short) 400);
				Pay pay = dataList.get(j);

				Cell cell1 = contentRow.createCell(0);
				cell1.setCellStyle(styles.get("cell"));
				if(pay.getPayDate() != null) {
					cell1.setCellValue(sdf1.format(pay.getPayDate()));
				}

				Cell cell2 = contentRow.createCell(1);
				cell2.setCellStyle(styles.get("cell"));
				cell2.setCellValue(pay.getRemark());

				Cell cell3 = contentRow.createCell(2);
				cell3.setCellStyle(styles.get("cell"));
				cell3.setCellValue(pay.getPrice());

				Cell cell4 = contentRow.createCell(3);
				cell4.setCellStyle(styles.get("cell"));
				cell4.setCellValue(sdf.format(pay.getCreateTime()));

				r++;
			}

			OutputStream os = response.getOutputStream();
			wb.write(os);
			os.flush();
			os.close();
			
			String logDetail =  "导出支出清单";
			operationLogService.save(currentAccount.getUserName(), OperationType.EXPORT, ServiceType.PAY, logDetail);
			
		} catch (Exception e) {
			logger.error("App清单导出失败");
			
			e.printStackTrace();
		}
	}
}