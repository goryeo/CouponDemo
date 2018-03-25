package com.coupon.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CouponVO {
 
    private int    CouponID;
    private String EmailAddr;
    private String CouponNo;
    private Date   regdate;
 
}