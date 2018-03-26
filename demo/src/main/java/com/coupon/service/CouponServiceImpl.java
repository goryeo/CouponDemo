package com.coupon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.coupon.dao.CouponDAO;
import com.coupon.domain.CouponVO;

@Service
public class CouponServiceImpl implements CouponService {

	@Autowired
	private CouponDAO couponDao;
	
	@Override
	public int couponCount() throws Exception {
		return couponDao.couponCount();
	}

	@Override
	public void couponInsert(CouponVO coupon) throws Exception {
	    String emailAddr = coupon.getEmailAddr();
	    coupon.setEmailAddr(emailAddr);
	    couponDao.couponInsert(coupon);
	}

	@Override
	public List<CouponVO> couponList() throws Exception {
		return couponDao.couponList();
	}

}
