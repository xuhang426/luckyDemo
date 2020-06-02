<%--
  Created by IntelliJ IDEA.
  User: 86136
  Date: 2020/5/24
  Time: 9:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>Bootstrap分页实例</title>
    <!--
        作者：offline
        时间：2020-05-23
        描述：外网引入js、css
    -->
    <!--<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">-->
    <%--<script src="<%=request.getContextPath()%>/resources/js/jQuery/jquery.js"></script>--%>
<%--    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>--%>
    <script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>

    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!--
        作者：offline
        时间：2020-05-23
        描述：内部引用js、css
    -->
    <link href="<%=request.getContextPath()%>/resources/js/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!--<script src="js/jQuery/jquery-2.1.4.min.js"></script>-->
    <!--<script src="js/bootstrap/js/bootstrap-paginator.min.js"></script>-->
    <!--<script src="js/bootstrap/js/bootstrap.min.js"></script>-->
    <!-- 如果要实现交互,需要引入jq,bootstrap对交互的实现要jq实现 -->
    <!--<script src="http://cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>-->
    <!-- table表格 -->
    <script src="<%=request.getContextPath()%>/resources/js/bootstrap/js/bootstrap-table.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/bootstrap/js/bootstrap-table.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/bootstrap/js/bootstrap-table-zh-CN.min.js"></script>
    <link href="<%=request.getContextPath()%>/resources/js/bootstrap/css/bootstrap-table.min.css" rel="stylesheet"/>
    <!-- bootstrap excel表格导入-->
    <link href="<%=request.getContextPath()%>/resources/js/bootstrap/Bootstrap-fileinput/fileinput.min.css"
          rel="stylesheet">
    <script type="text/javascript"
            src="<%=request.getContextPath()%>/resources/js/bootstrap/Bootstrap-fileinput/fileinput.min.js"></script>
    <script type="text/javascript"
            src="<%=request.getContextPath()%>/resources/js/bootstrap/Bootstrap-fileinput/locales/zh.js"></script>
    <%--添加数据的验证--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/plugins/validate/jquery.validate.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/plugins/validate/messages_zh.js"></script>

     <%--自己的JS--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/system/js/index.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/plugins/layer/layer.js"></script>
    <%--时间--%>



    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.bootcss.com/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.min.css" rel="stylesheet">

    <script src="<%=request.getContextPath()%>/resources/js/bootstrap/js/moment-with-locales.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js"></script>


    <!--
        作者：offline
        时间：2020-05-24
        描述：css 样式
    -->
    <style type="text/css">
        #queryDiv {
            margin-right: auto;
            margin-left: auto;
            /*width: 600px;*/
            /*padding-left: 1540px;*/
            float:right;
            padding-right:20px;
        }

        #textInput {
            margin-top: 10px;
        }

        #tableResult {
            margin-right: auto;
            margin-left: auto;
            width: 100%;
        }

        table {
            border: 0px solid #002A80;
        }

        table td {
            border: 0px solid #005580;
        }

        .bs-example {
            /*float: left;*/
            display: inline;
        }
        .modal{z-index:-1;}
        .modal.fade.in {
            width: 1200px;
            height: 860px;
            top: 5%;
            left: 35%;
            z-index:1050;
        }

        .modal-body {
            max-height: 100%;
        }

        .modal-footer {
            text-align: center;
        }
        .modal-header{margin-bottom:20px;}
        .table-bordered{border-collapse: collapse}
        .form-group{ overflow:hidden;}
        .form-group b{font-weight:700;}
        .modal table td>span{ width:150px; float: left; text-align: right;}
        .bs-example{ float: left; margin-right:4px;}
    </style>
</head>

<body style="padding:0 20px; text-align: right">



<form class="form-vertical " id="loginForm" action="<%=request.getContextPath()%>/system/" method="post">
    <table style="width: 1400px; margin-bottom: 20px; margin-top:20px; ">
        <tr class="firstRow" style="height:45px">
            <td width="231" valign="top">
                <strong><span style="font-size: 20px;">媒体平台</span></strong>
            </td>
            <td width="231" valign="top">
                <strong><span style="font-size: 20px;">媒体人</span></strong>
            </td>
            <td width="231" valign="top">
                <strong><span style="font-size: 20px;">年度动态信息</span></strong>
            </td>

        </tr>
        <tr>
            <td width="231" valign="top">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 城市：<input id="cityInputId" type="text" placeholder="" style="width:200px;height: unset;">
            </td>
            <td width="231" valign="top">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 姓名：<input id="nameInputId" type="text" placeholder="" style="width: 200px;height: unset;">
            </td>

            <td width="231" valign="top">
                6个月内报道数量：&nbsp;<input id="sixTotalStartId" type="text" placeholder="" style="width: 120px;height: unset;margin-left:3px;"> 至 <input id="sixTotalEndId" type="text" placeholder="" style="width: 120px;height: unset;">
            </td>
        </tr>
        <tr>
            <td width="231" valign="top">
                媒体名称：<input id="mediaNameInputId" type="text" placeholder="" style="width: 200px;height: unset;">
            </td>
            <td width="231" valign="top">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 性别：<select id="sexId" name="" class="selectpicker" style="width: 200px;">
                    <option value="">请选择</option>
                    <option value="0">男</option>
                    <option value="1">女</option>
                </select>
            </td>

            <td width="231" valign="top">
                年度活动邀约出席：<input id="annualInputStartId" type="text" placeholder="" style="width: 120px;height: unset;"> 至 <input id="annualInputEndId" type="text" placeholder="" style="width: 120px;height: unset;">
            </td>
        </tr>
        <tr>
            <td width="231" valign="top">
                媒体类型：<select id="mediaTypeId" name="" class="selectpicker" style="width: 200px;">
                    <option value="">请选择</option>
                    <option value="0">广播</option>
                    <option value="1">短视频</option>
                </select>
            </td>
            <td width="231" valign="top">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 职务：<input id="jobInputId" type="text" placeholder="" style="width: 200px;height: unset;">
            </td>

            <td width="231" valign="top">
                年度媒体合作金额：<input id="annualMediaStartId" type="text" placeholder="" style="width: 120px;height: unset;"> 至 <input id="annualMediaEndId" type="text" placeholder="" style="width: 120px;height: unset;">
            </td>
        </tr>
        <tr>
            <td width="231" valign="top">
                媒体属性：<select id="mediaAttributeId" name="" class="selectpicker" style="width: 200px;height: unset;">
                    <option value="">请选择</option>
                    <option value="0">党政</option>
                </select>
            </td>
            <td width="231" valign="top">
                媒体级别：<input id="mediaRankInputId" type="text" placeholder="" style="width: 200px;height: unset;">
            </td>

            <td width="231" valign="top"></td>
        </tr>
        <tr>
            <td width="231" valign="top"></td>
                <td width="231" valign="top">
                    <span style="float: left">出生年月：</span>

                    <!--指定 date标记-->
                    <div class='input-group date' id='datetimepicker1' style="width:100px;float: left; margin-bottom: 10px;">
                        <input type='text' id="timeStar" placeholder="" style="height:unset; margin-bottom:0;width:120px"  />
                        <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                    <span style="float: left">&nbsp;至&nbsp;</span>
                    <!--指定 date标记-->
                    <div class='input-group date' id='datetimepicker2' style="width:100px; float: left; margin-bottom:10px;" >
                        <input type='text' id="timeEnd"  placeholder="" style="height:unset; margin-bottom:0; width:120px;"  />
                        <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                </td>
            <td width="231" valign="top"></td>
        </tr>
        <tr>
            <td width="231" valign="top"></td>
            <td width="231" valign="top">
                手机号码：<input id="phoneInputId" type="text" placeholder="" style="width: 200px;height: unset;">
            </td>
            <td width="231" valign="top"></td>
        </tr>
    </table>



</form>
<hr>


<div class="">


    <div class="form-group" id="thumbnailUploadContainer" class="col-sm-10" style="float: left; margin-right: 4px;">
        <input id="articleImageFile" name="excelFile" type="file" class="" style="width: 300px; display: inline;" />
        <input id="saveZipButton" type="button" class ="btn btn-info" style="width: 60px;height: 35px;" value="上传" />
    </div>
    <div id="myButtons1" class="bs-example">
        <button type="button" class="btn btn-warning" data-loading-text="Loading...">下载模板</button>
    </div>
    <div id="xzdcButton" class="bs-example">
        <button type="button" class="btn btn-success" data-loading-text="Loading...">选中导出</button>
    </div>

    <div id="pldcButton" class="bs-example">
        <button type="button" class="btn btn-danger" data-loading-text="Loading...">批量导出</button>
    </div>
    <div id="searchButton" class="bs-example">
        <button type="button" class="btn btn-primary"    data-loading-text="Loading...">点击查询统计图</button>
    </div>


<div id="queryDiv" class="bs-example">

    <button id="queryButton" class="btn btn-info" type="button">查询</button>
    <button id="restButton" class="btn btn-primary" type="button">重置</button>
   <%-- <button id="addButton" class="btn btn-success" data-toggle="modal" data-target="#addModal">新增</button>--%>
    <button id="addButton" class="btn btn-success" data-toggle="modal" >新增</button>
</div>

<hr/>

<!-- table 主表格数据 -->
<table id='test-table'  data-toggle="table" ></table>


<!-- add模态框（Modal） -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true" style="padding-left:17px;">
    <div class="">
        <div class="">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="addModalLabel" style="text-align:left">
                    媒体库信息记录系统 / 基础信息
                </h4>
            </div>
            <div class="modal-body">
                <%--<form onsubmit="return check()"  id="addDemoForm" target="_blank" method="post" action="">--%>
                    <form   id="addDemoForm" target="_blank"  action=" " method="post" >
                    <!--
                    作者：offline
                    时间：2020-05-23
                    描述：核心内容 -add
               -->
        <%--配置数据的ID--%>
        <input id="id" name="id" type="hidden" >
                    <table style="width:100%;" cellpadding="0" cellspacing="0" border="0" class="ke-zeroborder"
                           bordercolor="#000000">
                        <tbody>
                        <tr>
                            <td height="45">
                                <h5 style="font-size:18px; color:#3498DB;">媒体平台信息</h5>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">城市：</span>
                                <input id="cs" name="cs" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">媒体名称：</span>
                                <input id="mtmc" name="mtmc" type="text" mtmc=""
                                            style="width: 120px;height: unset;">
                            </td>

                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">媒体属性：</span>
                                <select id="mtsx" name="mtsx" class="selectpicker"
                                        style="width: 120px;">
                                    <option value="">请选择</option>
                                    <option value="0">党政</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">媒体归属：</span>
                                <input id="mtgs" name="mtgs" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">媒体类型：</span>
                                <select id="mtlx" name="mtlx" class="selectpicker"
                                        style="width: 120px;height: unset;">
                                    <option value="">请选择</option>
                                    <option value="0">广播</option>
                                    <option value="1">短视频</option>
                                </select>
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">平台影响力：</span>
                                <input id="ptyxl" name="ptyxl" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                        </tr>
                        <tr>
                            <td height="45">
                                <h5 style="font-size:18px; color:#3498DB;">媒体人信息</h5>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">姓名：</span>
                                <input id="xm" name="xm" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">性别：</span>
                                <select id="xb" name="xb" class="selectpicker" style="width: 120px;">
                                    <option value="">请选择</option>
                                    <option value="0">男</option>
                                    <option value="1">女</option>
                                </select>
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">职务：</span>
                                <input id="zw" name="zw" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">媒 体 级 别：</span>
                                <input id="mtjb" name="mtjb" type="text" placeholder=""
                                               style="width: 120px;height: unset;">
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">友好度：</span>
                                <input id="yhd" name="yhd" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">擅 长 报 道：</span>
                                <input id="scbd" name="scbd" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">手 机 号 码：</span>
                                <input id="sjhm" name="sjhm" type="text" placeholder=""
                                               style="width: 120px;height: unset;">
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">邮箱：</span>
                                <input id="yx" name="yx" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">身份证号码：</span>
                                <input id="sfzhm" name="sfzhm" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">出生年月日：</span>
<%--                                <input id="csnf" name="csnf" type="text" placeholder=""--%>
<%--                                       style="width: 120px;height: unset;">--%>
                                <!--指定 date标记-->
                                <div class='input-group date' id='datetimepicker10'    style="width:100px;float: left; margin-bottom: 10px;">
                                    <input type='text'   name="csnf"  id ="csnf" placeholder="" style="height:unset; margin-bottom:0;width:120px"  />
                                    <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span></span>
                                </div>
<%--                                <span style="float: left; width:24px; text-align:center">&nbsp;至&nbsp;</span>--%>
<%--                                --%>
<%--                                <div class='input-group date' id='datetimepicker20' style="width:100px; float: left; margin-bottom:10px;" >--%>
<%--                                    <input type='text' placeholder="" style="height:unset; margin-bottom:0; width:120px;"  />--%>
<%--                                    <span class="input-group-addon">--%>
<%--                                    <span class="glyphicon glyphicon-calendar"></span></span>--%>
<%--                                </div>--%>

                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">家 庭 情 况：</span>
                                <input id="jtqk" name="jtqk" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">高 层 互 动：</span>
                                <input id="gchd" name="gchd" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">兴 趣 爱 好：</span>
                                <input id="xqah" name="xqah" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">服 装 号 码：</span>
                                <input id="fzhm" name="fzhm" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                            <td>
                                <br/>
                            </td>
                        </tr>
                        <tr>
                            <td >
                                <span style="color:#333333;font-family:&quot;font-size:20px;">工 作 地 址：</span>
                                <input id="gzdz" name="gzdz" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                            <td >
                                <span style="color:#333333;font-family:&quot;font-size:20px;">家 庭 地 址：</span>
                                <input id="jtdz" name="jtdz" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                            <td></td>
                        </tr>

                        <tr>
                            <td height="45">
                                <h5 style="font-size:18px; color:#3498DB;">年度动态信息</h5>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">6个月内报道数量：</span>
                                <input id="bdsl" name="bdsl" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">年度活动邀约出席：</span>
                                <input id="yycx" name="yycx" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">年度媒体合作金额：</span>
                                <input id="hzje" name="hzje" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <span style="color:#333333;font-family:&quot;font-size:20px;">备注：</span><textarea id="bz" name="bz" rows="6" cols="82"
                                             style="width: 48%; overflow: auto; word-break: break-all;"></textarea>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <div class="modal-footer" style="margin-top:10px;">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" id = "submitButton"  class="btn btn-primary">提交</button>
                    </div>
                </form>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>


    <div class="modal fade" id="queryModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true" style="padding-left:17px">
    <div class="">
        <div class="">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="queryModalLabel" style="text-align: left;">
                    媒体库信息记录系统 / 查看信息
                </h4>
            </div>
            <div class="modal-body">
                <form    target="_blank"  action=" " method="post" >

                    <table style="width:100%;" cellpadding="0" cellspacing="0" border="0" class="ke-zeroborder"
                           bordercolor="#000000">
                        <tbody>
                        <tr>
                            <td height="45">
                                <h5 style="font-size:18px; color:#3498DB;">媒体平台信息</h5>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">城市：</span>
                                <input id="csTemp" name="csTemp" readonly type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">媒体名称：</span>
                                <input id="mtmcTemp"  readonly name="mtmcTemp" type="text" mtmc=""
                                            style="width: 120px;height: unset;">
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">媒体属性：</span>
                                <select id="mtsxTemp" name="mtsxTemp" class="selectpicker"
                                        style="width: 120px;">
                                    <option value="">请选择</option>
                                    <option value="0">党政</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">媒体归属：</span>
                                <input id="mtgsTemp" readonly  name="mtgsTemp" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">媒体类型：</span>
                                <select id="mtlxTemp" name="mtlxTemp" class="selectpicker"
                                        style="width: 120px;height: unset;">
                                    <option value="">请选择</option>
                                    <option value="0">广播</option>
                                    <option value="1">短视频</option>
                                </select>
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">平台影响力：</span>
                                <input id="ptyxlTemp"  readonly name="ptyxlTemp" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                        </tr>
                        <tr>
                            <td height="45">
                                <h5 style="font-size:18px; color:#3498DB;">媒体人信息</h5>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">姓名：</span>
                                <input id="xmTemp"  readonly name="xmTemp" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                            <td >
                                <span style="color:#333333;font-family:&quot;font-size:20px;">性别：</span>

                            <select id="xbTemp"  readly name="xbTemp" class="selectpicker" style="width: 120px;">
                                    <option value="">请选择</option>
                                    <option value="0">男</option>
                                    <option value="1">女</option>
                                </select>
                            </td>
                            <td >
                                <span style="color:#333333;font-family:&quot;font-size:20px;">职务：</span>
                                <input id="zwTemp" name="zwTemp" readonly type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">媒 体 级 别：</span>
                                <input id="mtjbTemp" readonly  name="mtjbTemp" type="text" placeholder=""
                                               style="width: 120px;height: unset;">
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">友好度：</span>
                                <input id="yhdTemp" readonly name="yhdTemp" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">擅 长 报 道：</span>
                                <input id="scbdTemp" readonly name="scbdTemp" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">手 机 号 码：</span>
                                <input id="sjhmTemp" readonly  name="sjhmTemp" type="text" placeholder=""
                                               style="width: 120px;height: unset;">
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">邮箱：</span>
                                <input id="yxTemp" readonly name="yxTemp" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">身份证号码：</span>
                                <input id="sfzhmTemp" readonly name="sfzhmTemp" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">出生年月日：</span>
                                <input id="csnfTemp" readonly name="csnfTemp" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">家 庭 情 况：</span>
                                <input id="jtqkTemp" readonly name="jtqkTemp" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">高 层 互 动：</span>
                                <input id="gchdTemp" readonly name="gchdTemp" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">兴 趣 爱 好：</span>
                                <input id="xqahTemp" readonly name="xqahTemp" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">服 装 号 码：</span>
                                <input id="fzhmTemp" readonly name="fzhmTemp" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                            <td>
                                <br/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">工 作 地 址：</span>
                                <input id="gzdzTemp"  readonly name="gzdzTemp" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">家 庭 地 址：</span>
                                <input id="jtdzTemp" readonly name="jtdzTemp" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                            <td></td>
                        </tr>

                        <tr>
                            <td height="45">
                                <h5 style="font-size:18px; color:#3498DB;">年度动态信息</h5>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">6个月内报道数量：</span>
                                <input id="bdslTemp" readonly name="bdslTemp" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">年度活动邀约出席：</span>
                                <input id="yycxTemp" readonly name="yycxTemp" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                            <td>
                                <span style="color:#333333;font-family:&quot;font-size:20px;">年度媒体合作金额：</span>
                                <input id="hzjeTemp" readonly name="hzjeTemp" type="text" placeholder=""
                                       style="width: 120px;height: unset;">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" >
                                <span style="color:#333333;font-family:&quot;font-size:20px;">备注：</span>
                                <textarea id="bzTemp" name="bzTemp"   readonly rows="6" cols="82"
                                             style="width: 48%; overflow: auto; word-break: break-all;"></textarea>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <div class="modal-footer" style="margin-top:10px;">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </form>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>-
<%--查看页面--%>

</body>

<script type='text/javascript'>




    /*$(function () {



        // add 新增模态框
        //$('#addModal').modal('hide')

        // 关闭后的回调函数
        $('#addModal').on('hide.bs.modal', function () {
            // layer.msg("关闭后的回调函数，可做的处理。。。");
        })
    });*/



    //新增数据保存按钮

/*

            $("#submit").click(function () {
                $.ajax({
                    url: "../luckDemo/demoController/saveModel",
                    type: "post",
                    //.serialize() 当提交多条表单数据时，我们可以采用当表单进行序列化的方式简化原有的操作
                    data: $("#addDemoForm").serialize(),
                    dataType: "json",
                    success: function (result) {
                        if (result == "success") {
                            $("#result").html("添加成功");
                        } else {
                            $("#result").html("添加失败");
                        }
                    }
                })
            })
*/




    // 查询和重置值
  /*  $(document).ready(function () {
        // 查詢
        $("#queryButton").bind("click", function () {

            var city = $("#cityInputId").val();
            var name = $("#nameInputId").val();
            var sny = $("#startNyId").val();
            var eny = $("#endNyId").val();
            var sts = $("#sixTotalStartId").val();
            var stn = $("#sixTotalEndId").val();
            var mni = $("#mediaNameInputId").val();
            var sex = $("#sexId").val();
            var phone = $("#phoneInputId").val();
            var ais = $("#annualInputStartId").val();
            var aie = $("#annualInputEndId").val();
            var mt = $("#mediaTypeId").val();
            var job = $("#jobInputId").val();
            var ams = $("#annualMediaStartId").val();
            var ame = $("#annualMediaEndId").val();
            var ma = $("#mediaAttributeId").val();
            var mri = $("#mediaRankInputId").val();

            console.log(city, name, sny, eny, sts, stn, mni, sex, phone, ais, aie, mt, job, ams, ame, ma, mri);
            // alert(city);

    });


    });*/



    //======================================================================================






    /* function check() {
         var model = {};
         var x = $("form").serializeArray();
         // var czr_seria = {};
         $.each(x, function (i, field) {
             // czr_seria += field.name + ":" + field.value + ",";
             if ('city' == field.name && '' == field.value) {
                 layer.msg('城市不能为空');
                 return false;
             } else if ('mediaName' == field.name && '' == field.value) {
                 alert('媒体名称不能为空');
                 return false;
             } else if ('mediaAttribute' == field.name && '' == field.value) {
                 alert('请选择媒体属性');
                 return false;
             } else if ('mediaBack' == field.name && '' == field.value) {
                 alert('媒体归属不能为空');
                 return false;
             } else if ('mediaType' == field.name && '' == field.value) {
                 alert('请选择媒体类型');
                 return false;
             } else if ('ptyxl' == field.name && '' == field.value) {
                 alert('平台影响力不能为空');
                 return false;
             } else if ('job' == field.name && '' == field.value) {
                 alert('姓名不能为空');
                 return false;
             } else if ('sex' == field.name && '' == field.value) {
                 alert('请选择性别');
                 return false;
             }
             model[field.name] = field.value;
         });
         // console.log(model);
         // console.log(czr_seria);
         // 转json格式传
         var propertyInfo = JSON.stringify(model);
         console.log(propertyInfo);
         //			city:1,mediaName:2,mediaAttribute:0,mediaBack:3,mediaType:1,ptyxl:4,nameInput:5,sex:,job:6,mediaRank:7,friendly:8,scbd:9,phone:10,email:11,idCard:12,birthday:13,family:14,gchd:15,hobby:16,dressNum:17,workAdress:18,familyAdress:19,sixNum:20,annualInput:21,annualMedia:22,remarks:23
         return true;

     }*/













    //按钮注册
    window.operateEvents = {
        'click .like': function (e, value, row, index) {
            alert('You click like action, row: ' + JSON.stringify(row));
        },
        'click .remove': function (e, value, row, index) {
            $table.bootstrapTable('remove', {
                field: 'id',
                values: [row.id]
            });
        }
    }

   //根据窗口调整表格高度
    $(window).resize(function() {
        $('#test-table').bootstrapTable('resetView', {
            height: tableHeight()
        })
    })
    $('#test-table').bootstrapTable({
        //请求方法
        method: 'GET',
       // contentType: "",//必须要有！！！！application/x-www-form-urlencoded
        url:"../luckDemo/demoController/queryTableList",//要请求数据的文件路径
        height:tableHeight(),//高度调整
        toolbar: '#toolbar',//指定工具栏
        //是否显示行间隔色
        striped: true,
        //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
        cache: false,
        dataField: "rows",//bootstrap table 可以前端分页也可以后端分页，这里
        //我们使用的是后端分页，后端分页时需返回含有total：总记录数,这个键值好像是固定的
        //rows： 记录集合 键值可以修改  dataField 自己定义成自己想要的就好
        //是否显示分页（*）
        pagination: true,


        //是否启用排序
        sortable: false,
        //排序方式
        sortOrder: "asc",

        //初始化加载第一页，默认第一页
        //我设置了这一项，但是貌似没起作用，而且我这默认是0,- -
        pageNumber: 1, //初始化加载第一页，默认第一页
        //每页的记录行数（*）
        pageSize: 10,
        //可供选择的每页的行数（*）
        pageList: [10, 25, 50, 100],
        //默认值为 'limit',传给服务端的参数为：limit, offset, search, sort, order Else
        queryParamsType:'',
        //queryParams:queryParams,//请求服务器时所传的参数
        //分页方式：client客户端分页，server服务端分页（*）
        sidePagination:'server',//指定服务器端分页
        locale:'zh-CN',//中文支持,

        //查询参数,每次调用是会带上这个参数，可自定义
          queryParams:  function(params) {
             /* var subcompany = $('#subcompany option:selected').val();
              var name = $('#name').val();*/
              return {
                    pageNumber: params.pageNumber,
                    pageSize: params.pageSize,

                  cityInputId : $("#cityInputId").val(),//城市
                  nameInputId : $("#nameInputId").val(),//姓名
                  sixTotalStartId : $("#sixTotalStartId").val(),//6月数量开始
                  sixTotalEndId : $("#sixTotalEndId").val(),//6月内数量结束
                  mediaNameInputId : $("#mediaNameInputId").val(),//媒体名称
                  annualInputStartId : $("#annualInputStartId").val(),//年度出席活动数量开始
                  annualInputEndId : $("#annualInputEndId").val(),//年度出席活动数量结束
                  jobInputId : $("#jobInputId").val(),//职务
                  annualMediaStartId : $("#annualMediaStartId").val(),//媒体合作数量开始
                  annualMediaEndId : $("#annualMediaEndId").val(),//媒体合作数量结束

                  mediaTypeId : $("#mediaTypeId").val(),//媒体属性

                  mediaRankInputId : $("#mediaRankInputId").val(),//媒体级别

                  sexId : $("#sexId").val(),//性别
                  timeStar : $("#timeStar").val(),
                  timeEnd : $("#timeEnd").val(),
                  mediaAttributeId : $("#mediaAttributeId").val(),
                  phoneInputId : $("#phoneInputId").val()//手机号



              };
          },
        //  showRefresh:true,//刷新按钮
        // showColumns:true,
        clickToSelect: true,//是否启用点击选中行
        toolbarAlign:'right',//工具栏对齐方式
        buttonsAlign:'right',//按钮对齐方式
        //是否显示搜索
        search: false,
        //Enable the strict search.
        strictSearch: true,
        //Indicate which field is an identity field.

        columns: [{
            title:'全选',
            field:'select',
            //复选框
            checkbox:true,
            width:25,
            align:'center',

        }, {
            field: 'cs',
            title: '城市',
            align: 'center'
        }, {
            field: 'mtmc',
            title: '媒体名称',
            align: 'center'
        }, {
            field: 'mtlx',
            title: '媒体类型',
            align: 'center',
            formatter:
                function (value,row,index) {

                    var result;
                    if (value == '0' || value == '广播') {
                        result="广播";
                    }
                    else if(value == '0' || value == '短视频'){
                        result="短视频";
                    }else{
                        result="短视频";
                    }
                    return result;
                }
        }, {
            field: 'mtsx',
            title: '媒体属性',
            align: 'center',
            formatter:
            function (value,row,index) {

                var result;
                if (value == '0' || value == '党政') {
                    result="党政";
                }
                else {
                    result="党政";
                }
                return result;
            }
        }, {
            field: 'xm',
            title: '姓名',
            align: 'center'
        }, {
            field: 'zw',
            title: '职务',
            align: 'center'
        }, {
            field: 'sjhm',
            title: '手机号码',
            align: 'center'
        }, {
            field: 'mtjb',
            title: '媒体级别',
            align: 'center'
        }, {
            field: 'bdsl',
            title: '6个月内报道数量',
            align: 'center'
        }, {
            field: 'yycx',
            title: '年度活动邀约出席',
            align: 'center'
        }, {
            field: 'hzje',
            title: '年度媒体合作金额(元)',
            align: 'center'
        }, /*{
            field: 'id',
            title: '操作',
            align: 'center',
            formatter: function(value, row, index) {
                //通过formatter可以自定义列显示的内容
                //value：当前field的值，即id
                //row：当前行的数据
                var a = '<a href="" >测试</a>';

            }
        }*/
            {
                title: '操作',
                field: 'id',
                align: 'center',
                events: operateEvents,
                formatter: operateFormatter
            }

        ]

    });
    //请求服务数据时所传参数
    function queryParams(params){
        return{
            //每页多少条数据
            pageSize: params.limit,
            //请求第几页
            pageIndex:params.pageNumber,
            Name:$('#search_name').val(),
            Tel:$('#search_tel').val()
        }
    }

    //tableHeight函数
    function tableHeight() {
        //可以根据自己页面情况进行调整
        return $(window).height() - 280;
    }


        function operateFormatter(value, row, index) {
        return [
            '<button type="button" class="RoleOfqyery btn btn-primary   btn-sm"  onclick="query(this)" style="margin-right:15px;">查看</button>',
            '<button type="button" class="RoleOfedite  btn btn-primary  btn-sm"  onclick="edite(this)"  style="margin-right:15px;">修改</button>',
            '<button type="button" class="RoleOfdelete btn btn-primary  btn-sm"  onclick="delet(this)"  style="margin-right:15px;">删除</button>'
        ].join('');
    }

    function query(){
        var rows = $("#test-table").bootstrapTable('getSelections');
        if (rows.length == 0) {// rows 主要是为了判断是否选中，下面的else内容才是主要
            layer.msg("!!请先选择要查看的数据!");
            return;
        }else if(rows.length > 1){
            layer.msg("!!只能选择一条数据进行查看");
            return;
        }else{
            $(rows).each(function() {// 通过获得别选中的来进行遍历
                $("#csTemp").val(this.cs);
                $("#mtmcTemp").val(this.mtmc);
                $("#mtsxTemp").val(this.mtsx);
                $("#mtgsTemp").val(this.mtgs);
                $("#mtlxTemp").val(this.mtlx);
                $("#ptyxlTemp").val(this.ptyxl);
                $("#xmTemp").val(this.xm);
                $("#xbTemp").val(this.xb);
                $("#zwTemp").val(this.zw);
                $("#mtjbTemp").val(this.mtjb);
                $("#yhdTemp").val(this.yhd);
                $("#scbdTemp").val(this.scbd);
                $("#sjhmTemp").val(this.sjhm);
                $("#yxTemp").val(this.yx);
                $("#sfzhmTemp").val(this.sfzhm);
                $("#csnfTemp").val(this.csnf);
                $("#jtqkTemp").val(this.jtqk);
                $("#gchdTemp").val(this.gchd);
                $("#xqahTemp").val(this.xqah);
                $("#fzhmTemp").val(this.fzhm);
                $("#gzdzTemp").val(this.gzdz);
                $("#jtdzTemp").val(this.jtdz);
                $("#bdslTemp").val(this.bdsl);
                $("#bdslTemp").val(this.bdsl);
                $("#yycxTemp").val(this.yycx);
                $("#hzjeTemp").val(this.hzje);
                $("#bzTemp").val(this.bz);
            });
        }
         $('#queryModal').modal('show')
    }







    function edite(){
        var rows = $("#test-table").bootstrapTable('getSelections');
        console.log(rows.id);
        if (rows.length == 0) {// rows 主要是为了判断是否选中，下面的else内容才是主要
            layer.msg("!!请先选择要修改的数据!");
            return;
        }else if(rows.length > 1){
            layer.msg("!!只能选择一条数据进行修改");
            return;
        }else{
            $(rows).each(function() {// 通过获得别选中的来进行遍历
                $("#id").val(this.id);
            $("#cs").val(this.cs);
            $("#mtmc").val(this.mtmc);
            $("#mtsx").val(this.mtsx);
            $("#mtgs").val(this.mtgs);
            $("#mtlx").val(this.mtlx);
            $("#ptyxl").val(this.ptyxl);
            $("#xm").val(this.xm);
            $("#xb").val(this.xb);
            $("#zw").val(this.zw);
            $("#mtjb").val(this.mtjb);
            $("#yhd").val(this.yhd);
            $("#scbd").val(this.scbd);
            $("#sjhm").val(this.sjhm);
            $("#yx").val(this.yx);
            $("#sfzhm").val(this.sfzhm);
            $("#csnf").val(this.csnf);
            $("#jtqk").val(this.jtqk);
            $("#gchd").val(this.gchd);
            $("#xqah").val(this.xqah);
            $("#fzhm").val(this.fzhm);
            $("#gzdz").val(this.gzdz);
            $("#jtdz").val(this.jtdz);
            $("#bdsl").val(this.bdsl);
            $("#bdsl").val(this.bdsl);
            $("#yycx").val(this.yycx);
            $("#hzje").val(this.hzje);
                $("#bz").val(this.bz);
            });
        }

        $('#addModal').modal('show')

    }


    // 删除按钮事件
    function delet(){
      /*  if (!confirm("是否确认删除？"))
            return;*/
        layer.msg("您确定删除么？", {
            btn:['确定','取消'],
            yes : function(){
                var rows = $("#test-table").bootstrapTable('getSelections');// 获得要删除的数据
                if (rows.length == 0) {// rows 主要是为了判断是否选中，下面的else内容才是主要
                    layer.msg("!!请先选择要删除的记录!");
                    return;
                } else {
                    var ids = new Array();// 声明一个数组
                    $(rows).each(function() {// 通过获得别选中的来进行遍历
                        ids.push(this.id);// cid为获得到的整条数据中的一列
                    });
                    deleteMs(ids)
                }
            }
        });



    }
    function deleteMs(ids) {
        $.ajax({
            url :  "../luckDemo/demoController/delete",
            data : "ids=" + ids,
            type : "post",
            dataType : "json",
            success : function(data) {
                console.log(data)
                $('#test-table').bootstrapTable('refresh', {
                    url : '../luckDemo/demoController/queryTableList'
                });
            }
        });
    }





</script>
<script>

    /* 时间区间开始 */

    $(function () {
        var picker1 = $('#datetimepicker1').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: moment.locale('zh-cn'),
            //minDate: '2016-7-1'
        });
        var picker2 = $('#datetimepicker2').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: moment.locale('zh-cn')
        });
        //动态设置最小值
        picker1.on('dp.change', function (e) {
            picker2.data('DateTimePicker').minDate(e.date);
        });
        //动态设置最大值
        picker2.on('dp.change', function (e) {
            picker1.data('DateTimePicker').maxDate(e.date);
        });

        var picker10 = $('#datetimepicker10').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: moment.locale('zh-cn'),
            //minDate: '2016-7-1'
        });

        //动态设置最小值
        picker10.on('dp.change', function (e) {
            picker2.data('DateTimePicker').minDate(e.date);
        });

    });

</script>

</html>