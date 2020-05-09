package com.houpu.web.poi;

import com.houpu.entity.Provider;
import org.apache.poi.xssf.eventusermodel.XSSFSheetXMLHandler;
import org.apache.poi.xssf.usermodel.XSSFComment;

import java.util.Date;

public class SheetHandler implements XSSFSheetXMLHandler.SheetContentsHandler {
    private Provider provider;

    @Override
    public void startRow(int i) {
        if (i>=2){
            provider = new Provider();
        }
    }

    @Override
    public void endRow(int i) {
        System.out.println(provider);
    }

    @Override
    public void cell(String columnName, String columnValue, XSSFComment xssfComment) {
        if (provider==null){
            return;
        }
        String prefix = columnName.substring(0, 1);
        switch (prefix){
            case "A":
                provider.setProCode(columnValue);
                break;
            case "B":
                provider.setProName(columnValue);
                break;
            case "C":
                provider.setProDesc(columnValue);
                break;
            case "D":
                provider.setProContact(columnValue);
                break;
            case "E":
                provider.setProPhone(columnValue);
                break;
            case "F":
                provider.setProAddress(columnValue);
                break;
            case "G":
                provider.setProFax(columnValue);
                break;
            case "H":
                provider.setCreationDate(new Date(columnValue));
                break;
            default:
                break;
        }
    }

    @Override
    public void endSheet() {
        System.out.println("处理结束！");
    }
}
