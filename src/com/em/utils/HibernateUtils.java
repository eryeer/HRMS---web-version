package com.em.utils;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtils {
	public static final Configuration CONFIG;
	public static final SessionFactory FACTORY;
	public static final Logger logger = Logger.getLogger(HibernateUtils.class);
	static {
		CONFIG = new Configuration().configure();
		FACTORY = CONFIG.buildSessionFactory();
		/*
		 * Runtime.getRuntime().addShutdownHook(new Thread(new Runnable() {
		 * 
		 * @Override public void run() { logger.info("虚拟机关闭,释放工厂资源");
		 * FACTORY.close(); } }));
		 */

	}

	public static Session openSession() {
		return FACTORY.openSession();
	}

	public static Session getCurrentSession() {
		return FACTORY.getCurrentSession();
	}

}
