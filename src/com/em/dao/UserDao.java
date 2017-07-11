package com.em.dao;

import java.util.List;

import com.em.domain.User;

public interface UserDao {

	User login(User user);

	void save(User user);

	User logonNameCheck(User user);

	List<User> list(User user);

	User findUserById(Integer userId);

	void deleteUserById(Integer userId);

	void edit(User viewUser);

}
