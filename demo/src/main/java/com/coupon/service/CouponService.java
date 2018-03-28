package com.coupon.service;

import java.util.List;
import java.util.Map;

import com.coupon.domain.ResCouponList;

public interface CouponService {

    // 쿠폰 개수
    public int getCouponCnt() throws Exception;

    // 쿠폰 리스트
    public List<ResCouponList> getCouponList(int pageNo, int pageSize) throws Exception;

    // 쿠폰 생성
    public int insCoupon(Map<String, Object> paramMap) throws Exception;
}
