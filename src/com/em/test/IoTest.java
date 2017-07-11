package com.em.test;

import java.io.FileOutputStream;

import org.junit.Test;

public class IoTest {
	@Test
	public void test1() throws Exception {
		FileOutputStream fos = new FileOutputStream("D:/tttttt/sss.txt");
		fos.write("sydfsadf".getBytes());
		fos.close();
		String a = "s";

	}
}
