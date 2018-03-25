package com.coupon.mapper;


import java.util.List;

import com.coupon.domain.CouponVO;

public interface CouponMapper {
	
   //쿠폰 생성
   public void couponInsert(CouponVO coupon) throws Exception;
   
   //쿠폰 목록  
   public List<CouponVO> couponList() throws Exception;
   
}