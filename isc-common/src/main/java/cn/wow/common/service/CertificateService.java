package cn.wow.common.service;

import java.util.List;
import java.util.Map;
import cn.wow.common.domain.Certificate;

public interface CertificateService {
    public Certificate selectOne(Long id);

    public int save(String userName, Certificate certificate);

    public int update(String userName, Certificate certificate);

    public int deleteByPrimaryKey(String userName, Certificate certificate);

    public List<Certificate> selectAllList(Map<String, Object> map);

}
