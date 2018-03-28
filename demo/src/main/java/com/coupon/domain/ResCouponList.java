package com.coupon.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ResCouponList {
    private int    couponid;
    private String emailaddr;
    private String couponno;
    private Date   regdate;
}