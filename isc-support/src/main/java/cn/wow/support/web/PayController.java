package cn.wow.support.web;

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
import org.springframework.web.bind.annotation.ResponseBody;
import cn.wow.common.domain.Pay;
import cn.wow.common.service.PayService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.pagination.PageMap;

@Controller
@RequestMapping(value = "pay")
public class PayController extends AbstractController {

	private static Logger logger = LoggerFactory.getLogger(PayController.class);

	@Autowired
	private PayService payService;

	@RequestMapping(value = "/list")
	public String list(HttpServletRequest httpServletRequest, Model model, String startCreateTime,
			String endCreateTime) {
		Map<String, Object> map = new PageMap(httpServletRequest);
		map.put("custom_order_sql", "create_time desc");
		map.put("isDelete", "0");

		if (StringUtils.isNotBlank(startCreateTime)) {
			map.put("startCreateTime", startCreateTime + " 00:00:00");
			model.addAttribute("startCreateTime", startCreateTime);
		}
		if (StringUtils.isNotBlank(endCreateTime)) {
			map.put("endCreateTime", endCreateTime + " 23:59:59");
			model.addAttribute("endCreateTime", endCreateTime);
		}

		List<Pay> dataList = payService.selectAllList(map);

		model.addAttribute("dataList", dataList);
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
	public AjaxVO save(HttpServletRequest request, Model model, String id, String remark, Double price) {
		Pay pay = null;
		AjaxVO vo = new AjaxVO();
		vo.setMsg("编辑成功");

		try {
			if (StringUtils.isNotBlank(id)) {
				pay = payService.selectOne(Long.parseLong(id));

				if (pay != null) {
					pay.setRemark(remark);
					pay.setPrice(price);
					payService.update(getCurrentUserName(), pay);
				}
			} else {
				pay = new Pay();
				pay.setRemark(remark);
				pay.setPrice(price);
				pay.setCreateTime(new Date());
				pay.setIsDelete(0);
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
}