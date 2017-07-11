package com.em.interceptor;

import java.util.Map;

import com.em.domain.User;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;

public class UserInterceptor extends MethodFilterInterceptor {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected String doIntercept(ActionInvocation invocation) throws Exception {
		Map<String, Object> session = invocation.getInvocationContext()
				.getSession();
		User user = (User) session.get("user");
		if (user == null) {
			ActionSupport action = (ActionSupport) invocation.getAction();
			action.addActionError(action.getText("user.nologin"));
			return "input";
		}
		String result = invocation.invoke();
		return result;
	}

}
