package com.example.demo;

import com.example.demo.model.DemoModel;
import com.example.demo.service.DemoService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
class DemoApplicationTests {
    @Autowired
    private DemoService service;
    @Test
    void contextLoads() {



//        DemoModel model = new DemoModel();
//        model.setKey("测试key1");
//        model.setValue("测试value1");
//
//        // 记录数
//        List<DemoModel> all = service.selectAll();
//        int size = all.size();
//        System.err.println("size+++++"+size);
        // insert
//        boolean result = service.insert(model);
//        Assert.assertTrue(result);
//
//        // select
//        DemoModel selectModel = service.select(model.getId());
//        Assert.assertNotNull(selectModel);
//
//        // selectAll
//        all = service.selectAll();
//        Assert.assertEquals(size + 1, all.size());
//
//        // updateValue
//        selectModel.setValue("测试更改value1");
//        result = service.updateValue(selectModel);
//        Assert.assertTrue(result);
//
//        // delete
//        result = service.delete(selectModel.getId());
//        Assert.assertTrue(result);
    }

}
