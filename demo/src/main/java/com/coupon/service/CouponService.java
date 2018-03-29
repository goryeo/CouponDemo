package com.coupon.service;

import java.util.List;
import java.util.Map;

import com.coupon.domain.ResCouponList;

public interface CouponService {

    //1. 전체 쿠폰 개수 조회
    public int getCouponCnt() throws Exception;

    //2. 쿠폰 리스트 조회
    public List<ResCouponList> selectCouponList(int pageNo, int pageSize) throws Exception;

    //3. 쿠폰 생성
    public void insertCoupon(Map<String, Object> paramMap) throws Exception;
    
    //4. 랜덤 쿠폰 번호 생성
    public String getCouponNo() throws Exception;
}