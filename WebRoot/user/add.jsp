<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<HTML>
	<HEAD>
		<meta http-equiv="Content-Language" content="zh-cn">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<LINK href="${pageContext.request.contextPath}/css/Style.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="${pageContext.request.contextPath}/js/public.js"></script>
		<script language="javascript" src="${pageContext.request.contextPath}/js/check.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui-1.10.3.custom.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.ui.datepicker-zh-CN.js"></script>
		<LINK href="${pageContext.request.contextPath}/css/jquery-ui-1.10.3.custom.min.css" type="text/css" rel="stylesheet">
		<script type="text/javascript">
			jQuery(function($){
				$("#birthday").datepicker({changeYear: true ,dateFormat: "yy-mm-dd"});
				$("#logonName").on("blur",function(){
					if (!$(this).val()) {
						return;
					}
					$.ajax({
						url:"{pageContext.request.contextPath}/user_logonNameCheck",
						data:"logonName="+$(this).val(),
						type:"post",
						dataType:"json",
						success:function(result){
							if (result == "ok") {
								$("#logonName_span")
								.css("color","green")
								.text("可以注册");
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
	</HEAD>
	<body>
		<%-- <form id="userAction_save_do" name="Form1" action="${pageContext.request.contextPath}/user/list.jsp" method="post" enctype="multipart/form-data"> --%>
			<s:form id="userAction_save_do" action="user_save" namespace="/" method="post" enctype="multipart/form-data">
			&nbsp;
			<table cellSpacing="1" cellPadding="5" width="100%" align="center" bgColor="#eeeeee" style="border: 1px solid #8ba7e3" border="0">
				<tr>
					<td class="ta_01" align="center" bgColor="#afd1f3" colSpan="4"
						height="26">
						<strong><STRONG>添加用户</STRONG>
						</strong>
						<s:fielderror></s:fielderror>
						<s:actionerror/>
					</td>
				</tr>

				<tr>
					<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
						登录名：
					</td>
					<td class="ta_01" bgColor="#ffffff" colspan="3">
						<!-- <input type="text" name="logonName" value="" id="userAction_save_do_logonName" class="bg"/> -->
						<s:textfield name="logonName" id="logonName" cssClass="bg"></s:textfield><span id="logonName_span"></span>
					</td>
				</tr>
				<tr>
					<td align="center" bgColor="#f5fafe" class="ta_01">
						 密码：
					</td>
					<td class="ta_01" bgColor="#ffffff">
						<!-- <input type="password" name="logonPwd" value="" id="logonPwd"/> -->
						<s:password name="logonPwd" id="logonPwd"></s:password>
					</td>
					<td align="center" bgColor="#f5fafe" class="ta_01">
						用户姓名：
					</td>
					<td class="ta_01" bgColor="#ffffff">
						<!-- <input type="text" name="userName" value="" id="userAction_save_do_userName" class="bg"/> -->
						<s:textfield name="userName" id="userAction_save_do_userName" cssClass="bg"></s:textfield>
					</td>
				</tr>
				<tr>
					<td align="center" bgColor="#f5fafe" class="ta_01">
						性别：
					</td>
					<td class="ta_01" bgColor="#ffffff">
						<!-- <input type="radio" name="sex" id="sex男" value="男"/><label for="sex男">男</label>
						<input type="radio" name="sex" id="sex女" value="女"/><label for="sex女">女</label> -->
						<s:radio list="{'男','女'}" name="sex" value="'男'"></s:radio>

					</td>
					<td align="center" bgColor="#f5fafe" class="ta_01">
						学历：
					</td>
					<td class="ta_01" bgColor="#ffffff">
						
						<!-- <select name="education" id="education">
						    <option value=""
						    selected="selected"
						    >--选择学历--</option>
						    <option value="博士">博士</option>
						    <option value="硕士">硕士</option>
						    <option value="研究生">研究生</option>
						    <option value="本科">本科</option>
						    <option value="专科">专科</option>
						    <option value="高中">高中</option>
						</select> -->
						<s:select list="{'博士','硕士','本科','专科','高中'}" name="education" id="education" headerKey="" headerValue="--选择学历--"></s:select>
						

					</td>
				</tr>
				<tr>
					<td align="center" bgColor="#f5fafe" class="ta_01">
						出生日期：
					</td>
					<td class="ta_01" bgColor="#ffffff">
						<!-- <input type="text" name="birthday" size="20" value="" readonly="readonly" id="birthday"/> -->
						<s:textfield name="birthday" size="20" id="birthday" readonly="readonly"></s:textfield>
						
					</td>
					<td align="center" bgColor="#f5fafe" class="ta_01">
						电话：
					</td>
					<td class="ta_01" bgColor="#ffffff">
						<!-- <input type="text" name="telephone" value="" id="telephone"/> -->
						<s:textfield name="telephone" id="telephone"></s:textfield>
					</td>
				</tr>
				<tr>
					<td align="center" bgColor="#f5fafe" class="ta_01">
						兴趣爱好：
					</td>
					<td class="ta_01" bgColor="#ffffff" colSpan="3">
						<!-- <input type="checkbox" name="interest" value="看电影" id="interest-1"/>
						<label for="interest-1" class="checkboxLabel">看电影</label>
						<input type="checkbox" name="interest" value="旅游" id="interest-2"/>
						<label for="interest-2" class="checkboxLabel">旅游</label>
						<input type="checkbox" name="interest" value="健身" id="interest-3"/>
						<label for="interest-3" class="checkboxLabel">健身</label>
						<input type="checkbox" name="interest" value="购物" id="interest-4"/>
						<label for="interest-4" class="checkboxLabel">购物</label>
						<input type="checkbox" name="interest" value="睡觉" id="interest-5"/>
						<label for="interest-5" class="checkboxLabel">睡觉</label> -->
						<s:checkboxlist list="{'看电影','旅游','健身','购物','睡觉'}" name="interest" ccsClass="checkboxLabel"></s:checkboxlist>
						<input type="hidden" id="__multiselect_userAction_save_do_interest" name="__multiselect_interest" value="" /> 
					</td>
				</tr>
				<tr>
					<td align="center" bgColor="#f5fafe" class="ta_01">
						简历资料：
					</td>
					<td class="ta_01" bgColor="#ffffff" colSpan="3">
						<!-- <input type="file" name="upload" size="30" value="" id="userAction_save_do_upload"/> -->
						<s:file name="upload" size="30" id="userAction_save_do_upload"></s:file>
					</td>
				</tr>
				<TR>
					<TD class="ta_01" align="center" bgColor="#f5fafe">
						备注：
					</TD>
					<TD class="ta_01" bgColor="#ffffff" colSpan="3">
						<!-- <textarea name="remark" cols="30" rows="3" id="userAction_save_do_remark" style="WIDTH: 96%"></textarea> -->
						<s:textarea name="remark" cols="30" rows="3" id="userAction_save_do_remark" cssStyle="WIDTH: 96%"></s:textarea>
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
						<!-- <button type="submit" id="userAction_save_do_submit" name="submit" value="&#30830;&#23450;" class="button_ok">
							&#30830;&#23450;
						</button> -->
						<s:submit id="submit" value="确定" cssClass="button_ok"></s:submit>

						<FONT face="宋体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT>
						<!-- <button type="reset" value="&#37325;&#32622;" class="button_cancel">&#37325;&#32622;</button> -->
						<s:reset value="重置" cssClass="button_cancel"></s:reset>
						<FONT face="宋体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT>
						<INPUT class="button_ok" type="button" onclick="history.go(-1)" value="返回"/>
						<span id="Label1"></span>
					</td>
				</tr>
			</table>
		</s:form>
		<!-- </form> -->
	</body>
</HTML>