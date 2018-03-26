package com.coupon.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.coupon.domain.CouponVO;
import com.coupon.service.CouponService;;
 
@Controller
@RequestMapping("/list")
public class CouponController {
 
	@Autowired
	private CouponService couponService;
    
	//쿠폰 리스트
	@RequestMapping(method=RequestMethod.GET)  
    public ModelAndView list() throws Exception{
    	List<CouponVO> list = couponService.couponList();
    	ModelAndView objmv = new ModelAndView();
    	objmv.setViewName("couponList");    // list.jsp
    	objmv.addObject("list", list);      // data
        return objmv;
    }
	
    //쿠폰 생성 페이지(GET)    
    @RequestMapping(value="post", method=RequestMethod.GET)
    public String insertForm() throws Exception{
        return "couponInsert";
    }
    
    //쿠폰 생성(POST)
    @RequestMapping(value="post", method=RequestMethod.POST)
    public String insert(@ModelAttribute CouponVO coupon) throws Exception{
    	couponService.couponInsert(coupon);
        return "redirect://localhost:8080/list";
    }
}