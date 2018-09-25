package cn.wow.common.vo;

import java.io.Serializable;
import java.util.Comparator;

/**
 * 极光统计- App对象
 * 
 * @author zhen
 *
 */
public class AppTotalVO implements Serializable {

	private static final long serialVersionUID = -5998653643216136229L;

	private String name;

	private String key;

	private AppTotalItemVO item;

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public AppTotalItemVO getItem() {
		return item;
	}

	public void setItem(AppTotalItemVO item) {
		this.item = item;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public static Comparator<AppTotalVO> newAscComparator = new Comparator<AppTotalVO>() {
		public int compare(AppTotalVO vo1, AppTotalVO vo2) {
			return vo1.getItem().getAmountNewToday() - vo2.getItem().getAmountNewToday();
		}
	};

	public static Comparator<AppTotalVO> newDescComparator = new Comparator<AppTotalVO>() {
		public int compare(AppTotalVO vo1, AppTotalVO vo2) {
			return vo2.getItem().getAmountNewToday() - vo1.getItem().getAmountNewToday();
		}
	};

	public static Comparator<AppTotalVO> totalAscComparator = new Comparator<AppTotalVO>() {
		public int compare(AppTotalVO vo1, AppTotalVO vo2) {
			return vo1.getItem().getUserAmount() - vo2.getItem().getUserAmount();
		}
	};

	public static Comparator<AppTotalVO> totalDescComparator = new Comparator<AppTotalVO>() {
		public int compare(AppTotalVO vo1, AppTotalVO vo2) {
			return vo2.getItem().getUserAmount() - vo1.getItem().getUserAmount();
		}
	};
}
