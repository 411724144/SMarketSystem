package com.houpu.entity;

import java.io.Serializable;
import java.util.Date;

public class Provider extends BaseEntity implements Serializable {

    private String proCode;
    private String proName;
    private String proDesc;
    private String proContact;
    private String proPhone;
    private String proAddress;
    private String proFax;

    public Provider() {
    }

    public Provider(Object[] excelData) {
        this.proCode =excelData[0].toString();
        this.proName = excelData[1].toString();
        this.proDesc = excelData[2].toString();
        this.proContact = excelData[3].toString();
        this.proPhone = excelData[4].toString();
        this.proAddress = excelData[5].toString();
        this.proFax = excelData[6].toString();
        setCreationDate(new Date(excelData[7].toString()));
    }

    public String getProCode() {
        return proCode;
    }

    public void setProCode(String proCode) {
        this.proCode = proCode;
    }

    public String getProName() {
        return proName;
    }

    public void setProName(String proName) {
        this.proName = proName;
    }

    public String getProDesc() {
        return proDesc;
    }

    public void setProDesc(String proDesc) {
        this.proDesc = proDesc;
    }

    public String getProContact() {
        return proContact;
    }

    public void setProContact(String proContact) {
        this.proContact = proContact;
    }

    public String getProPhone() {
        return proPhone;
    }

    public void setProPhone(String proPhone) {
        this.proPhone = proPhone;
    }

    public String getProAddress() {
        return proAddress;
    }

    public void setProAddress(String proAddress) {
        this.proAddress = proAddress;
    }

    public String getProFax() {
        return proFax;
    }

    public void setProFax(String proFax) {
        this.proFax = proFax;
    }

    @Override
    public String toString() {
        return "Provider{" +
                "proCode='" + proCode + '\'' +
                ", proName='" + proName + '\'' +
                ", proDesc='" + proDesc + '\'' +
                ", proContact='" + proContact + '\'' +
                ", proPhone='" + proPhone + '\'' +
                ", proAddress='" + proAddress + '\'' +
                ", proFax='" + proFax + '\'' +
                '}';
    }
}
