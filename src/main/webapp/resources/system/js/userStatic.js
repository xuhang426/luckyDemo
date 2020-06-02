/**
 * 用户统计模块模型
 */

//用户注册统计数

var nametemp;
$(function () {
    init();//初始化
    $("#optionOne").change(function () {
        reloadUserStat();
    });
    $("#optionTwo").change(function () {
        reloadUserStat1();
    });
    //整体方法初始化
    function init() {
        //初始化加载统计日期
      /*  $.post("../system/static/queryUserYears", function (data) {
            for (var i = 0; i < data.length; i++) {
                $("#yearStat").append("<option value ='" + data[i] + "'>" + data[i] + "</option>");
            }
        });*/
        //初始化加载用户月份统计信息
        reloadUserStat();

        reloadUserStat1();
    }
    //点击查询列表数据
    $("#searchButton").bind("click", function () {
        window.location.href = '../luckDemo/demoController/changetitle';


    });
    //MySQL name value 小写
    function reloadUserStat() {
        $.post("../demoController/ryfbEchart", {optionOne: $("#optionOne").val()}, function (data) {
            var newData = [];
            for (var i = 0; i < data.length; i++) {
                var name = data[i].name || data[i].NAME;
                var value = data[i].value || data[i].VALUE;
                option.legend.data.push(name);
                var temp = {};
                temp.name = name;
                temp.value = value;
                newData.push(temp);
            }

            option.series[0].data = newData;
            roleUserChar.setOption(option);
        });
    }




//各种角色用户占比
    var roleUserChar = echarts.init(document.getElementById('userRoleStat'));
    var option = {tooltip: {trigger: 'item',formatter: "{a} <br/>{b}: {c} ({d}%)"},
        color:["#2574A9","#3498DB","#59ABE3","#19B5FE","#6BB9F0"],
        legend: {orient: 'vertical',x: 'right',y:"bottom",data:[]},
        toolbox: {show: true,feature: {dataView: {show: true,readOnly: false},restore: {show: true},saveAsImage: {show: true}}},
        series: [{name:'数量分布',type:'pie',radius: '65%',center: ['40%', '50%'],
            itemStyle: {emphasis: {shadowBlur: 10,shadowOffsetX: 0,shadowColor: 'rgba(0, 0, 0, 0.5)'}}
        }]
    };


    //用户注册用户统计设置
   /* var userRegisterChart = echarts.init(document.getElementById('usersRegistBar'));

    //用户图数据设置
    var userRegistOption = {
        tooltip: {trigger: 'axis', axisPointer: {type: 'cross', label: {backgroundColor: '#F5F5F5'}}},
        legend: {data: ['用户注册数'], x: "left"},
        color: ["#3498DB", "#59ABE3", "#19B5FE", "#6BB9F0"],
        grid: {top: "20%", left: "8%", right: "4%", "bottom": "10%", containLabel: true},
        toolbox: {show: true,
            feature: {
                mark: {show: true},
                dataView: {show: true, readOnly: false},
                magicType: {show: true, type: ['line', 'bar']},
                restore: {show: true},
                saveAsImage: {show: true}
            }
        },
        calculable: true,
        xAxis: [{type: 'category',splitLine: {show:false},
            axisLine: {
                lineStyle: {
                    color: '#e4e4e4'
                }
            },
            axisTick : {    // 轴标记
                show:false,
                // length: 10,
                lineStyle: {
                    color: 'red',
                    type: 'solid',
                    width: 2
                }
            },
            splitLine: {
                show: true,
                lineStyle: {
                    color: '#F5F5F5',
                    width: 1,
                    type: 'solid'
                }
            },
            axisLabel: {
                show: true,
                textStyle: {
                    color: '#9EA7B3'
                }
            },data: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']}],
        yAxis: [{type: 'value',splitArea: {show: false}, boundaryGap: false,
            axisLine: {
                lineStyle: {
                    color: '#e4e4e4'
                }
            },
            axisTick : {    // 轴标记
                show:false,
                // length: 10,
                lineStyle: {
                    color: 'red',
                    type: 'solid',
                    width: 2
                }
            },
            splitLine: {
                show: true,
                lineStyle: {
                    color: '#F5F5F5',
                    width: 1,
                    type: 'solid'
                }
            },
            axisLabel: {
                show: true,
                textStyle: {
                    color: '#7d8490'
                }
            }}],series: [{name: '用户注册数',type: 'bar',data: []}]
    }

    function reloadUserStat() {
        $.post("../system/static/userReqistMonthStatic", {year: $("#yearStat").val()}, function (data) {
            var xData = userRegistOption.xAxis[0].data;
            var yData = [];
            for (var i = 0; i < xData.length; i++) {
                for (var j = 0; j < data.length; j++) {
                    if ((i + 1) == (data[j].MONTH || data[j].month)) {
                        yData[i] = (data[j].AMOUNT || data[j].amount);
                        break;
                    } else {
                        yData[i] = 0;
                    }
                }
            }
            userRegistOption.series[0].data = yData;
            userRegisterChart.setOption(userRegistOption);
        });
    }
*/











   var operationCount1 = echarts.init(document.getElementById('operationCount1'));

    optionUserOptionNums = {
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow',
                label: {
                    show: true
                }
            }
        },
        toolbox: {
            show: true,
            feature: {
                mark: {show: true},
                dataView: {show: true, readOnly: false},
                magicType: {show: true, type: ['line', 'bar']},
                restore: {show: true},
                saveAsImage: {show: true}
            }
        },
        calculable: true,
        legend: {
            data: ['Growth', 'Budget 2012'],
            itemGap: 5
        },
        grid: {
            top: '12%',
            left: '1%',
            right: '10%',
            containLabel: true
        },
        xAxis: [
            {
                type: 'category',
                data: []
            }
        ],
        yAxis: [
            {
                type: 'value',
                name: '',
                axisLabel: {
                    formatter: function (a) {
                        a = +a;
                        return isFinite(a)
                            ? echarts.format.addCommas(+a / 1000)
                            : '';
                    }
                }
            }
        ],
        dataZoom: [
            {
                show: true,
                start: 94,
                end: 100
            },
            {
                type: 'inside',
                start: 94,
                end: 100
            },
            {
                show: true,
                yAxisIndex: 0,
                filterMode: 'empty',
                width: 30,
                height: '80%',
                showDataShadow: false,
                left: '93%'
            }
        ],
        series: [
            {
                name: '用户操作数量',
                type: 'bar',
                data: []
            },
        ]
    };
    optionUserOptionNums = {
        tooltip : {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow',
                label: {
                    show: true
                }
            }
        },
        color:["#59ABE3"],
        toolbox: {
            show : true,
            feature : {
                mark : {show: true},
                dataView : {show: true, readOnly: false},
                magicType: {show: true, type: ['line', 'bar']},
                restore : {show: true},
                saveAsImage : {show: true}
            }
        },
        calculable : true,
        legend: {
            data:['Growth', 'Budget 2012'],
            itemGap: 5
        },
        grid: {
            top: '12%',
            left: '1%',
            right: '10%',
            containLabel: true
        },
        xAxis: [
            {
                type : 'category',
                data : []
            }
        ],
        yAxis: [
            {
                type : 'value',
                name : '',
                axisLabel: {
                    formatter: function (a) {
                        a = +a;
                        return isFinite(a)
                            ? echarts.format.addCommas(+a / 1000)
                            : '';
                    }
                }
            }
        ],
        dataZoom: [
            {
                show: true,
                start: 30,
                end: 100
            },
            {
                type: 'inside',
                start: 94,
                end: 100
            },
            {
                show: true,
                yAxisIndex: 0,
                filterMode: 'empty',
                width: 30,
                height: '80%',
                showDataShadow: false,
                left: '93%'
            }
        ],
        series : [
            {
                name: '用户操作数量',
                type: 'bar',
                data: []
            },
        ]
    };

    function reloadUserStat1() {
        $.post("../demoController/ryfbEchartTemp", {optionTwo: $("#optionTwo").val()},  function (data) {

            var newmap = {};
            var newname = [];
            var newnum = [];
            newmap = data.map;
            for (var i = 0; i < data.length; i++) {
                newname.push(data[i].NAME || data[i].name);
                newnum.push(data[i].NUM || data[i].num);
            }
            optionUserOptionNums.xAxis[0].data = newname;
            optionUserOptionNums.series[0].data = newnum;
            operationCount1.setOption(optionUserOptionNums);
        });

    }

});

