package com.coupon.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.coupon.dao.CouponDao;
import com.coupon.domain.CouponVO;
import com.coupon.util.PageableUtil;

@Service
public class CouponServiceImpl implements CouponService {

    @Autowired
    private CouponDao couponDao;

    @Autowired
    private PageableUtil pageableUtil;
    
    @Override
    public int getCouponCnt() throws Exception {
        return couponDao.getCouponCnt();
    }

    @Override
    public List<CouponVO> getCouponList(Map<String, Object> paramMap, int startPage, int visiblePages) throws Exception {
        //페이징을 위한 limit 조건을 추가
        Map<String, Object> tmpSearchMap = pageableUtil.getRowBounds(startPage, visiblePages);
 
        paramMap.put("start", tmpSearchMap.get("start"));
        paramMap.put("end",   tmpSearchMap.get("end"));

        return couponDao.getCouponList(paramMap);
    }

    @Override
    public int insCoupon(Map<String, Object> paramMap) throws Exception {
        return couponDao.insCoupon(paramMap);
    }

}
