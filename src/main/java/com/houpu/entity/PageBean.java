package com.houpu.entity;

import java.util.List;

public class PageBean<E> {
    //记录总条数
    private Integer totalCount;
    //总页数
    private Integer totalPage;
    //list结果集
    private List<E> list;
    //当前页
    private Integer pageNum;
    //每页个数  -- 默认为5
    private Integer pageSize;
    //起始页
    private Integer begin;
    //终止页
    private Integer end;
    //分页按钮显示数
    private Integer buttonCount = 10;

    //计算begin和end
    private void math(){
        if (this.totalPage<=this.buttonCount){
            this.begin =1;
            this.end = this.totalPage;
        }else {
            //判断按钮奇偶
            int pre = 0;
            int nex = 0;
            //偶
            if (this.buttonCount%2==0){
                pre = this.buttonCount/2;
                nex = pre -1;
            }else {
                pre = this.buttonCount/2;  //2
                nex = pre;                 //2
            }
            this.begin = this.pageNum-pre;
            this.end = this.pageNum +nex;

            //特殊情况
            if (this.begin<=0){
                this.begin = 1;
                this.end = this.buttonCount;
            }
            if (this.end>this.totalPage){
                this.end = this.totalPage;
                this.begin = this.totalPage - this.buttonCount+1;
            }
        }
    }

    public Integer getBegin(){
        math();
        return begin;
    }


    public PageBean() {
    }

    public Integer getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(Integer totalCount) {
        this.totalCount = totalCount;
    }

    public Integer getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(Integer totalPage) {
        this.totalPage = totalPage;
    }

    public List<E> getList() {
        return list;
    }

    public void setList(List<E> list) {
        this.list = list;
    }

    public Integer getPageNum() {
        return pageNum;
    }

    public void setPageNum(Integer pageNum) {
        this.pageNum = pageNum;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public void setBegin(Integer begin) {
        this.begin = begin;
    }

    public Integer getEnd() {
        return end;
    }

    public void setEnd(Integer end) {
        this.end = end;
    }

    public Integer getButtonCount() {
        return buttonCount;
    }

    public void setButtonCount(Integer buttonCount) {
        this.buttonCount = buttonCount;
    }
}
