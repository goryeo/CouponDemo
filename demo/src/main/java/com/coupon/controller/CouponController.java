package com.coupon.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.coupon.domain.CouponVO;
import com.coupon.mapper.CouponMapper;
 
@Controller
@RequestMapping("/list")
public class CouponController {
 
	@Autowired
	private CouponMapper couponMapper;
    
	@RequestMapping(method=RequestMethod.GET)  
    public ModelAndView couponList() throws Exception{
    	List<CouponVO> coupon = couponMapper.couponList();
    	ModelAndView objmv = new ModelAndView("couponList");
    	objmv.addObject("list", coupon);
        return objmv;
    }
	
    //쿠폰 생성 페이지(GET)    
    @RequestMapping(value="/post",method=RequestMethod.GET)
    public ModelAndView insertForm() throws Exception{
    	ModelAndView objmv = new ModelAndView("couponInsert");
        return objmv;
    }
    
    //쿠폰 생성(POST)
    @RequestMapping(value="/post",method=RequestMethod.POST)
    public String insert(@ModelAttribute("CouponVO") CouponVO coupon) throws Exception{
 
    	couponMapper.couponInsert(coupon);
        
        return "redirect://localhost:8080/list";
    }
}