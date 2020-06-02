package com.example.demo.controller;

import com.example.demo.model.DemoModel;
import com.example.demo.service.DemoService;
import com.example.demo.utils.ExcelUtil;
import com.example.demo.utils.ExportExcelSeedBack;
import com.example.demo.utils.ReadExcel;
import net.sf.json.JSONArray;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.DateUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.tagext.PageData;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.*;

@Controller
@RequestMapping("/demoController")
public class DemoController {
    @Resource
    private final DemoService demoService;

    public DemoController(DemoService demoService) {
        this.demoService = demoService;
    }


    /**
     * 查询bootStrop   Table的数据带搜索条件  带分页
     * @return
     */
    @RequestMapping("/queryTableList")
    @ResponseBody
    public Map<String,Object> queryTableList(@RequestParam("pageNumber") Integer pageNumber, @RequestParam("pageSize") Integer pageSize,DemoModel demoModel,String mediaAttributeId ,String cityInputId,String nameInputId,String sixTotalStartId,String sixTotalEndId,String mediaNameInputId,String annualInputStartId,String annualInputEndId,String jobInputId,String annualMediaStartId,String annualMediaEndId,String mediaTypeId ,String mediaRankInputId ,String sexId ,String timeStar ,String timeEnd ,String phoneInputId
    ){
        System.err.println("pageNumber"+pageNumber);
        System.err.println("pageSize"+pageSize);
       //最终返回数据结果
        Map<String,Object> responseMap = new HashMap<>();
        // 查看全部数据执行后端分页查询
        Map<String,Object> queryMap = new HashMap<String,Object>();
        if (pageNumber <= 1){
            pageNumber = 1;
        }
        int beginNumber = (pageNumber - 1)* pageSize;
        queryMap.put("beginNumber", beginNumber);
        queryMap.put("limit", pageSize);
        queryMap.put("cityInputId",cityInputId);
        queryMap.put("nameInputId",nameInputId);
        queryMap.put("sixTotalStartId",sixTotalStartId);
        queryMap.put("sixTotalEndId",sixTotalEndId);
        queryMap.put("mediaNameInputId",mediaNameInputId);
        queryMap.put("annualInputStartId",annualInputStartId);
        queryMap.put("annualInputEndId",annualInputEndId);
        queryMap.put("jobInputId",jobInputId);
        queryMap.put("annualMediaStartId",annualMediaStartId);
        queryMap.put("annualMediaEndId",annualMediaEndId);
        queryMap.put("mediaTypeId",mediaTypeId );
        queryMap.put("mediaRankInputId ",mediaRankInputId );
        queryMap.put("sexId",sexId );
        queryMap.put("timeStar",timeStar );
        queryMap.put("timeEnd",timeEnd );
        queryMap.put("phoneInputId",phoneInputId );
        queryMap.put("mediaAttributeId",mediaAttributeId );


        System.err.println("queryMap.toString()"+queryMap.toString());
        List<DemoModel >  list  =demoService.queryTableList(queryMap,demoModel);


        System.err.println("list.toString()"+list.toString());

        int count = demoService.queryCount(queryMap);
        int total = list.size();
        //key需要与js中 dataField对应，bootStrap默认值为rows
        responseMap.put("rows", list);
        // 需要返回到前台，用于计算分页导航栏
        responseMap.put("total", count);
        return responseMap;
       }


    /**
     * JSP 测试
     * @return JSP 视图
     */
    @RequestMapping("/change")
    public String change() {

        return "userStat";
    }

    /**
     * JSP 测试
     * @return JSP 视图
     */
    @RequestMapping("/changetitle")
    public String changetitle() {

        return "index";
    }
    /**
     * 新增数据对应实体DemoVO
     * @return
     */
    @RequestMapping("/insertOrUpdate")
    @ResponseBody
    public Map<String,Object> insertOrUpdate(@ModelAttribute DemoModel demoModel){
        Map<String,Object> responseMap = new HashMap<>();
        //转换时间字段        csnf
        demoModel.setCsnyr(demoModel.getCsnf().substring(0,4));//存储年份
        demoModel.setYf(demoModel.getCsnf().substring(5,7));//月份
        demoModel.setRq(demoModel.getCsnf().substring(8,10));//日期

        System.err.println("见来了吗");
        System.err.println("demoModel"+demoModel.toString());
        System.err.println("demoModel.getId()"+demoModel.getId());
        int  num = 0;
        if(demoModel.getId() == null){
            num = demoService.insertSelective(demoModel);

            System.err.println("走添加");
        }else{
            num = demoService.updateByPrimaryKeySelective(demoModel);
            System.err.println("走修改");
        }

        System.err.println("numnumnumnum"+num);
        if(num > 0){
            responseMap.put("flag",true);
        }else{
            responseMap.put("flag",false);
        }


        return responseMap;
    }



















    /**
     * 查询用户类型人员分布图标
     * @return
     */
    @RequestMapping("/ryfbEchart")
    @ResponseBody
    public List<Map<String,Object>> ryfbEchart( String  optionOne){
        System.err.println(optionOne);
        List<Map<String,Object>> result = new ArrayList<>();

        //最终返回数据结果
        /*Map<String,Object> responseMap = new HashMap<>();
        Map<String,Object> responseMap1 = new HashMap<>();*/
        if("1".equals(optionOne)){//城市
            result = demoService.queryListEchartBycs();

        }else if("2".equals(optionOne)){//媒体类型
            result = demoService.queryListEchartBymtlx();

            if(result.size()> 0){// 媒体类型 ：0市广播 1是短视频
                for (int i = 0; i < result.size(); i++) {
                    Map<String ,Object> mapTemp  = result.get(i);
                    if("1".equals(mapTemp.get("name"))){
                        mapTemp.put("name","短视频");
                        System.err.println("短视频");
                    }else{
                        mapTemp.put("name","广播");
                        System.err.println("0市广播");
                    }
                }
            }
        }else if("3".equals(optionOne)){//媒体属性
            result = demoService.queryListEchartBymtsx();

            if(result.size()> 0){// 媒体属性 ：0党政
                for (int i = 0; i < result.size(); i++) {
                    Map<String ,Object> mapTemp  = result.get(i);
                    if("0".equals(mapTemp.get("name"))){
                        mapTemp.put("name","党政");
                        System.err.println("党政");
                    }else{
                        mapTemp.put("name","党政");
                        System.err.println("党政");
                    }
                }
            }


        }




       /* result.add(responseMap);
        result.add(responseMap1);
*/
        System.err.println("resultresult"+result.toString());
        return result;
    }



    /**
     * 查询用户类型人员分布图标
     * @return
     */
    @RequestMapping("/ryfbEchartTemp")
    @ResponseBody
    public List<Map<String,Object>> ryfbEchartTemp( String  optionTwo){
        System.err.println(optionTwo);
        List<Map<String,Object>> result = new ArrayList<>();

        //最终返回数据结果
        /*Map<String,Object> responseMap = new HashMap<>();
        Map<String,Object> responseMap1 = new HashMap<>();*/
        if("1".equals(optionTwo)){//年度活动邀约出席
            result = demoService.queryListEchartByyycx();
           /* responseMap.put("name", "北京人");
            responseMap.put("num", 200);
            responseMap1.put("name", "上海人");
            responseMap1.put("num", 800);*/
        }else if("2".equals(optionTwo)){//年度媒体合作金额
            result = demoService.queryListEchartByhzje();
           /* responseMap.put("name", "北京媒体类型");
            responseMap.put("num", 200);
            responseMap1.put("name", "上海媒体类型");
            responseMap1.put("num", 800);*/
        }



       /* result.add(responseMap);
        result.add(responseMap1);*/

        System.err.println("resultresult"+result.toString());
        return result;
    }


    @RequestMapping("/orderrdExportExcel")
    @ResponseBody
    public void grouppExportExcel(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String ids = request.getParameter("ids");
        System.err.println("i22222222ds"+ids.toString());
        List<DemoModel> grouppList = new ArrayList<>();


        if(!"".equals(ids)){
            List<String> list= Arrays.asList(ids.split(","));
            //最终返回数据结果
            Map<String,Object> responseMap = new HashMap<>();
            responseMap.put("listParam", list);
            grouppList  =  demoService.qyeryExportRandom(responseMap);
            //选中导出
            System.err.println("选中导出");

        }else{
           //批量导出
            System.err.println("批量导出");
            grouppList  =  demoService.qyeryExportAll();
        }





        System.err.println("grouppList.size()grouppList.size()grouppList.size()grouppList.size()"+grouppList.size());

        System.err.println("toString"+grouppList.toString());

        String title = "媒体库数据统计.xlsx";
        //设置表格标题行
        String[] headers = new String[] {"序号","城市","媒体属性","媒体归属","媒体类型","平台影响力","媒体名称","姓名","性别","职务","媒体级别","友好度","擅长报道","手机号码","邮箱","身份证号码","出生年份","月份","日期","家庭情况","工作地址","家庭地址","服装号码","兴趣爱好","高层互动","6个月内报道数量","年度活动邀约出席","年度媒体合作金额","备注"};
        List<Object[]> dataList = new ArrayList<Object[]>();
        Object[] objs = null;
        for (int i = 0; i < grouppList.size(); i++) {
            objs = new Object[headers.length];
            objs[0] = 0;//设置序号,在工具类中会出现
            objs[1] = grouppList.get(i).getCs();//城市
            if("0".equals(grouppList.get(i).getMtsx())){//0是党政
                objs[2] = "党政";//媒体属性
            }else{
                objs[2] = grouppList.get(i).getMtsx();//媒体属性
            }

            objs[3] = grouppList.get(i).getMtgs();//媒体归属
            if("0".equals(grouppList.get(i).getMtlx())){//0  广播  1  短视频
                objs[4] = "广播";//媒体类型
            }else if("1".equals(grouppList.get(i).getMtlx())){
                objs[4] = "短视频";//媒体类型
            }else{
                objs[4] = grouppList.get(i).getMtlx();//媒体类型
            }

            objs[5] = grouppList.get(i).getPtyxl();//

            objs[6] = grouppList.get(i).getMtmc();//媒体名称
            objs[7] = grouppList.get(i).getXm();//姓名
            if("0".equals(grouppList.get(i).getCs())){//0是  男  1 是女
                objs[8] = "男";//性别
            }else if("1".equals(grouppList.get(i).getCs())){
                objs[8] = "女";//性别
            }else{
                objs[8] = grouppList.get(i).getCs();//性别
            }
            objs[9] = grouppList.get(i).getZw();//职务
            objs[10] = grouppList.get(i).getMtjb();//媒体级别
            objs[11] = grouppList.get(i).getYhd();//友好度
            objs[12] = grouppList.get(i).getScbd();//擅长报道


            objs[13] = grouppList.get(i).getSjhm();//手机号码

            objs[14] = grouppList.get(i).getYx();//邮箱
            objs[15] = grouppList.get(i).getSfzhm();//身份证号
            objs[16] = grouppList.get(i).getCsnyr();//出生年份

            objs[17] = grouppList.get(i).getYf();//出生月份
            objs[18] = grouppList.get(i).getRq();//日期
            objs[19] = grouppList.get(i).getJtqk();//家庭情况

            objs[20] = grouppList.get(i).getGzdz();//工作地址
            objs[21] = grouppList.get(i).getJtdz();//家庭地址
            objs[22] = grouppList.get(i).getFzhm();//服装好吗

            objs[23] = grouppList.get(i).getXqah();//
            objs[24] = grouppList.get(i).getGchd();//
            objs[25] = grouppList.get(i).getBdsl();//

            objs[26] = grouppList.get(i).getYycx();//
            objs[27] = grouppList.get(i).getHzje();//
            objs[28] = grouppList.get(i).getBz();//


            dataList.add(objs);//数据添加到excel表格
        }
        //使用流将数据导出
        OutputStream out = null;
        try {
         //防止中文乱码
            String headStr = "attachment; filename=\"" + new String( title.getBytes("gb2312"), "ISO8859-1" ) + "\"";
            response.setContentType("octets/stream");
            response.setContentType("APPLICATION/OCTET-STREAM");
            response.setHeader("Content-Disposition", headStr);
            out = response.getOutputStream();
            ExportExcelSeedBack ex = new ExportExcelSeedBack(title, headers, dataList);//没有标题
            ex.export(out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
    /**
     * 导出报表
     * @return
     */
    @RequestMapping(value = "/exportBatch")
    @ResponseBody
    public void exportBatch(HttpServletRequest request,HttpServletResponse response ) throws Exception {
      //  System.err.println("ids"+ids.toString());
       /* List<String> listcode= Arrays.asList(ids.split(","));
        //最终返回数据结果
        Map<String,Object> responseMap = new HashMap<>();
        responseMap.put("listParam", listcode);*/

      //  List<DemoModel> list =demoService.exportBatch(responseMap);
        List<DemoModel> list = new ArrayList<>();
        DemoModel dd = new DemoModel();
        dd.setCs("我的");
        DemoModel dd1 = new DemoModel();
        dd1.setCs("我1的");

        list.add(dd1);
        list.add(dd);
        System.err.println("list.size()"+list.size());
        System.err.println("list.size()"+list.toString());
        //excel标题

        //获取数据


        //excel标题
        String[] title = {"名称","性别","年龄","学校","班级"};

        //excel文件名
        String fileName = "学生信息表"+System.currentTimeMillis()+".xls";

       //sheet名
        String sheetName = "学生信息表";



        String[][] content=new String[list.size()][title.length];

        for (int i = 0; i < list.size(); i++) {
            content[i] = new String[title.length];
            DemoModel obj = list.get(i);
            content[i][0] = obj.getCs();
            content[i][1] = obj.getCs();
            content[i][2] = obj.getCs();
            content[i][3] = obj.getCs();
            content[i][4] = obj.getCs();
        }

//创建HSSFWorkbook
        HSSFWorkbook wb = ExcelUtil.getHSSFWorkbook(sheetName, title, content, null);

//响应到客户端
        try {
            this.setResponseHeader(response, fileName);
            OutputStream os = response.getOutputStream();
            wb.write(os);
            os.flush();
            os.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //发送响应流方法
    public void setResponseHeader(HttpServletResponse response, String fileName) {
        try {
            try {
                fileName = new String(fileName.getBytes(),"ISO8859-1");
            } catch (UnsupportedEncodingException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            response.setContentType("application/octet-stream;charset=ISO8859-1");
            response.setHeader("Content-Disposition", "attachment;filename="+ fileName);
            response.addHeader("Pargam", "no-cache");
            response.addHeader("Cache-Control", "no-cache");
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    /**
     * 查询bootStrop   Table的数据带搜索条件  带分页
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    public Map<String,Object> delete(String ids){
        System.err.println(ids);
        Map<String,Object> result = new HashMap<>();
        List<String> list= Arrays.asList(ids.split(","));
        for (int i = 0; i <list.size() ; i++) {
            System.err.println(list.get(i));
        }
        //最终返回数据结果
        Map<String,Object> responseMap = new HashMap<>();
        responseMap.put("listParam", list);
       int num  =  demoService.deleteByPrimaryKey(responseMap);
       if(num > 0){
           result.put("flag","删除成功");
       }else{
           result.put("flag","删除失败");
       }

        System.err.println("resultresult"+result.toString());
        return result;
    }




    //下载模板

    /**
     * 描述：下载外部案件导入模板
     *
     * @throws Exception
     */
    @RequestMapping(value = "/downloadExcel", method = RequestMethod.GET)
    @ResponseBody
    public void downloadExcel(HttpServletResponse res, HttpServletRequest req, String name) throws Exception {
        String fileName = name + ".xlsx";
        ServletOutputStream out;
        res.setContentType("multipart/form-data");
        res.setCharacterEncoding("UTF-8");
        res.setContentType("text/html");
        String filePath = getClass().getClassLoader().getResource("").getPath()+"templates\\/excelModel\\/" +fileName;
        System.out.println(filePath);
        String userAgent = req.getHeader("User-Agent");
        if (userAgent.contains("MSIE") || userAgent.contains("Trident")) {
            fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
        } else {
            // 非IE浏览器的处理：
            fileName = new String((fileName).getBytes("UTF-8"), "ISO-8859-1");
        }
        filePath = URLDecoder.decode(filePath, "UTF-8");
        res.setHeader("Content-Disposition", "attachment;fileName=" + fileName);
        FileInputStream inputStream = new FileInputStream(filePath);
        out = res.getOutputStream();
        int b = 0;
        byte[] buffer = new byte[1024];
        while ((b = inputStream.read(buffer)) != -1) {
            // 4.写到输出流(out)中
            out.write(buffer, 0, b);
        }
        inputStream.close();
        if (out != null) {
            out.flush();
            out.close();
        }
    }


    @RequestMapping("insertExcel")
    @ResponseBody
    public Map<String, Object> importExcel(@RequestParam("file") MultipartFile file){

        List<DemoModel> list  = new ArrayList<DemoModel>();//需要插入的数据

        Map<String, Object> mapRes = new HashMap<String,Object>();
        Map<String, Object> mapRes1 = new HashMap<String,Object>();


        System.err.println("fffffffile:"+file);
        String fileName = file.getOriginalFilename();
        System.err.println("ffffffffffffileName:"+fileName);

        ReadExcel readExcel = new ReadExcel();
        mapRes1 = readExcel.getExcelInfo(file);//所有读取的数据
        System.err.println(mapRes1.size());
        System.err.println(mapRes1.toString());
        if((boolean)(mapRes1.get("validateFlg"))){
            list = (List<DemoModel>)mapRes1.get("msg");
            if(list.size()> 0){
                for (int i = 0; i < list.size(); i++) {
                    System.err.println("list.get(i)list.get(i)list.get(i)"+list.get(i).toString());
                    DemoModel medoTemp = list.get(i);
                    medoTemp.setCsnf(medoTemp.getCsnyr()+"-"+medoTemp.getYf()+"-"+medoTemp.getRq());
                    if("党政".equals(medoTemp.getMtsx())){
                        medoTemp.setMtsx("0");
                    }
                    if("广播".equals(medoTemp.getMtlx())){
                        medoTemp.setMtlx("0");
                    }else if("短视频".equals(medoTemp.getMtlx())){
                        medoTemp.setMtlx("1");
                    }
                    if("男".equals(medoTemp.getXb())){
                        medoTemp.setXb("0");
                    }else if("女".equals(medoTemp.getXb())){
                        medoTemp.setXb("1");
                    }

                    int  num   = demoService.insertSelective(list.get(i));
                }
                mapRes.put("flg", true);
                mapRes.put("reason", "上传excel成功!");
            }else{
                mapRes.put("flg", false);
                mapRes.put("reason", "插入数据库成功!");
            }
            //mapRes = studentVOService.insertMsgByExcel(list);
        }else{
            mapRes.put("flg", false);
            mapRes.put("reason", "上传excel格式不正确!");
        }
        JSONArray jsonArrayrr = JSONArray.fromObject(list);
        System.out.println(jsonArrayrr.toString()+"==========;;;;");
        return mapRes;
    }


























    /**
     * 接口测试
     * ResponseBody 如果返回的是对象 会自动转为json字符串，如果返回的是String 则返回该字符串
     * @return JSON 字符串
     */
  /* /@GetMapping("/demos" )
    @ResponseBody
    public List<DemoModel> allDemo() {
        return service.selectAll();
    }*/



    // @ResponseBody 如果返回的是对象 会自动转为json字符串，如果返回的是String 则返回该字符串


    //下载模板
    @RequestMapping(value = "/upModelAndDownLoad",method = RequestMethod.GET)
    public void downloadExcel(HttpServletResponse response, HttpServletRequest request) throws Exception {
        //下载模板，调用公用方法，适用windows和linux，templete文件夹下文件的下载
       // PublicExportExcel.downloadTemplate(response,request,"model.xlsx");// 调用工具类的实现方法

    }

}
