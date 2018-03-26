package com.coupon.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CouponVO extends ListPagingVO{
 
	private int    couponCNT;
    private int    couponID;
    private String emailAddr;
    private String couponNo;
    private Date   regdate;
}