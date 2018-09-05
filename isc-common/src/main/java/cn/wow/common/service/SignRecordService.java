package cn.wow.common.service;

import java.util.List;
import java.util.Map;
import cn.wow.common.domain.SignRecord;

public interface SignRecordService {
    public SignRecord selectOne(Long id);

    public int save(String userName, SignRecord signRecord);

    public int update(String userName, SignRecord signRecord);

    public int deleteByPrimaryKey(String userName, SignRecord signRecord);

    public List<SignRecord> selectAllList(Map<String, Object> map);
    
    // 统计总额
 	public double statisticTotal(Map<String, Object> map);

}
