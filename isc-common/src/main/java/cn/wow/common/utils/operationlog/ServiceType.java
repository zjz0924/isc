package cn.wow.common.utils.operationlog;

import java.io.Serializable;

/**
 * 
 * An enum for the different ServiceType types that exists in the MSA
 * application.
 * 
 * @author MIEP/Ericsson
 *
 */
public enum ServiceType implements Serializable {
	ACCOUNT("用户管理"),
	APP("APP管理"),
	CERTIFICATE("证书管理"),
	SIGN("签名管理"),
	COMBO("套餐管理"),
	SIGNRECORD("签名记录"),
	CONTACTS("客户管理");

	private String displayName;

	ServiceType(String displayName) {
		this.displayName = displayName;
	}

	public String getDisplayName() {
		return displayName;
	}

	public static ServiceType valueOfString(String type) {
		ServiceType st = null;
		for (ServiceType t : ServiceType.values()) {
			if (t.name().equalsIgnoreCase(type)) {
				st = t;
				break;
			}
		}
		return st;
	}

}
