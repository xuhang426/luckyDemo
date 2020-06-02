<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath() + "/";
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="UserinfoAdd.do" method="post" onsubmit="return validateFrom();" enctype="multipart/form-data">
	账号：<input name="account" id="account"/><span id="accountInfo"></span> <br/>
	真实姓名：<input name="realname"/><br/>
	<div id="sexDiv">
		性别：
		<input type="radio" name="sex" value="1"/> 男
		<input type="radio" name="sex" value="0"/>女
	</div>
		
	状态:
		<input type="radio" name="stat" value="0"/> 冻结
		<input type="radio" name="stat" value="1"/>正常<br/>
	部门:
		<select name="dept_id" id="dept_id">
			<option value="">请选择部门</option>
			<c:forEach items="${dList }" var="d">
			<option value="${d.dept_id }">${d.dept_name }</option>
			</c:forEach>
		</select> 
		<br/>
	头像：<input type="file" name="photo" onchange="preview(this,'preview','imghead',150,200)"/>
			<div id="preview">
				<img id="imghead" width="202" height="111"/>
			</div>
			<br/>
	<input type="submit" value="添加"/>
</form>

<script type="text/javascript" src="plugins/jquery/jquery.min.js"></script>
<script type="text/javascript" src="<%=path %>plugins/imagePreview/imagePreview.js"></script>

<script type="text/javascript">
var va = false;
$(function(){
	$("#account").keyup(function(){
		var account = $(this).val();
		var $accountInfo = $("#accountInfo");
		
		$.post("ValidateAccount.do", {account: account}, function(r){
			if(r == "true") {
				va = true;
				$accountInfo.html("不存在此账号 可以使用").css("color","green");
			}else {
				va = false;
				$accountInfo.html("已存在此账号 不可以使用").css("color","red");
			}
		});
	});
});


function validateFrom(){
	//文本框的验证
	var $account = $("#account");
	if($account.val() == "") {
		alert("请输入账号");
		$account[0].focus();
		return false;
	}
	
	//单选按钮的验证
	var $radSex = $("#sexDiv :radio[name='sex']");
	if($radSex.filter(":checked").length == 0){
		alert("请选择性别");
		return false;
	}
	
	//下拉框的验证
	var $sltDept = $("#dept_id");
	if($sltDept.val() == 0) {
		alert("请选择部门");
		return false;
	}
	
	if(va == false) {
		return false;
	}
	
	return true;
}
</script>
</body>
</html>