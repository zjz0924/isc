package cn.wow.common.service.impl;

import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.dao.SignRecordDao;
import cn.wow.common.domain.SignRecord;
import cn.wow.common.service.SignRecordService;

@Service
@Transactional
public class SignRecordServiceImpl implements SignRecordService {

	private static Logger logger = LoggerFactory.getLogger(SignRecordServiceImpl.class);

	@Autowired
	private SignRecordDao signRecordDao;

	public SignRecord selectOne(Long id) {
		return signRecordDao.selectOne(id);
	}

	public int save(String userName, SignRecord signRecord) {
		return signRecordDao.insert(signRecord);
	}

	public int update(String userName, SignRecord signRecord) {
		return signRecordDao.update(signRecord);
	}

	public int deleteByPrimaryKey(String userName, SignRecord signRecord) {
		return signRecordDao.deleteByPrimaryKey(signRecord.getId());
	}

	public List<SignRecord> selectAllList(Map<String, Object> map) {
		PageHelperExt.startPage(map);
		return signRecordDao.selectAllList(map);
	}

	// 统计总额
	public double statisticTotal(Map<String, Object> map) {
		return signRecordDao.statisticTotal(map);
	}

}
