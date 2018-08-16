package cn.wow.common.service;

import java.util.List;
import java.util.Map;
import cn.wow.common.domain.Menu;

public interface MenuService {

    public List<Menu> getMenuList();
    
    public Menu selectByAlias(String alias);

    public Menu selectOne(Long id);
    
    public int update(String userName, Menu menu);
    
    public List<Menu> selectAllList(Map<String, Object> map);
}
