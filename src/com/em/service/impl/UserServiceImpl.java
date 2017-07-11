package com.em.service.impl;

import java.util.List;

import com.em.dao.UserDao;
import com.em.dao.impl.UserDaoImpl;
import com.em.domain.User;
import com.em.service.UserService;

public class UserServiceImpl implements UserService {
	UserDao dao = new UserDaoImpl();

	@Override
	public User login(User user) {

		return dao.login(user);
	}

	@Override
	public void save(User user) {
		dao.save(user);
	}

	@Override
	public User logonNameCheck(User user) {
		user = dao.logonNameCheck(user);
		return user;
	}

	@Override
	public List<User> list(User user) {

		return dao.list(user);
	}

	@Override
	public User findUserById(Integer userId) {

		return dao.findUserById(userId);
	}

	@Override
	public void deleteUserById(Integer userId) {
		dao.deleteUserById(userId);
	}

	@Override
	public void edit(User viewUser) {
		dao.edit(viewUser);
	}

}
