package cn.wow.common.service.impl;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.cookie.CookiePolicy;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import cn.wow.common.service.AppService;
import cn.wow.common.service.SyncDataService;
import cn.wow.common.utils.DateUtils;
import cn.wow.common.utils.JsonUtil;
import cn.wow.common.vo.AppDetailVO;
import cn.wow.common.vo.AppListVO;
import cn.wow.common.vo.AppNumVO;
import cn.wow.common.vo.AppTotalItemVO;
import cn.wow.common.vo.AppVO;

@Service
@Transactional
public class SyncDataServiceImpl implements SyncDataService {

	private static Logger logger = LoggerFactory.getLogger(SyncDataServiceImpl.class);
	
	// 上传根路径
	@Value("${img.root.url}")
	protected String rootPath;
	
	@Value("${jg.api.appNum}")
	private int apiAppNum;

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
		List<String> appNameList = appService.getAppNames();

		// 获取极光的app列表
		long t1 = System.currentTimeMillis();
		String jgAppStr = getData(listAPI, token);
		logger.info("App key Api 花费时间：" + (System.currentTimeMillis() - t1) + " ms");
		
		AppListVO jgAppList = JsonUtil.fromJson(jgAppStr, AppListVO.class);
		List<AppVO> appVOList = jgAppList.getApps();
		
		// 过滤只有签名过的APP
		List<AppVO> exisitAppList = new ArrayList<AppVO>();
		for(AppVO vo: appVOList) {
			if (appNameList.contains(vo.getName())) {
				exisitAppList.add(vo);
			}
		}

		// 每组去获取 极光的列表数据
		List<AppNumVO> totalList = new ArrayList<AppNumVO>();

		int totalNum = exisitAppList == null ? 0 : exisitAppList.size();
		int time = totalNum / apiAppNum;

		if (totalNum % 50 != 0) {
			++time;
		}

		for (int i = 1; i <= time; i++) {

			StringBuffer appIdsBuf = new StringBuffer("");

			int fromIndex = apiAppNum * (i - 1);
			int toIndex = apiAppNum * i;
			if (toIndex > totalNum) {
				toIndex = totalNum;
			}

			List<AppVO> subAppList = exisitAppList.subList(fromIndex, toIndex);
			Map<String, String> appNameMap = new HashMap<String, String>();
			for (AppVO vo : subAppList) {
				appIdsBuf.append(vo.getAppKey() + ",");
				appNameMap.put(vo.getAppKey(), vo.getName());
			}

			String appIds = appIdsBuf.toString();
			if (StringUtils.isNotBlank(appIds)) {
				appIds = appIds.substring(0, appIds.length() - 1);
			}

			// 获取APP数量
			pareseNum(appIds, token, totalList, appNameMap);
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
		client.getParams().setParameter("http.protocol.cookie-policy", CookiePolicy.IGNORE_COOKIES);

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
		InputStream inputStream = method.getResponseBodyAsStream();
		BufferedReader br = new BufferedReader(new InputStreamReader(inputStream, "utf-8"));
		StringBuffer stringBuffer = new StringBuffer();
		String str = "";
		while ((str = br.readLine()) != null) {
			stringBuffer.append(str);
		}

		// 释放连接
		method.releaseConnection();

		return stringBuffer.toString();
	}

	/**
	 * 解析数量json
	 */
	public void pareseNum(String appIds, String token, List<AppNumVO> list, Map<String, String> appNameMap) throws Exception {
		long t1 = System.currentTimeMillis();
		String totalStr = getData(totalAPI + appIds, token);
		logger.info("App数量 Api 花费时间：" + (System.currentTimeMillis() - t1) + " ms");

		ObjectMapper objectMapper = new ObjectMapper();
		JsonNode root = objectMapper.readTree(totalStr);
		Iterator<Entry<String, JsonNode>> elements = root.fields();

		while (elements.hasNext()) {
			Entry<String, JsonNode> node = elements.next();
			String key = node.getKey();
			AppTotalItemVO item = objectMapper.readValue(node.getValue().toString(), AppTotalItemVO.class);

			AppNumVO vo = new AppNumVO();
			vo.setItem(item);
			vo.setAppKey(key);
			vo.setAppName(appNameMap.get(key));

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
