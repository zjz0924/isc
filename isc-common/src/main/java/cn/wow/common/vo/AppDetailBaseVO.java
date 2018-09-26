package cn.wow.common.vo;

import java.io.Serializable;

public class AppDetailBaseVO implements Serializable {

	private static final long serialVersionUID = 4282572807645649574L;
	
	private int activeuser;
	private int amountuser;
	private int reguser;

	public int getActiveuser() {
		return activeuser;
	}

	public void setActiveuser(int activeuser) {
		this.activeuser = activeuser;
	}

	public int getAmountuser() {
		return amountuser;
	}

	public void setAmountuser(int amountuser) {
		this.amountuser = amountuser;
	}

	public int getReguser() {
		return reguser;
	}

	public void setReguser(int reguser) {
		this.reguser = reguser;
	}

}
