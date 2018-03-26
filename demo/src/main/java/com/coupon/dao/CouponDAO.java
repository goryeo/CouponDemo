package com.coupon.dao;


import java.util.List;

import com.coupon.domain.CouponVO;

public interface CouponDAO {
	
	//쿠폰 개수
	public int couponCount() throws Exception;
	
    //쿠폰 생성
    public void couponInsert(CouponVO coupon) throws Exception;
   
    //쿠폰 목록  
    public List<CouponVO> couponList() throws Exception;
   
}