package cn.wow.support.web;

import java.text.ParseException;
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

import cn.wow.common.domain.App;
import cn.wow.common.domain.Certificate;
import cn.wow.common.domain.Combo;
import cn.wow.common.domain.Contacts;
import cn.wow.common.domain.SignRecord;
import cn.wow.common.service.AppService;
import cn.wow.common.service.CertificateService;
import cn.wow.common.service.ComboService;
import cn.wow.common.service.ContactsService;
import cn.wow.common.service.OperationLogService;
import cn.wow.common.service.SignRecordService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.ToolUtils;
import cn.wow.common.utils.pagination.PageMap;

@Controller
@RequestMapping(value = "unsign")
public class UnsignAppController extends AbstractController {

	private static Logger logger = LoggerFactory.getLogger(UnsignAppController.class);

	@Autowired
	private AppService appService;

	@Autowired
	private ComboService comboService;

	@Autowired
	private CertificateService certificateService;

	@Value("${app.url}")
	protected String appUrl;

	@Autowired
	private ContactsService contactsService;

	/**
	 * 未签名列表
	 */
	@RequestMapping(value = "/list")
	public String list(HttpServletRequest request, Model model, String name, String startCreateTime,
			String endCreateTime, String sort, String order, String wechat, String startUpdateTime,
			String endUpdateTime) {

		Map<String, Object> map = new PageMap(request);
		map.put("isDelete", "0");
		map.put("isUnsign", "1");

		if (StringUtils.isBlank(sort)) {
			sort = "create_time";
		}
		if (StringUtils.isBlank(order)) {
			order = "desc";
		}

		String orderSql = sort + " " + order + ", name asc";
		map.put("custom_order_sql", orderSql);

		if (StringUtils.isNotBlank(name)) {
			map.put("qname", name);
			model.addAttribute("name", name);
		}
		if (StringUtils.isNotBlank(startCreateTime)) {
			map.put("startCreateTime", startCreateTime + " 00:00:00");
			model.addAttribute("startCreateTime", startCreateTime);
		}
		if (StringUtils.isNotBlank(endCreateTime)) {
			map.put("endCreateTime", endCreateTime + " 23:59:59");
			model.addAttribute("endCreateTime", endCreateTime);
		}
		if (StringUtils.isNotBlank(startUpdateTime)) {
			map.put("startUpdateTime", startUpdateTime + " 00:00:00");
			model.addAttribute("startUpdateTime", startUpdateTime);
		}
		if (StringUtils.isNotBlank(endUpdateTime)) {
			map.put("endUpdateTime", endUpdateTime + " 23:59:59");
			model.addAttribute("endUpdateTime", endUpdateTime);
		}
		if (StringUtils.isNotBlank(wechat)) {
			map.put("wechat", wechat);
			model.addAttribute("wechat", wechat);
		}

		List<App> dataList = appService.selectAllList(map);
		model.addAttribute("dataList", dataList);
		model.addAttribute("resUrl", resUrl);

		model.addAttribute("sort", sort);
		model.addAttribute("order", order);

		return "unsign/unsign_list";
	}

	@RequestMapping(value = "/detail")
	public String unsignDetail(HttpServletRequest request, Model model, String id) {
		if (StringUtils.isNotBlank(id)) {
			App app = appService.selectOne(Long.parseLong(id));
			model.addAttribute("facadeBean", app);
		}

		return "unsign/unsign_detail";
	}

	@ResponseBody
	@RequestMapping(value = "/save")
	public AjaxVO unsignSave(HttpServletRequest request, Model model, String id, String appName, String appRemark,
			String contactsName, String wechat, String alipay, String phone, String contactsRemark, Long contactsId,
			@RequestParam(value = "unsignFile", required = false) MultipartFile unsignFile,
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
					if (StringUtils.isBlank(appName)) {
						vo.setMsg("app名称不能为空");
						vo.setSuccess(false);
						return vo;
					}

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

						Contacts contacts = new Contacts();
						if (contactsId != null) {
							contacts = contactsService.selectOne(contactsId);
							contacts.setAlipay(alipay);
							contacts.setIsDelete(0);
							contacts.setName(contactsName);
							contacts.setPhone(phone);
							contacts.setRemark(contactsRemark);
							contacts.setWechat(wechat);
							contacts.setCreateTime(date);
						} else {
							if (StringUtils.isNotBlank(alipay) || StringUtils.isNotBlank(contactsName)
									|| StringUtils.isNotBlank(phone) || StringUtils.isNotBlank(contactsRemark)
									|| StringUtils.isNotBlank(wechat)) {
								contacts = new Contacts();

								contacts.setAlipay(alipay);
								contacts.setIsDelete(0);
								contacts.setName(contactsName);
								contacts.setPhone(phone);
								contacts.setRemark(contactsRemark);
								contacts.setWechat(wechat);
								contacts.setCreateTime(date);
							}
						}

						appService.update(getCurrentUserName(), app, contacts);
					}
				}
			} else {
				if (StringUtils.isBlank(appName)) {
					vo.setMsg("app名称不能为空");
					vo.setSuccess(false);
					return vo;
				}

				Map<String, Object> rMap = new HashMap<String, Object>();
				rMap.put("name", appName);
				rMap.put("isDelete", 0);
				List<App> appList = appService.selectAllList(rMap);

				if (appList != null && appList.size() > 0) {
					vo.setMsg("app名称已经存在");
					vo.setSuccess(false);
					return vo;
				} else {
					// app 信息
					app = new App();
					app.setName(appName);
					app.setRemark(appRemark);
					app.setCreateTime(date);
					app.setUpdateTime(date);
					app.setIsDelete(0);
					app.setValid(1);
					app.setIsUnsign(1);

					if (unsignFile != null) {
						String unsignFileName = uploadImg(unsignFile, appUrl + "/" + timeStr + "/", false, null);
						app.setUnsignFile(unsignFileName);
					}

					if (signFile != null) {
						String signFileName = uploadImg(signFile, appUrl + "/" + timeStr + "/", false, null);
						app.setSignFile(signFileName);
					}

					// 客户信息
					Contacts contacts = null;
					if (StringUtils.isNotBlank(alipay) || StringUtils.isNotBlank(contactsName)
							|| StringUtils.isNotBlank(phone) || StringUtils.isNotBlank(contactsRemark)
							|| StringUtils.isNotBlank(wechat)) {
						contacts = new Contacts();

						contacts.setAlipay(alipay);
						contacts.setIsDelete(0);
						contacts.setName(contactsName);
						contacts.setPhone(phone);
						contacts.setRemark(contactsRemark);
						contacts.setWechat(wechat);
						contacts.setCreateTime(date);
					}

					appService.addApp(getCurrentUserName(), app, null, contacts);
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

	@RequestMapping(value = "/signDetail")
	public String sign(HttpServletRequest request, Model model, String id) {
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

		model.addAttribute("effectiveDate", new Date());
		model.addAttribute("comboList", comboList);
		model.addAttribute("certificateList", certificateList);

		return "unsign/sign";
	}

	@ResponseBody
	@RequestMapping(value = "/sign")
	public AjaxVO renew(HttpServletRequest request, Model model, String id, String appName, String appRemark,
			String contactsName, String wechat, String alipay, String phone, String contactsRemark, Long certId,
			String payType, Long comboId, String effectiveDate,
			@RequestParam(value = "unsignFile", required = false) MultipartFile unsignFile,
			@RequestParam(value = "signFile", required = false) MultipartFile signFile) {
		AjaxVO vo = new AjaxVO();
		vo.setMsg("签名成功");

		App app = null;
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String timeStr = sdf.format(date);

		// 生效时间
		Date efDate = date;
		if (StringUtils.isNotBlank(effectiveDate)) {
			try {
				efDate = new SimpleDateFormat("yyyy-MM-dd").parse(effectiveDate);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}

		try {
			if (StringUtils.isNotBlank(id)) {
				app = appService.selectOne(Long.parseLong(id));

				if (StringUtils.isBlank(appName) && unsignFile == null) {
					vo.setMsg("app名称和未签名文件不能同时为空");
					vo.setSuccess(false);
					return vo;
				}

				if (StringUtils.isBlank(appName) && unsignFile != null) {
					String sourceName = unsignFile.getOriginalFilename();
					appName = sourceName.substring(0, sourceName.indexOf("."));
				}

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
					// 记录
					SignRecord signRecord = new SignRecord();
					signRecord.setCertId(certId);
					signRecord.setComboId(comboId);
					signRecord.setCreateTime(date);
					signRecord.setEffectiveDate(efDate);
					signRecord.setType(1);
					signRecord.setCreateTime(date);
					signRecord.setPayType(payType);

					Combo combo = comboService.selectOne(comboId);
					signRecord.setPrice(combo.getPrice());
					signRecord.setExpireDate(ToolUtils.addMonth(signRecord.getEffectiveDate(), combo.getDuration()));

					app.setName(appName);
					app.setRemark(appRemark);
					app.setUpdateTime(date);
					app.setIsUnsign(0);
					app.setEffectiveDate(signRecord.getEffectiveDate());
					app.setExpireDate(signRecord.getExpireDate());
					app.setCertId(certId);

					if (unsignFile != null) {
						String unsignFileName = uploadImg(unsignFile, appUrl + "/" + timeStr + "/", false, null);
						app.setUnsignFile(unsignFileName);
					}

					if (signFile != null) {
						String signFileName = uploadImg(signFile, appUrl + "/" + timeStr + "/", false, null);
						app.setSignFile(signFileName);
					}

					Contacts contacts = null;
					if (app.getContactsId() != null) {
						contacts = contactsService.selectOne(app.getContactsId());
						contacts.setAlipay(alipay);
						contacts.setName(contactsName);
						contacts.setPhone(phone);
						contacts.setRemark(contactsRemark);
						contacts.setWechat(wechat);
						contacts.setCreateTime(date);
					} else {
						contacts = new Contacts();
						contacts.setAlipay(alipay);
						contacts.setIsDelete(0);
						contacts.setName(contactsName);
						contacts.setPhone(phone);
						contacts.setRemark(contactsRemark);
						contacts.setWechat(wechat);
						contacts.setCreateTime(date);
					}

					appService.addApp(getCurrentUserName(), app, signRecord, contacts);
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
}
