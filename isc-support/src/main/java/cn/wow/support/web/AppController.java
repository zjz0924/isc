package cn.wow.support.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import cn.wow.common.domain.Account;
import cn.wow.common.domain.App;
import cn.wow.common.domain.Certificate;
import cn.wow.common.domain.Combo;
import cn.wow.common.domain.Contacts;
import cn.wow.common.domain.SignRecord;
import cn.wow.common.service.AppService;
import cn.wow.common.service.CertificateService;
import cn.wow.common.service.ComboService;
import cn.wow.common.service.SignRecordService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.Contants;
import cn.wow.common.utils.ToolUtils;
import cn.wow.common.utils.pagination.PageMap;

@Controller
@RequestMapping(value = "app")
public class AppController extends AbstractController {

	private static Logger logger = LoggerFactory.getLogger(AppController.class);

	@Autowired
	private AppService appService;

	@Autowired
	private ComboService comboService;

	@Autowired
	private CertificateService certificateService;

	@Autowired
	private SignRecordService signRecordService;

	@Value("${app.url}")
	protected String appUrl;

	// 查询的条件，用于导出
	private Map<String, Object> queryMap = new PageMap(false);

	@RequestMapping(value = "/list")
	public String list(HttpServletRequest request, Model model, String name, String startEffectiveDate,
			String endEffectiveDate, String startExpireDate, String endExpireDate, String startCreateTime,
			String endCreateTime, String startUpdateTime, String endUpdateTime) {

		queryMap.clear();
		Map<String, Object> map = new PageMap(request);
		map.put("custom_order_sql", "expire_date asc, name asc");
		map.put("isDelete", "0");

		if (StringUtils.isNotBlank(name)) {
			map.put("qname", name);
			queryMap.put("qname", name);
			model.addAttribute("name", name);
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

		if (StringUtils.isNotBlank(startUpdateTime)) {
			map.put("startUpdateTime", startUpdateTime + " 00:00:00");
			queryMap.put("startUpdateTime", startUpdateTime + " 00:00:00");
			model.addAttribute("startUpdateTime", startUpdateTime);
		}
		if (StringUtils.isNotBlank(endUpdateTime)) {
			map.put("endUpdateTime", endUpdateTime + " 23:59:59");
			queryMap.put("endUpdateTime", endUpdateTime + " 23:59:59");
			model.addAttribute("endUpdateTime", endUpdateTime);
		}

		List<App> dataList = appService.selectAllList(map);
		model.addAttribute("dataList", dataList);
		model.addAttribute("resUrl", resUrl);

		return "app/app_list";
	}

	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, Model model, String id) {
		if (StringUtils.isNotBlank(id)) {
			App app = appService.selectOne(Long.parseLong(id));
			model.addAttribute("facadeBean", app);
		}

		// 套餐信息
		Map<String, Object> comboMap = new PageMap(false);
		comboMap.put("custom_order_sql", "name asc");
		comboMap.put("isDelete", "0");
		List<Combo> comboList = comboService.selectAllList(comboMap);

		Map<String, Object> certificateMap = new PageMap(false);
		certificateMap.put("custom_order_sql", "name asc");
		certificateMap.put("isDelete", "0");
		List<Certificate> certificateList = certificateService.selectAllList(certificateMap);

		model.addAttribute("comboList", comboList);
		model.addAttribute("certificateList", certificateList);

		return "app/app_detail";
	}

	@ResponseBody
	@RequestMapping(value = "/save")
	public AjaxVO save(HttpServletRequest request, Model model, String id, String appName, String appRemark,
			String contactsName, String wechat, String alipay, String phone, String contactsRemark, Long certId,
			Long comboId, @RequestParam(value = "unsignFile", required = false) MultipartFile unsignFile,
			@RequestParam(value = "signFile", required = false) MultipartFile signFile) {
		AjaxVO vo = new AjaxVO();
		vo.setMsg("编辑成功");

		App app = null;
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String timeStr = sdf.format(date);

		try {
			if (StringUtils.isNotBlank(id)) {
				app = appService.selectOne(Long.parseLong(id));

				if (app != null) {
					Map<String, Object> rMap = new HashMap<String, Object>();
					rMap.put("name", appName);
					rMap.put("isDelete", 0);
					rMap.put("id", id);
					List<App> appList = appService.selectAllList(rMap);

					if (appList != null && appList.size() > 0) {
						vo.setMsg("app名称已经存在");
						vo.setSuccess(false);
						return vo;
					} else {
						app.setName(appName);
						app.setRemark(appRemark);
						app.setUpdateTime(date);

						if (unsignFile != null) {
							String unsignFileName = uploadImg(unsignFile, appUrl + "/" + timeStr + "/", false, null);
							app.setUnsignFile(unsignFileName);
						}

						if (signFile != null) {
							String signFileName = uploadImg(signFile, appUrl + "/" + timeStr + "/", false, null);
							app.setSignFile(signFileName);
						}
						appService.update(getCurrentUserName(), app);
					}
				}
			} else {
				Map<String, Object> rMap = new HashMap<String, Object>();
				rMap.put("name", appName);
				rMap.put("isDelete", 0);
				List<App> appList = appService.selectAllList(rMap);

				if (appList != null && appList.size() > 0) {
					vo.setMsg("app名称已经存在");
					vo.setSuccess(false);
					return vo;
				} else {
					// 记录
					SignRecord signRecord = new SignRecord();
					signRecord.setCertId(certId);
					signRecord.setComboId(comboId);
					signRecord.setCreateTime(date);
					signRecord.setEffectiveDate(date);
					signRecord.setType(1);
					signRecord.setCreateTime(date);

					Combo combo = comboService.selectOne(comboId);
					signRecord.setPrice(combo.getPrice());
					signRecord.setExpireDate(ToolUtils.addMonth(date, combo.getDuration()));

					// app 信息
					app = new App();
					app.setName(appName);
					app.setRemark(appRemark);
					app.setCreateTime(date);
					app.setUpdateTime(date);
					app.setIsDelete(0);
					app.setEffectiveDate(signRecord.getEffectiveDate());
					app.setExpireDate(signRecord.getExpireDate());

					if (unsignFile != null) {
						String unsignFileName = uploadImg(unsignFile, appUrl + "/" + timeStr + "/", false, null);
						app.setUnsignFile(unsignFileName);
					}

					if (signFile != null) {
						String signFileName = uploadImg(signFile, appUrl + "/" + timeStr + "/", false, null);
						app.setSignFile(signFileName);
					}

					// 客户信息
					Contacts contacts = new Contacts();
					contacts.setAlipay(alipay);
					contacts.setIsDelete(0);
					contacts.setName(contactsName);
					contacts.setPhone(phone);
					contacts.setRemark(contactsRemark);
					contacts.setWechat(wechat);
					contacts.setCreateTime(date);

					appService.addApp(getCurrentUserName(), app, signRecord, contacts, signFile, unsignFile);
					vo.setMsg("添加成功");
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();

			logger.error("签名保存失败", ex);
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
			App app = appService.selectOne(Long.parseLong(id));

			if (app != null) {
				appService.deleteByPrimaryKey(getCurrentUserName(), app);
			} else {
				vo.setMsg("删除失败，记录不存在");
				vo.setSuccess(false);
				return vo;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			logger.error("签名删除失败", ex);

			vo.setMsg("删除失败，系统异常");
			vo.setSuccess(false);
			return vo;
		}

		return vo;
	}

	/**
	 * 续费
	 */
	@RequestMapping(value = "/renewDetail")
	public String renewDetail(HttpServletRequest request, Model model, Long appId) {
		model.addAttribute("appId", appId);
		
		// 套餐信息
		Map<String, Object> comboMap = new PageMap(false);
		comboMap.put("custom_order_sql", "name asc");
		comboMap.put("isDelete", "0");
		List<Combo> comboList = comboService.selectAllList(comboMap);

		model.addAttribute("comboList", comboList);
		return "app/app_renew";
	}

	@ResponseBody
	@RequestMapping(value = "/renew")
	public AjaxVO renew(HttpServletRequest request, Model model, Long appId, Long comboId) {
		AjaxVO vo = new AjaxVO();
		vo.setMsg("续费成功");

		try {
			Date date = new Date();

			SignRecord signRecord = new SignRecord();
			Combo combo = comboService.selectOne(comboId);

			// 获取新增的记录
			Map<String, Object> map = new PageMap(false);
			map.put("type", 1);
			map.put("appId", appId);
			
			SignRecord addRecord = null;
			List<SignRecord> signRecordList = signRecordService.selectAllList(map);
			if (signRecordList != null && signRecordList.size() > 0) {
				addRecord = signRecordList.get(0);
			}

			signRecord.setAppId(appId);
			if(addRecord != null) {
				signRecord.setCertId(addRecord.getCertId());
			}else {
				signRecord.setCertId(null);
			}
			
			signRecord.setComboId(comboId);
			signRecord.setCreateTime(date);
			signRecord.setEffectiveDate(date);
			signRecord.setExpireDate(ToolUtils.addMonth(date, combo.getDuration()));
			signRecord.setType(2);
			signRecord.setPrice(combo.getPrice());

			App app = appService.selectOne(appId);
			app.setUpdateTime(date);
			app.setEffectiveDate(signRecord.getEffectiveDate());
			app.setExpireDate(signRecord.getExpireDate());

			appService.renewApp(getCurrentUserName(), app, signRecord);

		} catch (Exception ex) {
			ex.printStackTrace();
			logger.error("续费失败", ex);

			vo.setMsg("删除失败，系统异常");
			vo.setSuccess(false);
			return vo;
		}

		return vo;
	}

}