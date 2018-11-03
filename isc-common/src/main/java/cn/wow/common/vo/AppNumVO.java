package cn.wow.common.vo;

import java.io.Serializable;
import java.util.Comparator;

/**
 * 极光统计- App对象
 * 
 * @author zhen
 *
 */
public class AppNumVO implements Serializable {

	private static final long serialVersionUID = 8028673279672261693L;

	private String appName;

	private String appKey;

	private AppTotalItemVO item;

	// 证书名
	private String certName;
	
	private Long certId;

	public AppTotalItemVO getItem() {
		return item;
	}

	public void setItem(AppTotalItemVO item) {
		this.item = item;
	}

	public String getAppName() {
		return appName;
	}

	public void setAppName(String appName) {
		this.appName = appName;
	}

	public String getAppKey() {
		return appKey;
	}

	public void setAppKey(String appKey) {
		this.appKey = appKey;
	}

	public String getCertName() {
		return certName;
	}

	public void setCertName(String certName) {
		this.certName = certName;
	}

	public Long getCertId() {
		return certId;
	}

	public void setCertId(Long certId) {
		this.certId = certId;
	}



	public static Comparator<AppNumVO> newAscComparator = new Comparator<AppNumVO>() {
		public int compare(AppNumVO vo1, AppNumVO vo2) {
			return vo1.getItem().getAmountNewToday() - vo2.getItem().getAmountNewToday();
		}
	};

	public static Comparator<AppNumVO> newDescComparator = new Comparator<AppNumVO>() {
		public int compare(AppNumVO vo1, AppNumVO vo2) {
			return vo2.getItem().getAmountNewToday() - vo1.getItem().getAmountNewToday();
		}
	};

	public static Comparator<AppNumVO> totalAscComparator = new Comparator<AppNumVO>() {
		public int compare(AppNumVO vo1, AppNumVO vo2) {
			return vo1.getItem().getUserAmount() - vo2.getItem().getUserAmount();
		}
	};

	public static Comparator<AppNumVO> totalDescComparator = new Comparator<AppNumVO>() {
		public int compare(AppNumVO vo1, AppNumVO vo2) {
			return vo2.getItem().getUserAmount() - vo1.getItem().getUserAmount();
		}
	};
}
