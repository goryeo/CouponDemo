package com.coupon.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CouponVO extends ListPagingVO{
 
	private int    CouponCNT;
    private int    CouponID;
    private String EmailAddr;
    private String CouponNo;
    private Date   regdate;
 
    // toString()
    @Override
    public String toString() {
        return "CouponVO [CouponID=" + CouponID + ", EmailAddr=" + EmailAddr + ", CouponNo=" + CouponNo + ", regdate=" + regdate + "]";
    }
}