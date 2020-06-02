<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>数据统计图展示</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>



    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/plugins/echarts/echarts.js"></script>
    <script type="text/javascript"  src="<%=request.getContextPath()%>/resources/plugins/echarts/map/china.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/plugins/echarts/common.js"></script>


    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/plugins/layer/layer.js"></script>
    <%--时间--%>
<%--    <script src="<%=request.getContextPath()%>/resources/js/bootstrap/js/bootstrap-datetimepicker.js"></script>--%>
<%--    <link href="<%=request.getContextPath()%>/resources/js/bootstrap/css/bootstrap-datetimepicker.css" rel="stylesheet"/>--%>

<%--    <link href="<%=request.getContextPath()%>/resources/js/bootstrap/css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>--%>



    <%--自己的js--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/system/js/userStatic.js"></script>


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
        .caption-subject{ height:30px; line-height:30px; float:left;}
    </style>


</head>
<body class="">




<div class="page-container row-fluid" style="">
    <h2 style="padding:0 20px 10px; font-size:32px; color:#ccc; font-weight: normal"><i style="font-style: normal; color: #2574A9">媒体库信息统计</i> / 查看信息<button class="btn btn-info" style="position:absolute; right:20px; top:20px;" onClick="javascript:window.history.back(-1)">返回</button></h2>
    <div class="page-sidebar nav-collapse collapse">
        <sys:sysNav ctgLevelOne="sysUser" ctgLevelTwo="userStat"/>
    </div>
    <div class="page-content">
        <div class="container-fluid">


            <div class="row-fluid row-fluid-top-25">

                <div class="span6">
                    <div class="portlet box yellow">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="icon-reorder" style="float: left;"></i> <span class="caption-subject font-dark bold">媒体平台饼图统计：</span>

                                <select id="optionOne" style="width:120px;">
                                    <option value="1">城市</option>
                                    <option value="2">媒体类型</option>
                                    <option value="3">媒体属性</option>
                                </select>

                            </div>
                            <div class="tools">
                                <a href="javascript:;" class="collapse"></a>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div id="userRoleStat" style="height: 400px;"></div>
                        </div>
                    </div>
                </div>
            </div>


               <%-- <div class="span6">
                    <div class="portlet box yellow">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="icon-bar-chart"></i>
                                <span class="caption-subject font-dark bold">用户类比统计</span>
                                <select id="optionTwo" style="width:120px;">
                                    <option value="1">年度活动邀约出席</option>
                                    <option value="2">年度媒体合作金额</option>
                                </select>

                            </div>
                            <div class="tools">
                                <a href="javascript:;" class="collapse"></a>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div id="usersRegistBar" style="height: 400px;"></div>
                        </div>
                    </div>
                </div>--%>



             <div class="row-fluid row-fluid-top-25">
                <div class="portlet box yellow">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="icon-bar-chart"  style="float: left;"></i>
                            <span class="caption-subject font-dark bold">城市年度动态信息统计：</span>
                            <select id="optionTwo" style="width:120px;">
                                <option value="1">年度活动邀约出席</option>
                                <option value="2">年度媒体合作金额</option>
                            </select>
                        </div>
                        <div class="tools">
                            <a href="javascript:;" class="collapse"></a>
                        </div>
                    </div>
                    <div class="portlet-body">
                        <div id="operationCount1" style="height: 400px;"></div>
                    </div>
                </div>

            </div>


        </div>
        <div class="clearfix"></div>
    </div>
</div>

<!-- END THEME LAYOUT SCRIPTS -->
</body>
</html>