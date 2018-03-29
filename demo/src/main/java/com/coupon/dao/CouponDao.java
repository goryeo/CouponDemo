package com.coupon.dao;

import java.util.List;
import java.util.Map;

import com.coupon.domain.ResCouponList;

public interface CouponDao {

    //1. 쿠폰 전체 개수 조회
    public int getCouponCnt() throws Exception;

    //2. 쿠폰 리스트 조회
    public List<ResCouponList> selectCouponList(Map<String, Object> paramMap) throws Exception;

    //3. 쿠폰 생성
    public void insertCoupon(Map<String, Object> paramMap) throws Exception;
    
    //4. 랜덤 쿠폰 번호 생성
    public String getCouponNo() throws Exception;
    
    //5. 이메일 중복 체크
    public int selectDupEmailAddr(String strEmailAddr) throws Exception;
    
    //6. 쿠폰 번호 중복 체크
    public int selectDupCouponNo(String strCouponNo) throws Exception;
}