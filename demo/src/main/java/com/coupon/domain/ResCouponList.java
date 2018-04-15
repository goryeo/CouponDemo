package com.coupon.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ResCouponList {
    private int    intCouponID;
    private String strEmailAddr;
    private String strCouponNo;
    private String strRegDate;
}