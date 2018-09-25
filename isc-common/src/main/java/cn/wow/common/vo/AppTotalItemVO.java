package cn.wow.common.vo;

import java.io.Serializable;
import org.codehaus.jackson.annotate.JsonMethod;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.codehaus.jackson.annotate.JsonAutoDetect;

/**
 * 极光统计 - app统计数目
 * 
 * @author zhen
 *
 */

@JsonAutoDetect(JsonMethod.FIELD)
public class AppTotalItemVO implements Serializable {

	private static final long serialVersionUID = 1L;

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
