package cn.wow.common.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.wow.common.dao.PayDao;
import cn.wow.common.domain.Pay;
import cn.wow.common.service.PayService;
import cn.wow.common.utils.pagination.PageHelperExt;

@Service
@Transactional
public class PayServiceImpl implements PayService {

	private static Logger logger = LoggerFactory.getLogger(PayServiceImpl.class);

	@Autowired
	private PayDao payDao;

	public Pay selectOne(Long id) {
		return payDao.selectOne(id);
	}

	public int save(String userName, Pay pay) {
		return payDao.insert(pay);
	}

	public int update(String userName, Pay pay) {
		return payDao.update(pay);
	}

	public int deleteByPrimaryKey(String userName, Pay pay) {
		return payDao.deleteByPrimaryKey(pay.getId());
	}

	public List<Pay> selectAllList(Map<String, Object> map) {
		PageHelperExt.startPage(map);
		return payDao.selectAllList(map);
	}

	// 统计总额
	public double statisticTotal(Map<String, Object> map) {
		return payDao.statisticTotal(map);
	}
}
