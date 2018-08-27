package cn.wow.support.web;

import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;
import cn.wow.common.domain.Contacts;
import cn.wow.common.service.ContactsService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.pagination.PageMap;

@Controller
@RequestMapping(value = "contacts")
public class ContactsController extends AbstractController {

	private static Logger logger = LoggerFactory.getLogger(ContactsController.class);

	@Autowired
	private ContactsService contactsService;

	@RequestMapping(value = "/list")
	public String list(HttpServletRequest httpServletRequest, Model model, String name, String wechat, String alipay,
			String phone, String startCreateTime, String endCreateTime) {
		Map<String, Object> map = new PageMap(httpServletRequest);
		map.put("custom_order_sql", "name asc");
		map.put("isDelete", "0");

		if (StringUtils.isNotBlank(name)) {
			map.put("qname", name);
			model.addAttribute("name", name);
		}

		if (StringUtils.isNotBlank(wechat)) {
			map.put("wechat", wechat);
			model.addAttribute("wechat", wechat);
		}

		if (StringUtils.isNotBlank(alipay)) {
			map.put("alipay", alipay);
			model.addAttribute("alipay", alipay);
		}

		if (StringUtils.isNotBlank(phone)) {
			map.put("phone", phone);
			model.addAttribute("phone", phone);
		}
		if (StringUtils.isNotBlank(startCreateTime)) {
			map.put("startCreateTime", startCreateTime + " 00:00:00");
			model.addAttribute("startCreateTime", startCreateTime);
		}
		if (StringUtils.isNotBlank(endCreateTime)) {
			map.put("endCreateTime", endCreateTime + " 23:59:59");
			model.addAttribute("endCreateTime", endCreateTime);
		}

		List<Contacts> dataList = contactsService.selectAllList(map);
		model.addAttribute("dataList", dataList);

		return "contacts/contacts_list";
	}

	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, Model model, String id) {
		if (StringUtils.isNotBlank(id)) {
			Contacts contacts = contactsService.selectOne(Long.parseLong(id));
			model.addAttribute("facadeBean", contacts);
		}

		return "contacts/contacts_detail";
	}

	@ResponseBody
	@RequestMapping(value = "/save")
	public AjaxVO save(HttpServletRequest request, Model model, String id, String name, String wechat, String alipay,
			String phone, String remark) {
		Contacts contacts = null;
		AjaxVO vo = new AjaxVO();
		vo.setSuccess(true);

		try {
			if (StringUtils.isNotBlank(id)) {
				
				Map<String, Object> rMap = new HashMap<String, Object>();
				rMap.put("wechat", wechat);
				rMap.put("isDelete", 0);
				rMap.put("id", id);
				List<Contacts> contactsList = contactsService.selectAllList(rMap);

				if (contactsList != null && contactsList.size() > 0) {
					vo.setMsg("客户已经存在");
					vo.setSuccess(false);
					return vo;
				}else {
					contacts = contactsService.selectOne(Long.parseLong(id));
					contacts.setName(name);
					contacts.setWechat(wechat);
					contacts.setAlipay(alipay);
					contacts.setPhone(phone);
					contacts.setRemark(remark);
					contactsService.update(getCurrentUserName(), contacts);

					vo.setMsg("编辑成功");
				}
			} else {
				Map<String, Object> rMap = new HashMap<String, Object>();
				rMap.put("wechat", wechat);
				rMap.put("isDelete", 0);
				List<Contacts> contactsList = contactsService.selectAllList(rMap);

				if (contactsList != null && contactsList.size() > 0) {
					vo.setMsg("客户已经存在");
					vo.setSuccess(false);
					return vo;
				} else {
					contacts = new Contacts();
					contacts.setName(name);
					contacts.setWechat(wechat);
					contacts.setAlipay(alipay);
					contacts.setPhone(phone);
					contactsService.save(getCurrentUserName(), contacts);
				}
			}
		} catch (Exception ex) {
			logger.error("客户保存失败", ex);
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

		try {
			Contacts contacts = contactsService.selectOne(Long.parseLong(id));

			if (contacts != null) {
				contactsService.deleteByPrimaryKey(getCurrentUserName(), contacts);
			} else {
				vo.setMsg("删除失败，记录不存在");
				vo.setSuccess(false);
				return vo;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			logger.error("客户删除失败", ex);

			vo.setMsg("删除失败，系统异常");
			vo.setSuccess(false);
			return vo;
		}

		return vo;
	}
}