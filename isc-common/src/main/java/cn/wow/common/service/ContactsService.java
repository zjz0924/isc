package cn.wow.common.service;

import java.util.List;
import java.util.Map;
import cn.wow.common.domain.Contacts;

public interface ContactsService {
    public Contacts selectOne(Long id);

    public int save(String userName, Contacts contacts);

    public int update(String userName, Contacts contacts);

    public int deleteByPrimaryKey(String userName, Contacts contacts);

    public List<Contacts> selectAllList(Map<String, Object> map);

}
