package com.em.service;

import java.util.List;

import com.em.domain.User;

public interface UserService {

	User login(User user);

	void save(User user);

	User logonNameCheck(User user);

	List<User> list(User user);

	User findUserById(Integer userId);

	void deleteUserById(Integer userId);

	void edit(User viewUser);

}
