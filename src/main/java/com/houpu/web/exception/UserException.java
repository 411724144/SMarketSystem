package com.houpu.web.exception;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
@Component
public class UserException implements HandlerExceptionResolver {
    @Override
    public ModelAndView resolveException(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) {

        //获取错误位置
        StackTraceElement stackTrace = e.getStackTrace()[0];
        //获取错误信息
        String message = e.getMessage();
        //获取错误的时间
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh-mm-ss");
        String format = simpleDateFormat.format(new Date());

        //以缓冲流的存入到日志文件中去
        try {
            BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter("G:/error.log"));

            bufferedWriter.write(stackTrace+";"+message+";"+format);
            bufferedWriter.newLine();
            bufferedWriter.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }


        //异常试图跳转
        ModelAndView modelAndView = new ModelAndView();
       modelAndView.setViewName("error");
        return modelAndView;
    }
}
