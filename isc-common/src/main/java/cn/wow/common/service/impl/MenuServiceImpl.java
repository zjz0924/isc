package cn.wow.common.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.wow.common.dao.MenuDao;
import cn.wow.common.domain.Menu;
import cn.wow.common.service.MenuService;

@Service
@Transactional
public class MenuServiceImpl implements MenuService {

	private static Logger logger = LoggerFactory.getLogger(MenuServiceImpl.class);

	@Autowired
	private MenuDao menuDao;

	public List<Menu> getMenuList() {
		return menuDao.getMenuList();
	}

	public Menu selectByAlias(String alias) {
		return menuDao.selectByAlias(alias);
	}

	public Menu selectOne(Long id) {
		return menuDao.selectOne(id);
	}

	public int update(String userName, Menu menu) {
		return menuDao.update(menu);
	}

	public List<Menu> selectAllList(Map<String, Object> map) {
		return menuDao.selectAllList(map);
	}

}
