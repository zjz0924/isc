package cn.wow.common.service;

import java.util.List;
import java.util.Map;
import cn.wow.common.domain.Pay;

public interface PayService {
    public Pay selectOne(Long id);

    public int save(String userName, Pay pay);

    public int update(String userName, Pay pay);

    public int deleteByPrimaryKey(String userName, Pay pay);

    public List<Pay> selectAllList(Map<String, Object> map);

}
