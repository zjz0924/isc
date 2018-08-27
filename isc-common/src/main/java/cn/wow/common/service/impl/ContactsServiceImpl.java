package cn.wow.common.service.impl;

import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.wow.common.utils.pagination.PageHelperExt;
import cn.wow.common.dao.ContactsDao;
import cn.wow.common.domain.Contacts;
import cn.wow.common.service.ContactsService;

@Service
@Transactional
public class ContactsServiceImpl implements ContactsService{

    private static Logger logger = LoggerFactory.getLogger(ContactsServiceImpl.class);

    @Autowired
    private ContactsDao contactsDao;

    public Contacts selectOne(Long id){
    	return contactsDao.selectOne(id);
    }

    public int save(String userName, Contacts contacts){
    	return contactsDao.insert(contacts);
    }

    public int update(String userName, Contacts contacts){
    	return contactsDao.update(contacts);
    }

    public int deleteByPrimaryKey(String userName, Contacts contacts){
    	return contactsDao.deleteByPrimaryKey(contacts.getId());
    }

    public List<Contacts> selectAllList(Map<String, Object> map){
    	PageHelperExt.startPage(map);
    	return contactsDao.selectAllList(map);
    }

}
