package com.example.demo.mapper;

import com.example.demo.model.DemoModel;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;


public interface DemoMapper {

    List<DemoModel> queryTableList(Map<String, Object> queryMap);

    int deleteByPrimaryKey (Map<String, Object> map);;

    int insertSelective (DemoModel demoModel);
    int updateByPrimaryKeySelective (DemoModel demoModel);
    int  queryCount(Map<String,Object> map);


    List<Map<String,Object>> queryListEchartBycs();
    List<Map<String,Object>> queryListEchartBymtlx();
    List<Map<String,Object>> queryListEchartBymtsx();
    List<Map<String,Object>> queryListEchartByyycx();
    List<Map<String,Object>> queryListEchartByhzje();

    List<DemoModel> exportBatch(Map<String, Object> map);



    List<DemoModel > qyeryExportRandom (Map<String,Object> map);
    List<DemoModel > qyeryExportAll ();

}
