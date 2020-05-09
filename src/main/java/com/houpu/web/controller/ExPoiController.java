package com.houpu.web.controller;

import com.houpu.entity.Provider;
import com.houpu.entity.Result;
import com.houpu.entity.User;
import com.houpu.service.ProviderService;
import com.houpu.utils.DownloadUtil;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/poi")
public class ExPoiController {

    @Autowired
    private ProviderService providerService;

    //导出excel
    @RequestMapping("/printExcel")
    public void printExcel(HttpServletResponse response) throws Exception{

        //查询所有数据
        List<Provider> list = providerService.findAll();

        //获取工作簿模板
        XSSFWorkbook workbook = new XSSFWorkbook("G:/tOUTPRODUCT.xlsx");

        //获取sheet
        XSSFSheet sheet = workbook.getSheetAt(0);

        //获取行
        Integer index = 0;

        XSSFRow row = sheet.getRow(index++);

        XSSFCell cell = row.getCell(0);

        //表头
        row = sheet.getRow(index++);
        String[] headerNames={"供应商编号","供应商名称","供应商描述","联系 人","联系电话","联系地址","传真","创建日期"};
        //循环数组，将标题赋值到小标题上
        for (int i=0;i<headerNames.length;i++){
            //每一个单元格
            cell =  row.getCell(i);
            cell.setCellValue(headerNames[i]);
        }

        row = sheet.getRow(index);
        CellStyle[] styles = new CellStyle[row.getLastCellNum()];
        for (int i=0;i<styles.length;i++){
            styles[i] = row.getCell(i).getCellStyle();
        }
        //导入数据
        for (Provider provider:list){
            row = sheet.createRow(index++);
            //编号
            cell = row.createCell(0);
            cell.setCellValue(provider.getProCode());
            cell.setCellStyle(styles[0]);
            //名称
            cell = row.createCell(1);
            cell.setCellValue(provider.getProName());
            cell.setCellStyle(styles[1]);
            //描述
            cell = row.createCell(2);
            cell.setCellValue(provider.getProDesc());
            cell.setCellStyle(styles[2]);
            //联系人
            cell = row.createCell(3);
            cell.setCellValue(provider.getProContact());
            cell.setCellStyle(styles[3]);
            //电话
            cell = row.createCell(4);
            cell.setCellValue(provider.getProPhone());
            cell.setCellStyle(styles[4]);
            //地址
            cell = row.createCell(5);
            cell.setCellValue(provider.getProAddress());
            cell.setCellStyle(styles[5]);
            //传真
            cell = row.createCell(6);
            cell.setCellValue(provider.getProFax());
            cell.setCellStyle(styles[6]);
            //日期
            cell = row.createCell(7);
            cell.setCellValue(provider.getCreationDate());
            cell.setCellStyle(styles[7]);
        }

        //写出数据  文件下载
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        workbook.write(byteArrayOutputStream);
        DownloadUtil.download(byteArrayOutputStream,response,"供应商列表.xlsx");
    }

    //导入excel
    @RequestMapping("/importExcel")
    @ResponseBody
    public Result importFile(@RequestParam("file") MultipartFile file, HttpSession session) throws IOException {
        //获取上传文件数据
        InputStream inputStream = file.getInputStream();
        //工作簿对象
        XSSFWorkbook workbook = new XSSFWorkbook(inputStream);
        //表
        XSSFSheet sheetAt = workbook.getSheetAt(0);
        //行
        int lastRowNum = sheetAt.getLastRowNum();

        //通过第一行获得最后一列
        Row row = sheetAt.getRow(1);

        short lastCellNum = row.getLastCellNum();
        Cell cell = null;
        List<Provider> providerList = new ArrayList<>();

        Object[] excelData = new Object[8];

        for (int i=2;i<=lastRowNum;i++){
            //获取行
            row = sheetAt.getRow(i);
            //获得每一个单元格
            for (int j=0;j<lastCellNum;j++){
                cell = row.getCell(j);
                Object cellValue = getCellValue(cell);
                excelData[j] = cellValue;
            }

            //将数组转换成对象
            Provider provider = new Provider(excelData);
            //获取当前用户
            User user = (User)session.getAttribute("user");
            provider.setCreatedBy(user.getId());
            providerList.add(provider);
        }

        //批量保存
        providerService.addList(providerList);
        Result result = new Result();
        result.setCode(0);
        result.setMsg("ok");

        return result;
    }

    //int firstRow, int lastRow, int firstCol, int lastCol
    //sheet.addMergedRegion(new CellRangeAddress(0 , 0 , 1 , 8));
    //大标题的样式
    public CellStyle bigTitle(Workbook wb){
        CellStyle style = wb.createCellStyle();
        Font font = wb.createFont();
        font.setFontName("宋体");
        font.setFontHeightInPoints((short)16);
        font.setBold(true);//字体加粗
        style.setFont(font);
        style.setAlignment(HorizontalAlignment.CENTER);				//横向居中
        style.setVerticalAlignment(VerticalAlignment.CENTER);		//纵向居中
        return style;
    }

    //小标题的样式
    public CellStyle title(Workbook wb){
        CellStyle style = wb.createCellStyle();
        Font font = wb.createFont();
        font.setFontName("黑体");
        font.setFontHeightInPoints((short)12);
        style.setFont(font);
        style.setAlignment(HorizontalAlignment.CENTER);				//横向居中
        style.setVerticalAlignment(VerticalAlignment.CENTER);		//纵向居中
        style.setBorderTop(BorderStyle.THIN);						//上细线
        style.setBorderBottom(BorderStyle.THIN);					//下细线
        style.setBorderLeft(BorderStyle.THIN);						//左细线
        style.setBorderRight(BorderStyle.THIN);						//右细线
        return style;
    }

    //文字样式
    public CellStyle text(Workbook wb){
        CellStyle style = wb.createCellStyle();
        Font font = wb.createFont();
        font.setFontName("Times New Roman");
        font.setFontHeightInPoints((short)10);

        style.setFont(font);

        style.setAlignment(HorizontalAlignment.LEFT);				//横向居左
        style.setVerticalAlignment(VerticalAlignment.CENTER);		//纵向居中
        style.setBorderTop(BorderStyle.THIN);						//上细线
        style.setBorderBottom(BorderStyle.THIN);					//下细线
        style.setBorderLeft(BorderStyle.THIN);						//左细线
        style.setBorderRight(BorderStyle.THIN);						//右细线

        return style;
    }

    public static Object getCellValue(Cell cell){
        Object object = null;
        CellType cellType = cell.getCellType();
        switch (cellType){
            case STRING://字符串
                object = cell.getStringCellValue();
                break;
            case NUMERIC://数字
                if (DateUtil.isCellDateFormatted(cell)){
                    object = cell.getDateCellValue();
                }else {
                    object = cell.getNumericCellValue();
                }
                break;
            case BOOLEAN://布尔
                object = cell.getBooleanCellValue();
                break;
            default:
                break;
        }
        return object;
    }



    //    //百万级导出excel
//    @RequestMapping("/printExcel")
//    public void printExcel(HttpServletResponse response) throws Exception{
//
//        //查询所有数据
//        List<Provider> list = providerService.findAll();
//
//        SXSSFWorkbook workbook = new SXSSFWorkbook();
//        //获取sheet
//        Sheet sheet = workbook.createSheet("供应商列表");
//
//        //获取行
//        Integer index = 0;
//
//        Row row = sheet.createRow(index++);
//        sheet.addMergedRegion(new CellRangeAddress(0,0,0,7));
//        Cell cell = row.createCell(0);
//        cell.setCellValue("供应商列表信息");
//        cell.setCellStyle(bigTitle(workbook));
//
//        //表头
//        row = sheet.createRow(index++);
//        String[] headerNames={"供应商编号","供应商名称","供应商描述","联系 人","联系电话","联系地址","传真","创建日期"};
//        //循环数组，将标题赋值到小标题上
//        for (int i=0;i<headerNames.length;i++){
//            //每一个单元格
//            cell =  row.createCell(i);
//            cell.setCellStyle(text(workbook));
//            cell.setCellValue(headerNames[i]);
//            sheet.setColumnWidth(i,20*256);
//        }
//
//        //导入数据
//        for (Provider provider:list){
//            for (int i = 0; i <10000; i++) {
//                row = sheet.createRow(index++);
//                //编号
//                cell = row.createCell(0);
//                cell.setCellValue(provider.getProCode());
//                //名称
//                cell = row.createCell(1);
//                cell.setCellValue(provider.getProName());
//                //描述
//                cell = row.createCell(2);
//                cell.setCellValue(provider.getProDesc());
//                //联系人
//                cell = row.createCell(3);
//                cell.setCellValue(provider.getProContact());
//                //电话
//                cell = row.createCell(4);
//                cell.setCellValue(provider.getProPhone());
//                //地址
//                cell = row.createCell(5);
//                cell.setCellValue(provider.getProAddress());
//                //传真
//                cell = row.createCell(6);
//                cell.setCellValue(provider.getProFax());
//                //日期
//                cell = row.createCell(7);
//                cell.setCellValue(provider.getCreationDate());
//            }
//        }
//
//        //写出数据  文件下载
//        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
//        workbook.write(byteArrayOutputStream);
//        DownloadUtil.download(byteArrayOutputStream,response,"供应商列表.xlsx");
//    }
}
