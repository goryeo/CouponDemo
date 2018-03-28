package com.coupon.dao;

import java.util.List;
import java.util.Map;

import com.coupon.domain.ResCouponList;

public interface CouponDao {

    // 쿠폰 개수
    public int getCouponCnt() throws Exception;

    // 쿠폰 리스트
    public List<ResCouponList> getCouponList(Map<String, Object> paramMap) throws Exception;

    // 쿠폰 생성
    public int insCoupon(Map<String, Object> paramMap) throws Exception;

}