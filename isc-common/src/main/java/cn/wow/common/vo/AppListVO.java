package cn.wow.common.vo;

import java.io.Serializable;
import java.util.List;

/**
 * 极光统计 app列表
 */
public class AppListVO implements Serializable{

	private static final long serialVersionUID = 7579817494153125680L;
	
	private int total;
	
	private List<AppVO> apps;

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public List<AppVO> getApps() {
		return apps;
	}

	public void setApps(List<AppVO> apps) {
		this.apps = apps;
	}
}
