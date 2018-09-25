package cn.wow.common.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import cn.wow.common.domain.App;
import cn.wow.common.service.AppService;
import cn.wow.common.service.SyncDataService;
import cn.wow.common.utils.DateUtils;
import cn.wow.common.utils.JsonUtil;
import cn.wow.common.utils.pagination.PageMap;
import cn.wow.common.vo.AppDetailVO;
import cn.wow.common.vo.AppListVO;
import cn.wow.common.vo.AppTotalItemVO;
import cn.wow.common.vo.AppTotalVO;
import cn.wow.common.vo.AppVO;

@Service
@Transactional
public class SyncDataServiceImpl implements SyncDataService {

	// 照片上传根路径
	@Value("${img.root.url}")
	protected String rootPath;

	@Autowired
	private AppService appService;

	// 页数
	private final int pageSize = 1000;

	private final String hostApi = "https://api.srv.jpush.cn/v1/";

	// 获取列表API
	private final String listAPI = hostApi + "portal-appdev/app/ajax_appList?appName=&pageIndex=1&pageSize=" + pageSize;

	// 获取数量API
	private final String totalAPI = hostApi + "portal-appdev/app/ajax_appListTotalUserCnt?appKeys=";

	// 获取详情API
	private final String detailAPI = hostApi
			+ "stat/apps/{0}/data/profiles?apkver=&channel=&end={1}&platform=&start={2}";

	/**
	 * 列表信息
	 */
	public void syncList(String token) throws Exception {
		
		// 本地app列表
		Map<String, Object> map = new PageMap(false);
		map.put("isDelete", "0");
		List<App> appList = appService.selectAllList(map);

		Set<String> appNameSet = new HashSet<String>();
		for (App app : appList) {
			appNameSet.add(app.getName());
		}
		
		// 获取极光的app列表
		String jgAppStr = getData(listAPI, token);
		AppListVO jgAppList = JsonUtil.fromJson(jgAppStr, AppListVO.class);
		List<AppVO> appVOList =  jgAppList.getApps();
		
		// 每组去获取 极光的列表数据
		List<AppTotalVO> totalList = new ArrayList<AppTotalVO>();
		
		int totalNum = appVOList == null ? 0 : appVOList.size();
		int pageSize = 100;
		int time = totalNum / pageSize;
		
		if(totalNum % 50 != 0) {
			++time;
		}
		
		Map<String, String> appNameMap = new HashMap<String, String>();
		
		for(int i = 1; i <= time; i++) {
			
			StringBuffer appIdsBuf = new StringBuffer("");
			
			int fromIndex = pageSize * (i - 1);
			int toIndex = pageSize * i;
			if (toIndex > totalNum) {
				toIndex = totalNum;
			}
			
			List<AppVO> subAppList = appVOList.subList(fromIndex, toIndex);
			for (AppVO vo : subAppList) {
				if (appNameSet.contains(vo.getName())) {
					appIdsBuf.append(vo.getAppKey() + ",");
					appNameMap.put(vo.getAppKey(), vo.getName());
				}
			}
			
			String appIds = appIdsBuf.toString();
			if (StringUtils.isNotBlank(appIds)) {
				appIds = appIds.substring(0, appIds.length() - 1);
			}

			// 获取APP数量
			pareseNum(appIds, token, totalList);
		}

		for (AppTotalVO vo : totalList) {
			vo.setName(appNameMap.get(vo.getKey()));
		}
		
		// 保存数据
		writeJsonFile(JsonUtil.toJson(totalList));
	}

	/**
	 * 详情信息
	 */
	public AppDetailVO syncDetail(String token, String appKey) throws Exception {
		String startDate = DateUtils.getMonthStart().replaceAll("-", "");
		String endDate = DateUtils.getMonthEnd().replaceAll("-", "");

		String api = MessageFormat.format(detailAPI, new Object[] { appKey, endDate, startDate });
		
		String jsonVal = getData(api, token);
		AppDetailVO appDetailVO = JsonUtil.fromJson(jsonVal, AppDetailVO.class);

		return appDetailVO;
	}

	public String getData(String url, String token) throws Exception {
		HttpClient client = new HttpClient();
		// 设置 Http 连接超时为5秒
		client.getHttpConnectionManager().getParams().setConnectionTimeout(5000);
		GetMethod method = new GetMethod(url);

		// 设置请求的编码方式
		method.addRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=" + "utf-8");
		method.addRequestHeader("Authorization", token);

		int statusCode = client.executeMethod(method);
		if (statusCode == HttpStatus.SC_FORBIDDEN) {
			throw new RuntimeException("Token不合法");
		} else if (statusCode != HttpStatus.SC_OK) {
			throw new RuntimeException("连接失败");
		}

		// 返回响应消息
		byte[] responseBody = method.getResponseBodyAsString().getBytes(method.getResponseCharSet());
		String response = new String(responseBody, "utf-8");
		// 释放连接
		method.releaseConnection();

		return response;
	}

	/**
	 * 解析数量json
	 */
	public void pareseNum(String appIds, String token, List<AppTotalVO> list) throws Exception {
		String totalStr = getData(totalAPI + appIds, token);

		Map<String, String> stringMap = new HashMap<>();
		JSONObject jsonObject = JSON.parseObject(totalStr);
		Set<String> keys = jsonObject.keySet();
		Iterator<String> iterator = keys.iterator();
		while (iterator.hasNext()) {
			String key = (String) iterator.next();
			stringMap.put(key, jsonObject.getString(key));
		}

		for (Map.Entry<String, String> entry : stringMap.entrySet()) {
			AppTotalVO vo = new AppTotalVO();
			vo.setKey(entry.getKey());
			vo.setItem(JsonUtil.fromJson(entry.getValue(), AppTotalItemVO.class));
			list.add(vo);
		}
	}

	// 输出json文件
	public void writeJsonFile(String val) throws Exception {
		// 文件上传路径
		String filePath = rootPath + "/json/";
		File fileDir = new File(filePath);
		if (!fileDir.exists()) {
			fileDir.mkdirs();
		}

		// 写字符转换成字节流
		FileOutputStream fileWriter = new FileOutputStream(filePath + "app_statistic.json");
		OutputStreamWriter writer = new OutputStreamWriter(fileWriter, "UTF-8");
		try {
			writer.write(val);
		} catch (Exception e) {
		} finally {
			writer.close();
		}
	}
}
