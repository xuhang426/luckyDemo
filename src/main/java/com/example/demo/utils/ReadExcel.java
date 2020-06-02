package com.example.demo.utils;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.example.demo.model.DemoModel;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author hewangtong
 *
 */
public class ReadExcel {
    // 总行数
    private int totalRows = 0;
    // 总条数
    private int totalCells = 0;
    // 错误信息接收器
    private String errorMsg;

    // 构造方法
    public ReadExcel() {
    }

    // 获取总行数
    public int getTotalRows() {
        return totalRows;
    }

    // 获取总列数
    public int getTotalCells() {
        return totalCells;
    }

    // 获取错误信息
    public String getErrorInfo() {
        return errorMsg;
    }

    /**
     * 读EXCEL文件，获取信息集合
     *
     * @param
     * @return
     */
    public Map<String, Object> getExcelInfo(MultipartFile mFile) {
    	Map<String, Object> mapRes = new HashMap<String,Object>();
        String fileName = mFile.getOriginalFilename();// 获取文件名
//        List<Map<String, Object>> userList = new LinkedList<Map<String, Object>>();
        try {
            if (!validateExcel(fileName)) {// 验证文件名是否合格
                return null;//不合格
            }
            boolean isExcel2003 = true;// 根据文件名判断文件是2003版本还是2007版本
            if (isExcel2007(fileName)) {
                isExcel2003 = false;
            }
            mapRes =  createExcel(mFile.getInputStream(), isExcel2003);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mapRes;
    }

    /**
     * 根据excel里面的内容读取客户信息
     *
     * @param is      输入流
     * @param isExcel2003   excel是2003还是2007版本
     * @return
     * @throws IOException
     */
    public Map<String, Object> createExcel(InputStream is, boolean isExcel2003) {
    	Map<String, Object> mapRes = new HashMap<String,Object>();
    	List<DemoModel>  listMsg = new ArrayList<DemoModel>();
        try {
            Workbook wb = null;
            if (isExcel2003) {// 当excel是2003时,创建excel2003
                wb = new HSSFWorkbook(is);
            } else {// 当excel是2007时,创建excel2007
                wb = new XSSFWorkbook(is);
            }

            int dataFlg =  excelDatavalidate(wb);
            if(dataFlg>0){
            	mapRes.put("validateFlg", true);
            }else{
            	mapRes.put("validateFlg", false);
            }
            listMsg =  readExcelValue(wb);// 读取Excel里面客户的信息
            mapRes.put("msg", listMsg);

        } catch (IOException e) {
            e.printStackTrace();
        }
        return mapRes;
    }

    /**
     * 读取Excel里面客户的信息
     *
     * @param wb
     * @return
     */
    private List<DemoModel> readExcelValue(Workbook wb) {
        // 得到第一个shell
        Sheet sheet = wb.getSheetAt(0);
        // 得到Excel的行数
        System.err.println("excel=============总行数:"+sheet.getPhysicalNumberOfRows());
        this.totalRows = sheet.getPhysicalNumberOfRows();
        // 得到Excel的列数(前提是有行数)
        if (totalRows > 1 && sheet.getRow(0) != null) {
        	System.err.println("excel=============总列数:"+sheet.getRow(0).getPhysicalNumberOfCells());
            this.totalCells = sheet.getRow(0).getPhysicalNumberOfCells();
        }else{
        }
        List<DemoModel> userList = new ArrayList<DemoModel>();

        // 循环Excel行数
        for (int r = 2; r < totalRows; r++) {
            Row row = sheet.getRow(r);
            if (row == null) {
                continue;
            }
            // 循环Excel的列
           // Map<String, Object> map = new HashMap<String, Object>();
            DemoModel   demo = new DemoModel();
            for (int c = 0; c < this.totalCells; c++) {
                Cell cell = row.getCell(c);
                System.err.println(cell);
               if (null != cell) {
                    if (c == 0) {
                        // 如果是纯数字,比如你写的是25,cell.getNumericCellValue()获得是25.0,通过截取字符串去掉.0获得25
                      //  if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
                       //     String name = String.valueOf(cell.getNumericCellValue());
                      //      map.put("name", name.substring(0, name.length() - 2 > 0 ? name.length() - 2 : 1));// 名称
                      //  } else {
                        //    map.put("name", cell.getStringCellValue());// 名称
                       // }
                        demo.setCs(cell.getStringCellValue());// 城市
                    } else if (c == 1) {

                        demo.setMtsx(cell.getStringCellValue());// 媒体属性
                    } /*else if (c == 2) {//年份
                    	if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
                            String name = String.valueOf(cell.getNumericCellValue());
                            map.put("extStr3", name.substring(0, name.length() - 2 > 0 ? name.length() - 2 : 1));
                        } else {
                            map.put("extStr3", cell.getStringCellValue());
                        }
                    }*/else if (c == 2) {

                        demo.setMtgs( cell.getStringCellValue());// 媒体归属

                    }else if (c == 3) {

                        demo.setMtlx( cell.getStringCellValue());// 媒体类型
                    }else if (c == 4) {//平台影响力
                        demo.setPtyxl( cell.getStringCellValue());
                    }else if (c == 5) {//媒体名称
                        demo.setMtmc(cell.getStringCellValue());
                    }else if (c == 6) {//姓名
                        demo.setXm( cell.getStringCellValue());
                    }else if (c == 7) {//性别

                        demo.setXb(cell.getStringCellValue());
                    }else if (c == 8) {//职务
                        demo.setZw(cell.getStringCellValue());
                    }else if (c == 9) {//媒体级别
                        demo.setMtjb(cell.getStringCellValue());
                    } else if (c == 10) {//友好度
                        demo.setYhd( cell.getStringCellValue());
                    }else if (c == 11) {//擅长报道
                        demo.setScbd( cell.getStringCellValue());
                    }else if (c == 12) {//手机号码
                        demo.setSjhm( cell.getStringCellValue());
                    }else if (c == 13) {//邮箱
                        demo.setYx( cell.getStringCellValue());
                    }else if (c == 14) {//身份证号码
                        //demo.setsfzhm( String.valueOf(cell.getNumericCellValue()));
                        demo.setSfzhm( cell.getStringCellValue());
                    }else if (c == 15) {//出生年份
                        if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
                            String name = String.valueOf(cell.getNumericCellValue());
                            demo.setCsnyr( name.substring(0, name.length() - 2 > 0 ? name.length() - 2 : 1));
                        } else {
                            demo.setCsnyr( cell.getStringCellValue());
                        }


                        // demo.setcsnf( cell.getStringCellValue());
                    }else if (c == 16) {//月份
                        if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
                            String name = String.valueOf(cell.getNumericCellValue());
                            demo.setYf( name.substring(0, name.length() - 2 > 0 ? name.length() - 2 : 1));
                        } else {
                            demo.setYf( cell.getStringCellValue());
                        }
                        //map.put("yf( cell.getStringCellValue());
                    }else if (c == 17) {//日期
                        if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
                            String name = String.valueOf(cell.getNumericCellValue());
                            demo.setRq( name.substring(0, name.length() - 2 > 0 ? name.length() - 2 : 1));
                        } else {
                            demo.setRq( cell.getStringCellValue());
                        }
                        //map.put("rq( cell.getStringCellValue());
                    }else if (c == 18) {//家庭那个情况
                        demo.setJtqk( cell.getStringCellValue());
                    }else if (c == 19) {//工作地址
                        demo.setGzdz( cell.getStringCellValue());
                    }else if (c == 20) {//家庭地址
                        demo.setJtdz( cell.getStringCellValue());
                    }else if (c == 21) {//服装号码
                        demo.setFzhm( cell.getStringCellValue());
                    }else if (c == 22) {//兴趣爱好
                        demo.setXqah( cell.getStringCellValue());
                    }else if (c == 23) {//高层互动
                        demo.setGchd( cell.getStringCellValue());
                    }else if (c == 24) {//6个月内报道数量
                        if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
                            String name = String.valueOf(cell.getNumericCellValue());
                            demo.setBdsl( name.substring(0, name.length() - 2 > 0 ? name.length() - 2 : 1));
                        } else {
                            demo.setBdsl( cell.getStringCellValue());
                        }
                        //demo.setbdsl( cell.getStringCellValue());
                    }else if (c == 25) {//年度活动邀约出席
                        if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
                            String name = String.valueOf(cell.getNumericCellValue());
                            demo.setYycx( name.substring(0, name.length() - 2 > 0 ? name.length() - 2 : 1));
                        } else {
                            demo.setYycx( cell.getStringCellValue());
                        }
                        //demo.setyycx( cell.getStringCellValue());
                    }else if (c == 26) {//年度媒体合作金额
                        if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
                            demo.setHzje(  Double.parseDouble(   String.valueOf(cell.getNumericCellValue())));
                        } else {
                            demo.setHzje(  Double.parseDouble(cell.getStringCellValue())  );
                        }
                    }else if (c == 27) {//备注
                        demo.setBz( cell.getStringCellValue());
                    }
                }else{//cell为空

                }
            }
            // 添加到list
            userList.add(demo);
        }
        return userList;
    }

    /**
     * 验证EXCEL文件
     *
     * @param filePath
     * @return
     */
    public boolean validateExcel(String filePath) {
        if (filePath == null || !(isExcel2003(filePath) || isExcel2007(filePath))) {
            errorMsg = "文件名不是excel格式";
            return false;
        }
        return true;
    }

    // @描述：是否是2003的excel，返回true是2003
    public static boolean isExcel2003(String filePath) {
        return filePath.matches("^.+\\.(?i)(xls)$");
    }

    // @描述：是否是2007的excel，返回true是2007
    public static boolean isExcel2007(String filePath) {
        return filePath.matches("^.+\\.(?i)(xlsx)$");
    }

    public int excelDatavalidate(Workbook wb){
    	 // 得到第一个shell
        Sheet sheet = wb.getSheetAt(0);
        int totalRowNum = sheet.getPhysicalNumberOfRows();
        if(totalRowNum>1){
        	int totalColumnNum = sheet.getRow(0).getPhysicalNumberOfCells();
        	if(totalColumnNum<13){
        		return 0;
        	}else{
        		return 1;
        	}
        }else{
        	return 0;

        }
    }



    private static String getRealNumOfScientificNotation(String doubleStr) {
        int indexOfE = doubleStr.indexOf('E');
        int indexOfPoint = doubleStr.indexOf('.');
        // 整数部分
        BigInteger zs = new BigInteger(doubleStr.substring(0, indexOfPoint));
        // 小数部分
        BigInteger xs = new BigInteger(doubleStr.substring(indexOfPoint
                + BigInteger.ONE.intValue(), indexOfE));
        // 指数
        int pow = Integer.valueOf(doubleStr.substring(indexOfE
                + BigInteger.ONE.intValue()));
        StringBuffer buffer = new StringBuffer();
        // e.g. 1.23E-5
        if (pow < 0) {
            for (int i = 0; i < -pow; i++) {
                buffer.append(0);
            }
            buffer.insert(BigInteger.ONE.intValue(), ".");
            buffer.append(zs.toString()).append(xs.toString());
            doubleStr = buffer.toString();
        } else {
            int xsLen = xs.toByteArray().length;
            int needFill0 = pow - xsLen;
            if (needFill0 < 0) {
                // e.g. 1.234E2
                buffer.append(xs);
                buffer.insert(pow, ".");
                buffer.insert(0, zs);
                doubleStr = buffer.toString();
            } else {
                // e.g. 1.234E6 or 1.234E3
                for (int i = 0; i < needFill0; i++) {
                    buffer.append(0);
                }
                buffer.insert(0, xs);
                buffer.insert(0, zs);
                doubleStr = buffer.toString();
            }
        }
        return doubleStr;
    }

}
