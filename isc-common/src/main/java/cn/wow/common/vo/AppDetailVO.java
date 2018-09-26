package cn.wow.common.vo;

import java.io.Serializable;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties({ "events" })
public class AppDetailVO implements Serializable {

	private static final long serialVersionUID = 2170385427879196278L;

	private AppDetailBaseVO base;

	private List<AppDetailTrendVO> trend;

	public AppDetailBaseVO getBase() {
		return base;
	}

	public void setBase(AppDetailBaseVO base) {
		this.base = base;
	}

	public List<AppDetailTrendVO> getTrend() {
		return trend;
	}

	public void setTrend(List<AppDetailTrendVO> trend) {
		this.trend = trend;
	}

}
