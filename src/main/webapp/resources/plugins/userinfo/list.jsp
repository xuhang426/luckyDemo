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
<title>用户列表</title>
<link rel="stylesheet" href="plugins/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="plugins/bootstrap-table/bootstrap-table.css">

</head>
<body>
	<table id="mytable"></table>
<script src="plugins/jquery/jquery.min.js"></script>
<!-- boootstrap需用 -->
<script src="plugins/bootstrap/js/bootstrap.min.js"></script>
<script src="plugins/bootstrap-table/bootstrap-table.js"></script>
<script src="plugins/layer/layer.js"></script>
<script type="text/javascript">
$(function(){
	$("#mytable").bootstrapTable({
		url:"UserinfoQuery.do",
		columns:[{
			checkbox:true
		},{
			field:"account",
			title:"账号",
			sortable:true,
			halign:"center"
		},{
			field:"realname",
			title:"真实姓名",
			sortable:true,
			halign:"center"
		},{
			field:"sex",
			title:"性别",
			sortable:true,
			halign:"center",
			formatter: "sexFormatter"
		},{
			field:"stat",
			title:"状态",
			sortable:true,
			halign:"center",
			formatter:"statFormatter"
		},{
			field:"dept_id",
			title:"部门",
			sortable:true,
			halign:"center"
		},{
			field:"photo",
			title:"头像",
			sortable:true,
			halign:"center",
			formatter:"imgFormatter"
		},{
			title:"操作",
			formatter:"operateFormatter",
			events:"operateEvents"
		}],
		/******************************【数据请求】****************************************************/
		method : "post",//['get']服务器数据的请求方式 'get' or 'post'
		contentType:"application/x-www-form-urlencoded; charset=UTF-8",//['application/json']发送到服务器的数据编码类型
		/****************************【分页】******************************************************/
		pagination: true, //[false] 设置为 true 会在表格底部显示分页条
		pageSize: 7,//[10] 如果设置了分页，页面数据条数
		/*Array [10, 25, 50, 100, All]如果设置了分页，设置可供选择的页面数据条数。
		设置为All 则显示所有记录。*/
		pageList: [ 5,7, 10, 25, 50, 100, 'All'], 
		/*****************************【下拉框】*****************************************************/
		showColumns: true,//[false]是否显示 内容列下拉框

		/*****************************【搜索】*****************************************************/
		search: true,//[false]是否启用搜索框
	});


});
function sexFormatter(value,row,index){
	if(value=="0"){
		return "女";
	}else if(value=="1"){
		return "男";
	}else{
		return "";
	}
}		
function statFormatter(value,row,index){
	if(value=="0"){
		return "冻结";
	}else if(value=="1"){
		return "正常";
	}else{
		return "";
	}
}
function imgFormatter(value,row,index){
	return "<img src='upload/"+row.photo+"' width=100/>";
}
function operateFormatter(){
    var s = [
        '<button class="like btn-default btn btn-xs glyphicon glyphicon-info-sign" title="测试"></button>',
        ' <button class="edit btn-default btn btn-xs  glyphicon glyphicon-edit"  title="编辑"></button>',
        ' <button class="remove btn-default btn btn-xs glyphicon glyphicon-remove" title="删除"></button>'
    ];
    
    return s.join('');
}

//操作事件
window.operateEvents = {
  'click .like': function (e, value, row, index) {
  	//location.href="del.do?id=" +row.id; 
    //  alert('You click like action, row: ' + JSON.stringify(row));
  },
  'click .edit': function (e, value, row, index) {
      //alert('You click like action, row: ' + JSON.stringify(row));
      location.href="UpdateUser.do?userinfo_id="+row.userinfo_id;
  },
  'click .remove': function (e, value, row, index) {
  	var index = layer.msg("您确定删除么？", {
  		btn:['确定','取消'],
  		yes : function(){
  			 location.href="DeleUser.do?userinfo_id="+row.userinfo_id;
  		  
  		}
  	});
  	
  	
  }
};
</script>
</body>
</html>