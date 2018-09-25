package cn.wow.support.web;

import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

import cn.wow.common.service.SyncDataService;
import cn.wow.common.utils.AjaxVO;
import cn.wow.common.utils.JsonUtil;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.vo.AppDetailTrendVO;
import cn.wow.common.vo.AppDetailVO;
import cn.wow.common.vo.AppTotalItemVO;
import cn.wow.common.vo.AppTotalVO;

/**
 * 同步极光统计
 *
 */
@Controller
@RequestMapping(value = "syscData")
public class SyscDataController {

	// 文件上传根路径
	@Value("${img.root.url}")
	protected String rootPath;

	@Autowired
	private SyncDataService syncDataService;

	private static String tokenVal;

	private static Date lastSyncTime;

	private static final String NEW_SORT = "new";
	private static final String DESC_ORDER = "desc";

	@ResponseBody
	@RequestMapping(value = "/sync")
	public AjaxVO sync(HttpServletRequest request, String token) {
		AjaxVO vo = new AjaxVO();

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

		return vo;
	}

	@RequestMapping(value = "/list")
	public String list(HttpServletRequest request, Model model, String name, String sort, String order) {

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
			Collection<AppTotalVO> totalList = JsonUtil.fromJson(readJsonFile(), ArrayList.class, AppTotalVO.class);

			List<AppTotalVO> tempList = new ArrayList<AppTotalVO>();
			if (StringUtils.isNotBlank(name)) {
				for (AppTotalVO vo : totalList) {
					if (vo.getName().contains(name)) {
						tempList.add(vo);
					}
				}
			} else {
				tempList.addAll(totalList);
			}

			if (NEW_SORT.equals(sort)) {
				if (DESC_ORDER.equals(order)) {
					Collections.sort(tempList, AppTotalVO.newDescComparator);
				} else {
					Collections.sort(tempList, AppTotalVO.newAscComparator);
				}

			} else {
				if (DESC_ORDER.equals(order)) {
					Collections.sort(tempList, AppTotalVO.totalDescComparator);
				} else {
					Collections.sort(tempList, AppTotalVO.totalAscComparator);
				}
			}

			int fromIndex = pageSize * (pageNum - 1);
			int toIndex = pageSize * pageNum;
			if (toIndex > tempList.size()) {
				toIndex = tempList.size();
			}

			Page<AppTotalVO> dataList = PageHelper.startPage(pageNum, pageSize);
			dataList.setTotal(tempList.size());
			dataList.addAll(tempList.subList(fromIndex, toIndex));

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
}
