package com.coupon.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.coupon.dao.CouponDao;
import com.coupon.domain.ResCouponList;
import com.coupon.util.GlobalException;
import com.coupon.util.PageableUtil;

@Service
public class CouponServiceImpl implements CouponService {

    @Autowired
    private CouponDao objCouponDao;

    @Autowired
    private PageableUtil objPageableUtil;
    
    //1. 전체 쿠폰 개수 조회
    @Override
    public int getCouponCnt() throws Exception {
        return objCouponDao.getCouponCnt();
    }

    //2. 쿠폰 리스트 조회
    @Override
    public List<ResCouponList> selectCouponList(int intPageNo, int intPageSize) throws Exception {
        
        //페이징을 위한 limit 조건을 추가
        Map<String, Object> tmpMap = objPageableUtil.getRowBounds(intPageNo, intPageSize);
 
        tmpMap.put("start", tmpMap.get("pageno"));
        tmpMap.put("end",   tmpMap.get("pagesize"));

        return objCouponDao.selectCouponList(tmpMap);
    }

    //3. 쿠폰 생성
    @Override
    public void insertCoupon(Map<String, Object> paramMap) throws Exception {
        
    	String strCouponNo  = "";
    	
    	//쿠폰 번호 생성
        strCouponNo = objCouponDao.getCouponNo();
        
        //쿠폰 번호 공백 체크
        if(strCouponNo == null || strCouponNo.isEmpty()) {
            throw new GlobalException("쿠폰 생성 오류가 발생했습니다. 다시 시도해주세요.");
        }
        
        //쿠폰 번호 '-' 문자 연결
        strCouponNo = strCouponNo.substring(0, 4) + "-" + strCouponNo.substring(4, 8) + "-" + strCouponNo.substring(8, 12) + "-" + strCouponNo.substring(12, 16);

        //이메일 중복 체크
        if(objCouponDao.selectDupEmailAddr(paramMap.get("strEmailAddr").toString()) > 0){
            throw new GlobalException("중복된 이메일 주소입니다.");
        }
        //쿠폰 중복 체크
        if(objCouponDao.selectDupCouponNo(strCouponNo) > 0){
            throw new GlobalException("중복된 쿠폰이 생성되었습니다. 다시 시도해주세요.");
        }
        
        objCouponDao.insertCoupon(paramMap);
    }

    //4. 랜덤 쿠폰 번호 생성
    @Override
    public String getCouponNo() throws Exception {
        return objCouponDao.getCouponNo();
    }
}
