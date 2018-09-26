package cn.wow.common.vo;

import java.io.Serializable;

/**
 * 数量统计
 * @author zhen
 * 2018-08-28
 */
public class NumItem implements Serializable{

	private static final long serialVersionUID = -3085751210633033959L;
	
	// 名称
	private String name;
	// 新增数量
	private Integer add;
	// 续费数量
	private Integer renew;
	// 新增总金额
	private Double addSum;
	// 续费总金额
	private Double renewSum;
	// 补签数量
	private Integer sumplement;
	// 补签金额
	private Double sumplementSum;
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public Integer getAdd() {
		return add;
	}
	
	public void setAdd(Integer add) {
		this.add = add;
	}
	
	public Integer getRenew() {
		return renew;
	}
	
	public void setRenew(Integer renew) {
		this.renew = renew;
	}

	public Double getAddSum() {
		return addSum;
	}

	public void setAddSum(Double addSum) {
		this.addSum = addSum;
	}

	public Double getRenewSum() {
		return renewSum;
	}

	public void setRenewSum(Double renewSum) {
		this.renewSum = renewSum;
	}

	public Integer getSumplement() {
		return sumplement;
	}

	public void setSumplement(Integer sumplement) {
		this.sumplement = sumplement;
	}

	public Double getSumplementSum() {
		return sumplementSum;
	}

	public void setSumplementSum(Double sumplementSum) {
		this.sumplementSum = sumplementSum;
	}
	
}
