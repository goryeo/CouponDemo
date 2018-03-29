package com.coupon.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.coupon.service.CouponService;
import com.coupon.util.TotalPage;;

@Controller
public class CouponController {

    @Autowired
    private CouponService objCouponService;
    
    @Autowired
    private TotalPage objTotalPage;
    
    //1. 쿠폰 리스트 조회
    @RequestMapping(value = "/coupon/list", method = RequestMethod.GET)
    public String selectCouponList(@RequestParam Map<String, Object> paramMap, Model model) {
        
        int    intPageNo   = 1;
        int    intPageSize = 10;
        int    intTotalCnt = 0;
        String strPageNo   = (String) paramMap.get("pageNo");
        String strPageSize = (String) paramMap.get("pageSize");

        try 
        {
            if(strPageNo != null && !strPageNo.equals("")){
                intPageNo = Integer.parseInt(strPageNo);
            }
            if(strPageSize != null && !strPageSize.equals("")){
                intPageSize = Integer.parseInt(strPageSize);
            }

            intTotalCnt = objCouponService.getCouponCnt();

            //현재 페이지
            model.addAttribute("pageNo", intPageNo);
            //전체 개수
            model.addAttribute("totalCnt", intTotalCnt);
            //전체 페이지
            model.addAttribute("totalPage", objTotalPage.getTotalPage(intTotalCnt, intPageSize));
            //쿠폰 리스트 호출
            model.addAttribute("couponList", objCouponService.selectCouponList(intPageNo, intPageSize));
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
    public ModelAndView insertCoupon(HttpServletRequest  objRequest
                                    ,HttpServletResponse objResponse
                                    ,@RequestBody Map<String, Object> paramMap) {
        
        int    intResult   = 0;
        String strErrMsg   = "쿠폰생성에 성공하였습니다.";
        String strCouponNo = null;
        
        //JSON 응답 객체
        ModelAndView  objMV = new ModelAndView(new MappingJackson2JsonView());

        try 
        {         
            //쿠폰 번호 생성
            strCouponNo = objCouponService.getCouponNo();
            strCouponNo = strCouponNo.substring(0, 4) + "-" + strCouponNo.substring(4, 8) + "-" + strCouponNo.substring(8, 12) + "-" + strCouponNo.substring(12, 16);
            
            //입력받은 이메일과 생성한 쿠폰 정보 추가
            paramMap.put("strEmailAddr", paramMap.get("strEmailAddr"));
            paramMap.put("strCouponNo",  strCouponNo);
            
            objCouponService.insertCoupon(paramMap);
        } 
        catch (Exception objEx) 
        { 
            intResult = 9999;
            strErrMsg = objEx.getMessage();
        }
        finally
        {
            objMV.addObject("code",    intResult);
            objMV.addObject("message", strErrMsg);
        }
        
        return objMV;
        
    }
}