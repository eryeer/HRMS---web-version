package com.em.dao.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

import com.em.dao.UserDao;
import com.em.domain.User;
import com.em.utils.HibernateUtils;

public class UserDaoImpl implements UserDao {

	@Override
	public User login(User user) {
		Session session = HibernateUtils.getCurrentSession();
		Transaction tr = session.beginTransaction();
		Query query = session
				.createQuery("from User where logonName = ? and logonPwd = ?");
		query.setString(0, user.getLogonName());
		query.setString(1, user.getLogonPwd());
		user = (User) query.uniqueResult();
		tr.commit();
		return user;
	}

	@Override
	public void save(User user) {
		Session session = HibernateUtils.getCurrentSession();
		Transaction tr = session.beginTransaction();
		session.save(user);
		tr.commit();
	}

	@Override
	public User logonNameCheck(User user) {
		Session session = HibernateUtils.getCurrentSession();
		Transaction tr = session.beginTransaction();
		Criteria criteria = session.createCriteria(User.class);
		criteria.add(Restrictions.eq("logonName", user.getLogonName()));
		if (user.getUserId() != null) {
			criteria.add(Restrictions.not(Restrictions.eq("userId",
					user.getUserId())));
		}
		user = (User) criteria.uniqueResult();
		tr.commit();
		return user;
	}

	@Override
	public List<User> list(User user) {
		Session session = HibernateUtils.getCurrentSession();
		Transaction tr = session.beginTransaction();
		Criteria criteria = session.createCriteria(User.class);
		if (StringUtils.isNotBlank(user.getUserName())) {
			criteria.add(Restrictions.eq("userName", user.getUserName()));
		}
		if (StringUtils.isNotBlank(user.getSex())) {
			criteria.add(Restrictions.eq("sex", user.getSex()));
		}
		if (StringUtils.isNotBlank(user.getEducation())) {
			criteria.add(Restrictions.eq("education", user.getEducation()));
		}
		if (StringUtils.isNotBlank(user.getIsUpload())) {
			if ("1".equals(user.getIsUpload())) {
				criteria.add(Restrictions.isNotNull("filename"));
			} else {
				criteria.add(Restrictions.isNull("filename"));
			}
		}
		List<User> list = criteria.list();
		tr.commit();
		return list;
	}

	@Override
	public User findUserById(Integer userId) {
		Session session = HibernateUtils.getCurrentSession();
		Transaction tr = session.beginTransaction();
		Query query = session.createQuery("from User where userId = ?");
		query.setInteger(0, userId);
		User user = (User) query.uniqueResult();
		tr.commit();
		return user;
	}

	@Override
	public void deleteUserById(Integer userId) {
		Session session = HibernateUtils.getCurrentSession();
		Transaction tr = session.beginTransaction();
		User user = new User();
		user.setUserId(userId);
		session.delete(user);
		tr.commit();
	}

	@Override
	public void edit(User viewUser) {
		Session session = HibernateUtils.getCurrentSession();
		Transaction tr = session.beginTransaction();
		session.update(viewUser);
		tr.commit();

	}
}
