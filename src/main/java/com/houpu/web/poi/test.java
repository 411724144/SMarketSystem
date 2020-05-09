package com.houpu.web.poi;

import org.junit.Test;

public class test {

    @Test
    public void testImport() throws Exception {
        ExcelParse excelParse = new ExcelParse();
        excelParse.parse("G:/供应商列表 (5).xlsx");
    }
}
