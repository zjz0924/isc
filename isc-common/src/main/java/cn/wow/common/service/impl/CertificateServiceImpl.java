package cn.wow.common.service.impl;

import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.dao.CertificateDao;
import cn.wow.common.domain.Certificate;
import cn.wow.common.service.CertificateService;

@Service
@Transactional
public class CertificateServiceImpl implements CertificateService{

    private static Logger logger = LoggerFactory.getLogger(CertificateServiceImpl.class);

    @Autowired
    private CertificateDao certificateDao;

    public Certificate selectOne(Long id){
    	return certificateDao.selectOne(id);
    }

    public int save(String userName, Certificate certificate){
    	return certificateDao.insert(certificate);
    }

    public int update(String userName, Certificate certificate){
    	return certificateDao.update(certificate);
    }

    public int deleteByPrimaryKey(String userName, Certificate certificate){
    	return certificateDao.deleteByPrimaryKey(certificate.getId());
    }

    public List<Certificate> selectAllList(Map<String, Object> map){
    	PageHelperExt.startPage(map);
    	return certificateDao.selectAllList(map);
    }

}
