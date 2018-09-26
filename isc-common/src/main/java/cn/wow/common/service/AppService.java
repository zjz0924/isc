package cn.wow.common.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import cn.wow.common.domain.App;
import cn.wow.common.domain.Combo;
import cn.wow.common.domain.Contacts;
import cn.wow.common.domain.SignRecord;

public interface AppService {
    public App selectOne(Long id);

    public int save(String userName, App sign);

    public int update(String userName, App sign);

    public int deleteByPrimaryKey(String userName, App sign);

    public List<App> selectAllList(Map<String, Object> map);

    public void addApp(String userName, App app, SignRecord signRecord, Contacts contacts, MultipartFile signFile, MultipartFile unsignFile);
    
    /**
     * 续费
     */
    public void renewApp(String userName, App app, SignRecord signRecord);
    
    
    public List<String> getAppNames();
}
