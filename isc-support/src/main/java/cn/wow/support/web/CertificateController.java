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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import cn.wow.common.domain.Certificate;
import cn.wow.common.service.CertificateService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.pagination.PageMap;

@Controller
@RequestMapping(value = "certificate")
public class CertificateController extends AbstractController {

	private static Logger logger = LoggerFactory.getLogger(CertificateController.class);

	@Autowired
	private CertificateService certificateService;

	// 上传路径
	@Value("${certification.url}")
	protected String certificationUrl;

	@RequestMapping(value = "/list")
	public String list(HttpServletRequest httpServletRequest, Model model, String name, String startCreateTime,
			String endCreateTime, String startCertExpireDate, String endCertExpireDate, String startDescExpireDate,
			String endDescExpireDate, String sort, String order) {

		if(StringUtils.isBlank(sort)) {
			sort = "cert_expire_date";
		}
		if(StringUtils.isBlank(order)) {
			order = "asc";
		}
		
		Map<String, Object> map = new PageMap(httpServletRequest);
		String orderSql = sort + " " + order + ", name asc";
		map.put("custom_order_sql", orderSql);
		map.put("isDelete", "0");
		
		if (StringUtils.isNotBlank(name)) {
			map.put("qname", name);
			model.addAttribute("name", name);
		}

		if (StringUtils.isNotBlank(startCertExpireDate)) {
			map.put("startCertExpireDate", startCertExpireDate);
			model.addAttribute("startCertExpireDate", startCertExpireDate);
		}

		if (StringUtils.isNotBlank(endCertExpireDate)) {
			map.put("endCertExpireDate", endCertExpireDate);
			model.addAttribute("endCertExpireDate", endCertExpireDate);
		}

		if (StringUtils.isNotBlank(startDescExpireDate)) {
			map.put("startDescExpireDate", startDescExpireDate);
			model.addAttribute("startDescExpireDate", startDescExpireDate);
		}

		if (StringUtils.isNotBlank(endDescExpireDate)) {
			map.put("endDescExpireDate", endDescExpireDate);
			model.addAttribute("endDescExpireDate", endDescExpireDate);
		}

		if (StringUtils.isNotBlank(startCreateTime)) {
			map.put("startCreateTime", startCreateTime + " 00:00:00");
			model.addAttribute("startCreateTime", startCreateTime);
		}
		if (StringUtils.isNotBlank(endCreateTime)) {
			map.put("endCreateTime", endCreateTime + " 23:59:59");
			model.addAttribute("endCreateTime", endCreateTime);
		}

		List<Certificate> dataList = certificateService.selectAllList(map);

		model.addAttribute("dataList", dataList);
		model.addAttribute("resUrl", resUrl);
		model.addAttribute("order", order);
		model.addAttribute("sort", sort);
		return "certificate/certificate_list";
	}

	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, Model model, String id) {
		if (StringUtils.isNotBlank(id)) {
			Certificate certificate = certificateService.selectOne(Long.parseLong(id));
			model.addAttribute("facadeBean", certificate);
		}

		model.addAttribute("resUrl", resUrl);
		return "certificate/certificate_detail";
	}

	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public AjaxVO save(HttpServletRequest request, Model model, String id, String name, String certExpireDate,
			String descExpireDate, String remark,
			@RequestParam(value = "certFile", required = false) MultipartFile certFile,
			@RequestParam(value = "descFile", required = false) MultipartFile descFile) {
		Certificate certificate = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		AjaxVO vo = new AjaxVO();
		vo.setSuccess(true);

		try {
			if (StringUtils.isNotBlank(id)) {
				certificate = certificateService.selectOne(Long.parseLong(id));
				certificate.setName(name);
				certificate.setCertExpireDate(sdf.parse(certExpireDate));
				certificate.setDescExpireDate(sdf.parse(descExpireDate));

				if (certFile != null) {
					String certFileName = uploadImg(certFile, certificationUrl + "/" + certificate.getId() + "/", false, null);
					certificate.setCertFile(certFileName);
				}

				if (descFile != null) {
					String descFileName = uploadImg(descFile, certificationUrl + "/" + certificate.getId() + "/", false, null);
					certificate.setDescFile(descFileName);
				}

				certificate.setRemark(remark);
				certificateService.update(getCurrentUserName(), certificate);

				vo.setMsg("编辑成功");
			} else {
				Map<String, Object> rMap = new HashMap<String, Object>();
				rMap.put("name", name);
				List<Certificate> userList = certificateService.selectAllList(rMap);

				if (userList != null && userList.size() > 0) {
					vo.setData("userName");
					vo.setMsg("证书名称已经存在");
					vo.setSuccess(false);
					return vo;
				} else {
					certificate = new Certificate();
					certificate.setName(name);
					certificate.setCertExpireDate(sdf.parse(certExpireDate));
					certificate.setDescExpireDate(sdf.parse(descExpireDate));
					certificate.setCreateTime(new Date());
					certificate.setRemark(remark);
					certificate.setIsDelete(0);
					certificateService.save(getCurrentUserName(), certificate);

					if (certFile != null) {
						String certFileName = uploadImg(certFile, certificationUrl + "/" + certificate.getId() + "/", false, null);
						certificate.setCertFile(certFileName);
					}

					if (descFile != null) {
						String descFileName = uploadImg(descFile, certificationUrl + "/" + certificate.getId() + "/", false, null);
						certificate.setDescFile(descFileName);
					}
					certificateService.update(getCurrentUserName(), certificate);

					vo.setMsg("新增成功");
				}

			}
		} catch (Exception ex) {
			logger.error("证书保存失败", ex);
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
			Certificate certificate = certificateService.selectOne(Long.parseLong(id));

			if (certificate != null) {
				certificate.setIsDelete(1);
				certificateService.update(getCurrentUserName(), certificate);
			} else {
				vo.setMsg("删除失败，记录不存在");
				vo.setSuccess(false);
				return vo;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			logger.error("证书删除失败", ex);

			vo.setMsg("删除失败，系统异常");
			vo.setSuccess(false);
			return vo;
		}

		return vo;
	}
}