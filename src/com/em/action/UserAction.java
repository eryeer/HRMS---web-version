package com.em.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;

import com.em.domain.User;
import com.em.service.UserService;
import com.em.service.impl.UserServiceImpl;
import com.em.utils.DownLoadUtils;
import com.em.utils.UploadUtils;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.interceptor.annotations.InputConfig;
import com.opensymphony.xwork2.util.ValueStack;

public class UserAction extends ActionSupport implements ModelDriven<User> {

	private static final long serialVersionUID = 1L;
	private User user = new User();
	private UserService service = new UserServiceImpl();
	private File upload;
	private String uploadContenType;
	private String uploadFileName;
	private String result;
	private User viewUser;

	private InputStream inputStream;
	private String contentType;
	private String downloadFilename;

	public String login() {

		// 测试令牌运行
		// try {
		// Thread.sleep(1000);
		// } catch (InterruptedException e) {
		// e.printStackTrace();
		// }
		User user2 = service.login(user);
		// System.out.println("虽然令牌起作用,但是程序还是运行了");

		if (user2 != null) {
			ActionContext.getContext().getSession().put("user", user2);
			return "loginSuccess";
		} else {
			this.addActionError(this.getText("user.loginfail"));
			return INPUT;
		}
	}

	@InputConfig(resultName = "saveInput")
	public String save() throws IOException {
		if (upload != null) {
			String randomName = UploadUtils
					.generateRandomFileName(uploadFileName);
			String randomPath = UploadUtils.generateRandomDir(randomName);
			String path = "D:/upload" + randomPath;
			FileUtils.copyFile(upload, new File(path, randomName));
			user.setPath(randomPath + "/" + randomName);
			user.setFilename(uploadFileName);
		}
		service.save(user);
		return "success";
	}

	public String logonNameCheck() {
		User user2 = service.logonNameCheck(user);
		if (user2 != null) {
			result = "repeated";
		} else {
			result = "ok";
		}
		return "checkSuccess";
	}

	public String list() {
		List<User> ulist = service.list(user);
		ValueStack valueStack = ActionContext.getContext().getValueStack();
		valueStack.set("ulist", ulist);
		return "listSuccess";
	}

	public String view() {
		viewUser = service.findUserById(user.getUserId());
		return "viewSuccess";
	}

	public String download() {
		viewUser = service.findUserById(user.getUserId());
		String path = viewUser.getPath();
		String absolutePath = "D:/upload" + path;
		try {
			inputStream = new FileInputStream(new File(absolutePath));
			contentType = ServletActionContext.getServletContext().getMimeType(
					path);
			String browserType = ServletActionContext.getRequest().getHeader(
					"user-agent");
			downloadFilename = DownLoadUtils.getAttachmentFileName(
					viewUser.getFilename(), browserType);
		} catch (Exception e) {

			e.printStackTrace();
		}
		return "downloadSuccess";
	}

	public String delete() {
		viewUser = service.findUserById(user.getUserId());
		if (!StringUtils.isBlank(viewUser.getPath())) {
			String absolutePath = "D:/upload" + viewUser.getPath();
			new File(absolutePath).delete();
		}
		service.deleteUserById(user.getUserId());
		return "success";
	}

	public String edit() {
		viewUser = service.findUserById(user.getUserId());
		return "editSuccess";
	}

	public String editSubmit() throws IOException {
		User formalUser = service.findUserById(viewUser.getUserId());
		if (StringUtils.isBlank(viewUser.getLogonPwd())) {
			viewUser.setLogonPwd(formalUser.getLogonPwd());
		}
		if (formalUser.getPath() != null && upload == null) {
			viewUser.setPath(formalUser.getPath());
			viewUser.setFilename(formalUser.getFilename());
		}

		if (upload != null) {
			if (formalUser.getPath() != null) {
				new File("D:/upload" + formalUser.getPath()).delete();
			}
			String randomName = UploadUtils
					.generateRandomFileName(uploadFileName);
			String randomPath = UploadUtils.generateRandomDir(randomName);
			String path = "D:/upload" + randomPath;
			FileUtils.copyFile(upload, new File(path, randomName));
			viewUser.setPath(randomPath + "/" + randomName);
			viewUser.setFilename(uploadFileName);
		}
		service.edit(viewUser);

		return "success";
	}

	public String getResult() {
		return result;
	}

	@Override
	public User getModel() {

		return user;
	}

	public void setUpload(File upload) {
		this.upload = upload;
	}

	public void setUploadContenType(String uploadContenType) {
		this.uploadContenType = uploadContenType;
	}

	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}

	public User getViewUser() {
		return viewUser;
	}

	public void setViewUser(User viewUser) {
		this.viewUser = viewUser;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public String getContentType() {
		return contentType;
	}

	public String getDownloadFilename() {
		return downloadFilename;
	}

}
