package com.example.demo.utils;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class WriteExcel {
    private static final String EXCEL_XLS = "xls";
    private static final String EXCEL_XLSX = "xlsx";
    
    public static byte[] writeExcel(Map<String,Object> mapParam, int cloumnCount,String finalXlsxPath) throws IllegalAccessException, InvocationTargetException, NoSuchMethodException, FileNotFoundException {
    	
    	BufferedInputStream in = null;
    	BufferedInputStream bis = null;
    	byte[] buffer = new byte[2048];
    	ByteArrayOutputStream out1 = null;
    	in = new BufferedInputStream(new FileInputStream(finalXlsxPath), buffer.length);
    	bis = new BufferedInputStream(in);
        try {
            // 获取总列数
            int columnNumCount = cloumnCount;
            // 读取Excel文档
            File finalXlsxFile = new File(finalXlsxPath);
            Workbook workBook = getWorkbok(finalXlsxFile,bis);
            // sheet 对应一个工作页
            Sheet sheet = workBook.getSheetAt(1);
            /**
             * 删除原有数据，除了属性列
             */
            int rowNumber = sheet.getLastRowNum();    // 第一行从0开始算
            System.out.println("原始数据总行数，除属性列：" + rowNumber);
            for (int i = 0; i < rowNumber; i++) {
                Row row = sheet.getRow(i);
                sheet.removeRow(row);
            }
            // 创建文件输出流，输出电子表格：这个必须有，否则你在sheet上做的任何操作都不会有效
//            out =  new FileOutputStream(finalXlsxPath);
//            workBook.write(out);
            /**
             * 往Excel中写新数据
             */
            int rowNumber2 = sheet.getLastRowNum(); 
            System.out.println("清空后的row数量，除属性列：" + rowNumber2);
            
            
        	
        	List<Map<String, Object>> listTemp_zy = (List<Map<String, Object>>)mapParam.get("zy");
        	List<Map<String, Object>> listTemp_xy = (List<Map<String, Object>>)mapParam.get("xy");
        	
        	int xySize = listTemp_xy.size();
        	int zySize = listTemp_zy.size();
        	
    		System.err.println("专业字典行数：：：：：："+zySize);
    		for(int m=0;m<listTemp_zy.size();m++){
        		Map<String, Object> mapTData = listTemp_zy.get(m);
        		if(sheet.getLastRowNum()<(m+1)){
        			Row row = sheet.createRow(m);
        			Cell first = row.createCell(0);
        			first.setCellValue((String)mapTData.get("collegetree_name"));
        		}else{
        			Row row = sheet.getRow(m);
        			Cell first = row.createCell(0);
        			first.setCellValue((String)mapTData.get("collegetree_name"));
        			
        		}
        	}
    		System.err.println("学院字典行数：：：：：："+xySize);
    		for(int n=0;n<listTemp_xy.size();n++){
        		Map<String, Object> mapTData = listTemp_xy.get(n);
        		if(sheet.getLastRowNum()<(n+1)){
        			System.out.println("=====creat:"+(String)mapTData.get("collegetree_name"));
        			Row row = sheet.createRow(n);
        			Cell first = row.createCell(2);
        			first.setCellValue((String)mapTData.get("collegetree_name"));
        		}else{
        			System.out.println("====="+(String)mapTData.get("collegetree_name"));
        			Row row = sheet.getRow(n);
        			Cell first = row.createCell(2);
        			first.setCellValue((String)mapTData.get("collegetree_name"));
        			
        		}
        	}
            	
            	
            
            
            
            
            /*for (int j = 0; j < dataList.size(); j++) {
                // 创建一行：从第二行开始，跳过属性列
                Row row = sheet.createRow(j);
                // 得到要插入的每一条记录
                Map<String,Object> dataMap = dataList.get(j);
                String name = dataMap.get("BankName").toString();
                String address = dataMap.get("Addr").toString();
                String phone = dataMap.get("Phone").toString();
                for (int k = 0; k <= columnNumCount; k++) {
                // 在一行内循环
                Cell first = row.createCell(0);
                first.setCellValue(name);
        
                Cell second = row.createCell(1);
                second.setCellValue(address);
        
                Cell third = row.createCell(2);
                third.setCellValue(phone);
                }
            }*/
            // 创建文件输出流，准备输出电子表格：这个必须有，否则你在sheet上做的任何操作都不会有效
//            out =  new FileOutputStream(finalXlsxPath);
//            workBook.write(out);
            int rowNumber3 = sheet.getLastRowNum(); 
            System.out.println("最终的数据行数：" + rowNumber3);
            out1 = new ByteArrayOutputStream();
            workBook.write(out1);
            workBook.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try {
                out1.flush();
                out1.close();
                bis.close();
                in.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        System.out.println("数据导出成功");
        return out1.toByteArray();
    }

    /**
     * 判断Excel的版本,获取Workbook
     * @param in
     * @param filename
     * @return
     * @throws IOException
     */
    public static Workbook getWorkbok(File file ,BufferedInputStream bis) throws IOException{
        Workbook wb = null;
        if(file.getName().endsWith(EXCEL_XLS)){     //Excel&nbsp;2003
            wb = new HSSFWorkbook(bis);
        }else if(file.getName().endsWith(EXCEL_XLSX)){    // Excel 2007/2010
            wb = new XSSFWorkbook(bis);
        }
        return wb;
    }
}