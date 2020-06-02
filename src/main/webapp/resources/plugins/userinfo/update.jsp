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
	
<form action="UpdateUser.do" method="post" onsubmit="return validateFrom();" enctype="multipart/form-data">
	账号：<input name="account" id="account" value="${u.account }"/><span id="accountInfo"></span> <br/>
	真实姓名：<input name="realname" value="${u.realname }"/><br/>
	<div id="sexDiv">
		性别：
		<input type="radio" name="sex" value="1"/> 男
		<input type="radio" name="sex" value="0" />女
	</div>
		
	状态:
	<div id="statDiv">
		<input type="radio" name="stat" value="0"/> 冻结
		<input type="radio" name="stat" value="1"/>正常<br/>
	</div>
	部门:
		<select name="dept_id" id="dept_id">
			<option value="">请选择部门</option>
			<c:forEach items="${deptList }" var="d">
			<option value="${d.dept_id }">${d.dept_name }</option>
			</c:forEach>
		</select> 
		<br/>
	头像：<input type="file" name="photo" onchange="preview(this,'preview','imghead',150,200)"/>
			<div id="preview">
				<img id="imghead" width="202" height="111"/>
			</div>
			<br/>
			<input type="hidden" value="${u.userinfo_id }" name="userinfo_id"/>
	<input type="submit" value="修改"/>
</form>

<script type="text/javascript" src="plugins/jquery/jquery.min.js"></script>
<script type="text/javascript" src="<%=path %>plugins/imagePreview/imagePreview.js"></script>

<script type="text/javascript">
// 
$(function(){
	//单选按钮回显
	$("#sexDiv :radio[name='sex']").val(["${u.sex}"]); //单选和多选 是需要数组值
	$("#statDiv :radio[name='stat']").val(["${u.stat}"]);
	//下拉框回显
	$("#dept_id").val("${u.dept_id}");
});

var va = true;
$(function(){
	
	$("#account").keyup(function(){
		
		var account = $(this).val();
		var $accountInfo = $("#accountInfo");
		if(account.toString()!="${u.account }"){
		$.post("ValidateAccount.do", {account: account}, function(r){
			
				if(r == "true") {
					va = true;
					$accountInfo.html("不存在此账号 可以使用").css("color","green");
				}else {
					va = false;
					$accountInfo.html("已存在此账号 不可以使用").css("color","red");
				}
			
		});
		}else{
			va=true;
		}
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