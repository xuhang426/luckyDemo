package com.example.demo.service.impl;

import com.example.demo.mapper.DemoMapper;
import com.example.demo.model.DemoModel;
import com.example.demo.service.DemoService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;

@Service
public class DemoServiceImpl  implements DemoService {

    @Resource
    private final DemoMapper demomapper;

    public DemoServiceImpl(DemoMapper demomapper) {
        this.demomapper = demomapper;
    }

    @Override
    public List<DemoModel> queryTableList(Map<String, Object> queryMap, DemoModel demoModel) {


        return demomapper.queryTableList(queryMap);
    }

    @Override
    public int queryCount(Map<String, Object> map) {
        return  demomapper.queryCount(map);
    }

    @Override
    public int deleteByPrimaryKey(Map<String, Object> map) {
        return  demomapper.deleteByPrimaryKey(map);
    }

    @Override
    public int insertSelective(DemoModel demoModel) {
        return demomapper.insertSelective(demoModel);
    }

    @Override
    public int updateByPrimaryKeySelective(DemoModel demoModel) {
        return demomapper.updateByPrimaryKeySelective(demoModel);
    }

    @Override
    public List<Map<String, Object>> queryListEchartBycs() {
        return demomapper.queryListEchartBycs();
    }

    @Override
    public List<Map<String, Object>> queryListEchartBymtlx() {
        return demomapper.queryListEchartBymtlx();    }

    @Override
    public List<Map<String, Object>> queryListEchartBymtsx() {
        return demomapper.queryListEchartBymtsx();    }

    @Override
    public List<Map<String, Object>> queryListEchartByyycx() {
        return demomapper.queryListEchartByyycx();    }

    @Override
    public List<Map<String, Object>> queryListEchartByhzje() {
        return demomapper.queryListEchartByhzje();    }

    @Override
    public List<DemoModel> exportBatch(Map<String, Object> map) {
        return  demomapper.exportBatch(map);
    }

    @Override
    public List<DemoModel> qyeryExportRandom(Map<String, Object> map) {
        return  demomapper.qyeryExportRandom(map);    }

    @Override
    public List<DemoModel> qyeryExportAll() {
        return  demomapper.qyeryExportAll();    }



















 /*   public boolean insert(DemoModel model) {
        return dao.insert(model) > 0;
    }

    public DemoModel select(int id) {
        return dao.select(id);
    }

    public List<DemoModel> selectAll() {
        return dao.selectAll();
    }

    public boolean updateValue(DemoModel model) {
        return dao.updateValue(model) > 0;
    }

    public boolean delete(Integer id) {
        return dao.delete(id) > 0;
    }

    public int selectCount() {
        return dao.count();
    }*/
}
