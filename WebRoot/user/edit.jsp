<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<HTML>
	<HEAD>
		<meta http-equiv="Content-Language" content="zh-cn">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<LINK href="${pageContext.request.contextPath}/css/Style.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="${pageContext.request.contextPath}/js/public.js"></script>
		<script language="javascript" src="${pageContext.request.contextPath}/js/check.js"></script>
		<!-- 日期插件，使用jquery -->
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui-1.10.3.custom.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.ui.datepicker-zh-CN.js"></script>
		<LINK href="${pageContext.request.contextPath}/css/jquery-ui-1.10.3.custom.min.css" type="text/css" rel="stylesheet">
	</HEAD>
	<script type="text/javascript">
		$(document).ready(function(){
			//使用class属性处理  'yy-mm-dd' 设置格式"yyyy/mm/dd"
			$("#birthday").datepicker({changeYear: true ,dateFormat: "yy-mm-dd"});
			$("#logonName").on("blur",function(){
				if (!$(this).val()) {
					return;
				}
				$.ajax({
					url:"{pageContext.request.contextPath}/user_logonNameCheck",
					data:{logonName: $(this).val(), userId: $("#userId").val()},
					type:"post",
					dataType:"json",
					success:function(result){
						if (result == "ok") {
							$("#logonName_span")
							.css("color","green")
							.text("可以使用");
							$("#submit").removeAttr("disabled");
						}else if(result == "repeated"){
							$("#logonName_span")
							.css("color","red")
							.text("被占用");
							$("#submit").attr("disabled","disabled");
						}
					}
				});
			});
		});
	</script>
	<body>
		<s:form id="userAction_save_do" name="Form1" action="user_editSubmit" namespace="/" method="post" enctype="multipart/form-data">
			&nbsp;
			<table cellSpacing="1" cellPadding="5" width="100%" align="center" bgColor="#eeeeee" style="border: 1px solid #8ba7e3" border="0">
				<tr>
					<td class="ta_01" align="center" bgColor="#afd1f3" colSpan="4"
						height="26">
						<strong><STRONG>编辑用户</STRONG>
						</strong>
					</td>
				</tr>

				<tr>
					<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
						登录名：
					</td>
					<td class="ta_01" bgColor="#ffffff" colspan="3">
						<s:textfield name="viewUser.logonName" id="logonName" class="bg"></s:textfield>
						<span id="logonName_span"></span>
						<s:hidden id="userId" name="viewUser.userId"></s:hidden>
					</td>
				</tr>
				<tr>
					<td align="center" bgColor="#f5fafe" class="ta_01">
						 密码：
					</td>
					<td class="ta_01" bgColor="#ffffff">
						<s:password name="viewUser.password"></s:password>
					</td>
					<td align="center" bgColor="#f5fafe" class="ta_01">
						用户姓名：
					</td>
					<td class="ta_01" bgColor="#ffffff">
						<s:textfield name="viewUser.userName" class="bg"></s:textfield>
					</td>
				</tr>
				<tr>
					<td align="center" bgColor="#f5fafe" class="ta_01">
						性别：
					</td>
					<td class="ta_01" bgColor="#ffffff">
						<s:radio list="{'男','女'}" name="viewUser.sex"></s:radio>
					</td>
					<td align="center" bgColor="#f5fafe" class="ta_01">
						学历：
					</td>
					<td class="ta_01" bgColor="#ffffff">
						<s:select list="{'博士','硕士','本科','专科','高中'}" name="viewUser.education" headerKey="" headerValue="--选择学历--"></s:select>
					</td>
				</tr>
				<tr>
					<td align="center" bgColor="#f5fafe" class="ta_01">
						出生日期：
					</td>
					<td class="ta_01" bgColor="#ffffff">
						<s:textfield name="viewUser.birthday" size="20" id="birthday" readonly="readonly"></s:textfield>
					</td>
					<td align="center" bgColor="#f5fafe" class="ta_01">
						电话：
					</td>
					<td class="ta_01" bgColor="#ffffff">
						<s:textfield name="viewUser.telephone" id="telephone"></s:textfield>
					</td>
				</tr>
				<tr>
					<td align="center" bgColor="#f5fafe" class="ta_01">
						兴趣爱好：
					</td>
					<td class="ta_01" bgColor="#ffffff" colSpan="3">
						<s:checkboxlist list="{'看电影','旅游','健身','购物','睡觉'}" value="%{viewUser.interest.split(', ')}" name="viewUser.interest" ccsClass="checkboxLabel"></s:checkboxlist>
					</td>
				</tr>
				<tr>
					<td align="center" bgColor="#f5fafe" class="ta_01">
						简历资料：
					</td>
					<td class="ta_01" bgColor="#ffffff" colSpan="3">
						<s:file name="upload" size="30"></s:file>
					</td>
				</tr>
				<TR>
					<TD class="ta_01" align="center" bgColor="#f5fafe">
						备注：
					</TD>
					<TD class="ta_01" bgColor="#ffffff" colSpan="3">
						<s:textarea name="viewUser.remark" cols="30" rows="3" id="userAction_save_do_remark" cssStyle="WIDTH: 96%"></s:textarea>
					</TD>
				</TR>
				<TR>
					<td align="center" colSpan="4" class="sep1">
						<img src="${pageContext.request.contextPath}/images/shim.gif">
					</td>
				</TR>
				<tr>
					<td class="ta_01" style="WIDTH: 100%" align="center"
						bgColor="#f5fafe" colSpan="4">
						<s:submit id="submit" value="确定" cssClass="button_ok"></s:submit>
						<FONT face="宋体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT>
						<s:reset value="重置" cssClass="button_cancel"></s:reset>
						<FONT face="宋体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT>
						<INPUT class="button_ok" type="button" onclick="history.go(-1)" value="返回"/>
						<span id="Label1"></span>
					</td>
				</tr>
			</table>
		<!-- </form> -->
		</s:form>




	</body>
</HTML>