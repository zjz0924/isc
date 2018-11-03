package cn.wow.common.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import cn.wow.common.dao.AppDao;
import cn.wow.common.dao.ContactsDao;
import cn.wow.common.dao.SignRecordDao;
import cn.wow.common.domain.App;
import cn.wow.common.domain.Combo;
import cn.wow.common.domain.Contacts;
import cn.wow.common.domain.SignRecord;
import cn.wow.common.service.AppService;
import cn.wow.common.service.ContactsService;
import cn.wow.common.service.OperationLogService;
import cn.wow.common.service.SignRecordService;
import cn.wow.common.utils.JsonUtil;
import cn.wow.common.utils.operationlog.OperationType;
import cn.wow.common.utils.operationlog.ServiceType;
import cn.wow.common.utils.operationlog.annotation.OperationLogIgnore;
import cn.wow.common.utils.pagination.PageHelperExt;

@Service
@Transactional
public class AppServiceImpl implements AppService {

	private static Logger logger = LoggerFactory.getLogger(AppServiceImpl.class);

	@Autowired
	private AppDao appDao;

	@Autowired
	private SignRecordService signRecordService;

	@Autowired
	private ContactsService contactsService;

	@Autowired
	private OperationLogService operationLogService;

	@Autowired
	private ContactsDao contactsDao;

	@Value("${app.url}")
	protected String appUrl;

	public App selectOne(Long id) {
		return appDao.selectOne(id);
	}

	public int save(String userName, App sign) {
		return appDao.insert(sign);
	}

	public int update(String userName, App sign, Contacts contacts) {
		if (contacts != null) {
			if (contacts.getId() == null) {
				contactsDao.insert(contacts);
			} else {
				contactsDao.update(contacts);
			}
			sign.setContactsId(contacts.getId());
		}

		return appDao.update(sign);
	}

	public int deleteByPrimaryKey(String userName, App sign) {
		return appDao.deleteByPrimaryKey(sign.getId());
	}

	public List<App> selectAllList(Map<String, Object> map) {
		PageHelperExt.startPage(map);
		return appDao.selectAllList(map);
	}

	@OperationLogIgnore
	public void addApp(String userName, App app, SignRecord signRecord, Contacts contacts) {

		if (contacts != null) {
			Map<String, Object> rMap = new HashMap<String, Object>();
			rMap.put("mwechat", contacts.getWechat());
			List<Contacts> contactsList = contactsService.selectAllList(rMap);

			if (contactsList == null || contactsList.size() < 1) {
				contactsService.save(userName, contacts);
			} else {
				contacts = contactsList.get(0);
			}

			app.setContactsId(contacts.getId());
		}

		// 添加日志
		addLog(userName, app);
		if (app.getId() == null) {
			this.save(userName, app);
		} else {
			this.update(userName, app, null);
		}

		if (signRecord != null) {
			signRecord.setAppId(app.getId());
			signRecordService.save(userName, signRecord);
		}
	}

	public void renewApp(String userName, App app, SignRecord signRecord) {
		this.update(userName, app, null);
		signRecordService.save(userName, signRecord);
	}

	public List<String> getAppNames() {
		return appDao.getAppNames();
	}

	/**
	 * 添加日志
	 */
	void addLog(String userName, App app) {
		Map<String, String> map = new TreeMap<String, String>();
		map.put("ENTITY", JsonUtil.toJson(app));
		map.put("OLDENTITY", null);
		map.put("ENTITYTYPE", "cn.wow.common.domain.App");
		if (app.getId() == null) {
			map.put("OPERATION", "新建");
		} else {
			map.put("OPERATION", "编辑");
		}

		String logDetail = JsonUtil.toJson(map);

		operationLogService.save(userName, app.getId() == null ? OperationType.CREATE : OperationType.UPDATE,
				ServiceType.APP, logDetail);
	}

}
