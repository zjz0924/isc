package cn.wow.common.vo;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * 极光统计 - app统计数目
 * 
 * @author zhen
 *
 */
public class AppTotalItemVO implements Serializable {

	private static final long serialVersionUID = 5992677469207997754L;

	@JsonProperty("USER_AMOUNT")
	private int userAmount;

	@JsonProperty("AMOUNT_ONLINE_TODAY")
	private int amountOnlineToday;

	@JsonProperty("AMOUNT_NEW_TODAY")
	private int amountNewToday;

	public int getUserAmount() {
		return userAmount;
	}

	public void setUserAmount(int userAmount) {
		this.userAmount = userAmount;
	}

	public int getAmountOnlineToday() {
		return amountOnlineToday;
	}

	public void setAmountOnlineToday(int amountOnlineToday) {
		this.amountOnlineToday = amountOnlineToday;
	}

	public int getAmountNewToday() {
		return amountNewToday;
	}

	public void setAmountNewToday(int amountNewToday) {
		this.amountNewToday = amountNewToday;
	}

}
