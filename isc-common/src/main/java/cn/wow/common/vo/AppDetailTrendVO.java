package cn.wow.common.vo;

import java.io.Serializable;

public class AppDetailTrendVO implements Serializable {

	private static final long serialVersionUID = 7340958824908587741L;

	private String date;
	
	private int activeUser;
	
	private int newUser;

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public int getActiveUser() {
		return activeUser;
	}

	public void setActiveUser(int activeUser) {
		this.activeUser = activeUser;
	}

	public int getNewUser() {
		return newUser;
	}

	public void setNewUser(int newUser) {
		this.newUser = newUser;
	}
}
