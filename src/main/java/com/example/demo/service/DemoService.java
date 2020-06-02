package com.example.demo.service;

import com.example.demo.model.DemoModel;

import java.util.List;
import java.util.Map;


public  interface DemoService {

    public List<DemoModel >  queryTableList(Map<String,Object> queryMap, DemoModel demoModel);
     int  queryCount(Map<String,Object> map);
    int deleteByPrimaryKey(Map<String,Object> map);

    int insertSelective(DemoModel demoModel);
    int updateByPrimaryKeySelective(DemoModel demoModel);

    List<Map<String,Object>> queryListEchartBycs();
    List<Map<String,Object>> queryListEchartBymtlx();
    List<Map<String,Object>> queryListEchartBymtsx();
    List<Map<String,Object>> queryListEchartByyycx();
    List<Map<String,Object>> queryListEchartByhzje();


    List<DemoModel > exportBatch (Map<String,Object> map);



    List<DemoModel > qyeryExportRandom (Map<String,Object> map);
    List<DemoModel > qyeryExportAll ();
}

