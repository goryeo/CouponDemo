package com.coupon.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.coupon.service.CouponService;
import com.coupon.util.TotalPage;;

@Controller
public class CouponController {

    @Autowired
    private CouponService couponService;
    
    @Autowired
    private TotalPage totalPage;
    
    //1. 쿠폰 리스트 조회
    @RequestMapping(value = "/coupon/list", method = RequestMethod.GET)
    public String couponList(@RequestParam Map<String, Object> paramMap, Model model) {
        
        int pageNo         = 1;
        int pageSize       = 10;
        int totalCnt       = 0;
        String strPageNo   = (String) paramMap.get("pageNo");
        String strPageSize = (String) paramMap.get("pageSize");

        try 
        {
            if(strPageNo != null && !strPageNo.equals("")){
                pageNo = Integer.parseInt(strPageNo);
            }
            if(strPageSize != null && !strPageSize.equals("")){
                pageSize = Integer.parseInt(strPageSize);
            }

            totalCnt = couponService.getCouponCnt();

            //현재 페이지
            model.addAttribute("pageNo", pageNo);
            //전체 개수
            model.addAttribute("totalCnt", totalCnt);
            //전체 페이지
            model.addAttribute("totalPage", totalPage.getTotalPage(totalCnt, pageSize));
            //쿠폰 리스트 호출
            model.addAttribute("couponList", couponService.getCouponList(pageNo, pageSize));
        }
        catch (Exception objEx) 
        { 
            objEx.printStackTrace();
        }

        return "couponList";
        
    }

    //2. 쿠폰 생성
    @RequestMapping(value="/coupon/create", method=RequestMethod.POST)
    @ResponseBody
    public Object couponCreate(@RequestParam Map<String, Object> paramMap) {
        
        //정보입력
        int intResult = 0;
        
        //리턴값
        Map<String, Object> retVal = new HashMap<String, Object>();

        try 
        {
            intResult = couponService.insCoupon(paramMap);
        } 
        catch (Exception objEx) 
        { 
            objEx.printStackTrace();
        }
        finally
        {
            if(intResult > 0){
                retVal.put("code", "OK");
                retVal.put("message", "쿠폰생성 성공.");
            }
            else{
                retVal.put("code", "FAIL");
                retVal.put("message", "쿠폰생성 실패.");
            }    
        }
        
        return retVal;
        
    }
}