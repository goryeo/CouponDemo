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
    
    //쿠폰 리스트 조회
    @RequestMapping(value = "/coupon/list", method = RequestMethod.GET)
    public String couponList(@RequestParam Map<String, Object> paramMap, Model model) throws Exception {

        //null처리 및 기본값 셋팅 및 초기화
        String strStartPage = (String) paramMap.get("startPage");
        String strVisiblePages = (String) paramMap.get("visiblePages");
 
        int startPage = 1;
        int visiblePages = 10;
 
        if(strStartPage != null && !strStartPage.equals("")){
            startPage = Integer.parseInt(strStartPage);
        }
        if(strVisiblePages != null && !strVisiblePages.equals("")){
            visiblePages = Integer.parseInt(strVisiblePages);
        }
 
        model.addAttribute("startPage", startPage);//현재 페이지
        model.addAttribute("totalPage", 1);//전체 게시물
 
        //처음 호출이 아니라면
        if(paramMap.get("init") != null){
 
            Map<String, Object> searchMap = new HashMap<String, Object>();

            //전체 게시물수 가져오기
            int totalCnt = couponService.getCouponCnt();
 
            model.addAttribute("init","N");
            model.addAttribute("totalCnt", totalCnt);//전체 게시물
            model.addAttribute("totalPage", totalPage.getTotalPage(totalCnt, visiblePages));//전체 페이지
            model.addAttribute("couponList", couponService.getCouponList(searchMap, startPage,  visiblePages));//검색
 
        }

        return "couponList";
        
    }

    //AJAX 호출 (쿠폰생성 등록)
    @RequestMapping(value="/coupon/create", method=RequestMethod.POST)
    @ResponseBody
    public Object couponCreate(@RequestParam Map<String, Object> paramMap) {

        //리턴값
        Map<String, Object> retVal = new HashMap<String, Object>();

        //정보입력
        int intResult = 0;
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