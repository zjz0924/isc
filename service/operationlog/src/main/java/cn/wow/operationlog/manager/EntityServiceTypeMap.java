package cn.wow.operationlog.manager;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import cn.wow.common.domain.Account;
import cn.wow.common.domain.Certificate;
import cn.wow.common.domain.Combo;
import cn.wow.common.domain.Contacts;
import cn.wow.common.domain.Menu;
import cn.wow.common.domain.Pay;
import cn.wow.common.domain.SignRecord;
import cn.wow.common.domain.App;
import cn.wow.common.utils.operationlog.ServiceType;

public final class EntityServiceTypeMap {
	private EntityServiceTypeMap() {
		// not called
	}

	private static Map<String, ServiceType> typeMap = new HashMap<String, ServiceType>();
	// 实体类查询的方法
	private static Map<String, String> daoMap = new HashMap<String, String>();
	
	static {
		initMap();
	}

	static void initMap() {
		typeMap.clear();
		typeMap.put(Account.class.getName(), ServiceType.ACCOUNT);
		typeMap.put(Certificate.class.getName(), ServiceType.CERTIFICATE);
		typeMap.put(App.class.getName(), ServiceType.SIGN);
		typeMap.put(Contacts.class.getName(), ServiceType.CONTACTS);
		typeMap.put(Combo.class.getName(), ServiceType.COMBO);
		typeMap.put(SignRecord.class.getName(), ServiceType.SIGNRECORD);
		typeMap.put(Pay.class.getName(), ServiceType.PAY);
		
		//DAO 类型
		daoMap.clear();
		daoMap.put(Account.class.getName(), "cn.wow.common.dao.AccountDao.selectOne");
		daoMap.put(Certificate.class.getName(), "cn.wow.common.dao.CertificateDao.selectOne");
		daoMap.put(App.class.getName(), "cn.wow.common.dao.AppDao.selectOne");
		daoMap.put(Contacts.class.getName(), "cn.wow.common.dao.ContactsDao.selectOne");
		daoMap.put(Combo.class.getName(), "cn.wow.common.dao.ComboDao.selectOne");
		daoMap.put(SignRecord.class.getName(), "cn.wow.common.dao.SignRecordDao.selectOne");
		daoMap.put(Pay.class.getName(), "cn.wow.common.dao.PayDao.selectOne");
	}

	public static ServiceType getServiceType(Class<?> clazz) {
		if (clazz != null) {
			String className = clazz.getName();
			return getServiceType(className);
		}
		return null;
	}

	public static ServiceType getServiceType(String className) {
		return typeMap.get(className);
	}
	
	public static String getDaoType(Class<?> clazz) {
		if (clazz != null) {
			String className = clazz.getName();
			return daoMap.get(className);
		}
		return null;
	}

	public static boolean contains(ServiceType type) {
		for (ServiceType t : typeMap.values()) {
			if (t.equals(type)) {
				return true;
			}
		}
		return false;
	}

	public static List<String> getAllType() {
		List<String> typeList = new ArrayList<String>();
		for (ServiceType type : ServiceType.values()) {
			typeList.add(type.getDisplayName());
		}
		return typeList;
	}

}
