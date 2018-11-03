package cn.wow.common.vo;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import cn.wow.common.domain.Certificate;

/**
 * 极光统计 app
 *
 */

@JsonIgnoreProperties({ "permissions", "appRate", "appleVerifyErrcode", "appleVerifyTestErrcode", "bundleId",
		"certificateData", "certificateDataTest", "certificateFileName", "certificatePassword",
		"certificatePasswordTest", "fileIcon", "icon", "iosKey", "isTop", "lastUpdateTime", "pkg", "platform",
		"proVerifyCode", "reportsData", "richpushPmsnState", "stage", "supportWp", "testVerifyCode" })
public class AppVO implements Serializable {

	private static final long serialVersionUID = 5940838753896218484L;

	private String apiMasterSecret = null;
	private int appId;
	private String appKey;
	private String createTime;
	private int devId;
	private String name;
	private Certificate cert;

	public String getApiMasterSecret() {
		return apiMasterSecret;
	}

	public void setApiMasterSecret(String apiMasterSecret) {
		this.apiMasterSecret = apiMasterSecret;
	}

	public int getAppId() {
		return appId;
	}

	public void setAppId(int appId) {
		this.appId = appId;
	}

	public String getAppKey() {
		return appKey;
	}

	public void setAppKey(String appKey) {
		this.appKey = appKey;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public int getDevId() {
		return devId;
	}

	public void setDevId(int devId) {
		this.devId = devId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Certificate getCert() {
		return cert;
	}

	public void setCert(Certificate cert) {
		this.cert = cert;
	}

}
