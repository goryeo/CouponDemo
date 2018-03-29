package com.coupon.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ResCouponList {
    private int    strCouponID;
    private String strEmailAddr;
    private String strCouponNo;
    private Date   strRegDate;
}