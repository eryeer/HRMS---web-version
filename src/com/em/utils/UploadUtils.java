package com.em.utils;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.UUID;

public class UploadUtils {
	/**
	 * 截取真实文件名
	 * 
	 * @param fileName
	 * @return
	 */
	public static String subFileName(String fileName) {

		// 查找最后一个 \出现位置,没有找到就返回-1 ,截取从0开始
		return fileName.substring(fileName.lastIndexOf(File.separator) + 1);
	}

	/**
	 * 获得随机UUID文件名
	 * 
	 * @param fileName
	 * @return
	 */
	public static String generateRandomFileName(String fileName) {
		// 获得扩展名
		String ext = fileName.substring(fileName.lastIndexOf("."));
		return UUID.randomUUID().toString().replace("-", "") + ext;
	}

	/**
	 * 获得hashcode生成二级目录
	 * 
	 * @param uuidFileName
	 * @return
	 */
	public static String generateRandomDir(String uuidFileName) {
		int hashCode = uuidFileName.hashCode();
		// 一级目录
		int d1 = hashCode & 0xf;
		// 二级目录
		int d2 = (hashCode >> 4) & 0xf;
		return "/" + d1 + "/" + d2;
	}

	/**
	 * 生成多级随机目录
	 * 
	 * @param level
	 *            生成文件夹的层级（深度）
	 * @param dirsCount
	 *            每个文件夹中最多有多少个文件夹
	 * @return
	 */
	public static String randomDirs(int level, int dirsCount) {
		Random r = new Random();
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < level; i++) {
			sb.append("/" + r.nextInt(dirsCount));
		}
		// System.out.println(sb.toString());
		return sb.toString();
	}

	/**
	 * 根据当日日期生成文件目录
	 * 
	 * @return
	 */
	public static String generateDateDirs() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return "/" + sdf.format(new Date());
	}

}
