var flag = false;
$(function(){

    //点击查询统计图
    $("#searchButton").bind("click", function () {
          window.location.href = '../luckDemo/demoController/change';
    });
    $("#queryButton").bind("click", function () {

        $('#test-table').bootstrapTable('refresh');

    });

    //批量
    $("#pldcButton").bind("click", function () {


           var ids = "";

            location.href = '../luckDemo/demoController/orderrdExportExcel?ids='+ids;



    });
//选中导出
    $("#xzdcButton").bind("click", function () {

       var rows = $("#test-table").bootstrapTable('getSelections');// 获得要删除的数据
       if (rows.length == 0) {// rows 主要是为了判断是否选中，下面的else内容才是主要
           layer.msg("!!请先选择要导出的记录!");
           return;
       } else {
           var ids = new Array();// 声明一个数组
           $(rows).each(function() {// 通过获得别选中的来进行遍历
               ids.push(this.id);// cid为获得到的整条数据中的一列
           });

           location.href = '../luckDemo/demoController/orderrdExportExcel?ids='+ids;

       }


    });


    //选中导出
    // $("#xzdcButton").bind("click", function () {
    //
    //     var rows = $("#test-table").bootstrapTable('getSelections');// 获得要删除的数据
    //     if (rows.length == 0) {// rows 主要是为了判断是否选中，下面的else内容才是主要
    //         layer.msg("!!请先选择要删除的记录!");
    //         return;
    //     } else {
    //         var ids = new Array();// 声明一个数组
    //         $(rows).each(function() {// 通过获得别选中的来进行遍历
    //             ids.push(this.id);// cid为获得到的整条数据中的一列
    //         });
    //         layer.msg(ids);
    //         exportMs(ids)
    //     }
    // });
    function exportMs(ids) {
        $.ajax({
            url :  "../luckDemo/demoController/exportBatch",
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






























   //当点击添加按钮的时候清空表单
    $("#addButton").bind("click", function () {
        localRest();//清空数据
        $('#addModal').modal('show')
    });
    // add 新增form表单验证
    $("#submitButton").bind("click", function () {
        if($("#cs").val()==''){//城市
            flag = false;
            layer.msg("城市字段不能为空");
            return false;
        }else if ($("#mtmc").val()==''){
            flag = false;
            layer.msg("媒体名称字段不能为空");
            return false;
        }else if ($("#mtsx").val()==''){
            flag = false;
            layer.msg("媒体属性字段不能为空");
            return false;
        }
        else if ($("#mtgs").val()==''){
            flag = false;
            layer.msg("媒体归属字段不能为空");
            return false;
        }
        else if ($("#mtlx").val()==''){
            flag = false;
            layer.msg("媒体类型字段不能为空");
            return false;
        }
        else if ($("#ptyxl").val()==''){
            flag = false;
            layer.msg("平台影响力字段不能为空");
            return false;
        }
        else if ($("#xm").val()==''){
            flag = false;
            layer.msg("姓名字段不能为空");
            return false;
        }
        else if ($("#xb").val()==''){
            flag = false;
            layer.msg("性别字段不能为空");
            return false;
        }
        else if ($("#zw").val()==''){
            flag = false;
            layer.msg("职务字段不能为空");
            return false;
        }
        else if ($("#mtjb").val()==''){
            flag = false;
            layer.msg("媒体级别字段不能为空");
            return false;
        }
        else if ($("#yhd").val()==''){
            flag = false;
            layer.msg("友好度字段不能为空");
            return false;
        }
        else if ($("#scbd").val()==''){
            flag = false;
            layer.msg("擅长报道字段不能为空");
            return false;
        }
        else if ($("#sjhm").val()==''){
            flag = false;
            layer.msg("手机号码字段不能为空");
            return false;
        }
        else if ($("#yx").val()==''){
            flag = false;
            layer.msg("邮箱字段不能为空");
            return false;
        }
        else if ($("#sfzhm").val()==''){
            flag = false;
            layer.msg("身份证号码字段不能为空");
            return false;
        }
        else if ($("#csnf").val()==''){
            flag = false;
            layer.msg("出生日期字段不能为空");
            return false;
        }
        else if ($("#jtqk").val()==''){
            flag = false;
            layer.msg("家庭情况字段不能为空");
            return false;
        }else if ($("#gchd").val()==''){
            flag = false;
            layer.msg("高层互动字段不能为空");
            return false;
        }else if ($("#xqah").val()==''){
            flag = false;
            layer.msg("兴趣爱好字段不能为空");
            return false;
        }else if ($("#fzhm").val()==''){
            flag = false;
            layer.msg("服装号码字段不能为空");
            return false;
        }else if ($("#gzdz").val()==''){
            flag = false;
            layer.msg("工作地址字段不能为空");
            return false;
        }else if ($("#jtdz").val()==''){
            flag = false;
            layer.msg("家庭地址字段不能为空");
            return false;
        }else if ($("#bdsl").val()==''){
            flag = false;
            layer.msg("6个月内报道数量不能为空");
            return false;
        }else if ($("#bdsl").val()==''){
            flag = false;
            layer.msg("6个月内报道数量不能为空");
            return false;
        }
        else if ($("#yycx").val()==''){
            flag = false;
            layer.msg("年度活动邀约出席不能为空");
            return false;
        }
        else if ($("#hzje").val()==''){
            flag = false;
            layer.msg("年度媒体合作金额不能为空");
            return false;
        }
        else if ($("#bz").val()==''){
            flag = false;
            layer.msg("备注不能为空");
            return false;
        }


                $.ajax({
                    url: "../luckDemo/demoController/insertOrUpdate",
                    type: "post",
                    dataType: "json",
                    data: $("#addDemoForm").serialize(),
                    success: function (data) {
                        if (data.flag == true) {
                            layer.msg("操作数据成功");
                            $('#addModal').modal('hide')
                            localRest();
                            $('#test-table').bootstrapTable('refresh', {
                                url : '../luckDemo/demoController/queryTableList'
                            });
                        } else if (data == "error") {
                            layer.msg("操作数据失败");
                        }
                    }
                });

    });





    //重置添加的文本框
    function localRest(){
        $("#cs").val("");
        $("#mtmc").val("");
        $("#mtsx").val("");
        $("#mtgs").val("");
        $("#mtlx").val("");
        $("#ptyxl").val("");
        $("#xm").val("");
        $("#xb").val("");
        $("#zw").val("");
        $("#mtjb").val("");
        $("#yhd").val("");
        $("#scbd").val("");
        $("#sjhm").val("");
        $("#yx").val("");
        $("#sfzhm").val("");
        $("#csnf").val("");
        $("#jtqk").val("");
        $("#gchd").val("");
        $("#xqah").val("");
        $("#fzhm").val("");
        $("#gzdz").val("");
        $("#jtdz").val("");
        $("#bdsl").val("");
        $("#bdsl").val("");
        $("#yycx").val("");
        $("#bz").val("");

    }








    //修改数据按钮



    /*修改操作*/

    // 搜索条件重置
    $("#restButton").bind("click", function () {
        $("input[type=text]").val(''); // input文本框值清空
        //			  $(".licontent input[type=hidden]").val('');			// input文本框隐藏值清空

        // 对class属性的所有操作（清空没起作用）
        //  		$(".selectpicker").selectpicker('deselectAll');
        //  		$(".selectpicker").selectpicker('refresh');

        //回到初始状态
        //对下拉框进行重置刷新
        document.getElementById("sexId").options.selectedIndex = 0;
        document.getElementById("mediaTypeId").options.selectedIndex = 0;
        document.getElementById("mediaAttributeId").options.selectedIndex = 0;
        $('#test-table').bootstrapTable('refresh');
    });


//============================================导入EXCEL数据start================
    //导入excel文件
    $("#saveZipButton").on('click', function(){
        var formData = new FormData();
        var fileName = $("#articleImageFile").val();
        if (fileName == '') {
            layer.msg('请选择导入数据文件！');
            return false;
        }
        //验证文件格式
        var fileType = (fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length)).toLowerCase();
        if (fileType != 'xlsx' && fileType != 'xls' ) {
            layer.msg('文件格式不正确！');
            return false;
        }
        formData.append("file",$("#articleImageFile")[0].files[0]);
        //formData.append("name",name);//这个地方可以传递多个参数
        $.ajax({
            url :  "../luckDemo/demoController/insertExcel",
            type : 'POST',
            async : false,
            data : formData,
            // 告诉jQuery不要去处理发送的数据
            processData : false,
            // 告诉jQuery不要去设置Content-Type请求头
            contentType : false,
            beforeSend:function(){
                console.log("正在进行，请稍候");
            },
            success : function(responseStr) {
                console.log(responseStr.flg);
                if(responseStr.flg==true){
                    layer.msg("导入成功");
                    window.location.reload();
                    return false;
                }else{
                    layer.msg("导入失败");
                    window.location.reload();
                    return false;
                }
            }
        });
    });

//============================================下载模板start================
    // 下载模板
    $("#myButtons1 .btn").click(function () {
            location.href = '../luckDemo/demoController/downloadExcel?name=model';
    });
//=====================================================================下载模板END================

});