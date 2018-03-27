package com.coupon.util;

import java.math.BigDecimal;

import org.springframework.stereotype.Component;
 
@Component
public class TotalPage {
     
    public BigDecimal getTotalPage(int totalCnt, int visiblePages){
        BigDecimal decimal1 = new BigDecimal(totalCnt);
        BigDecimal decimal2 = new BigDecimal(visiblePages);
        BigDecimal tatalPage = decimal1.divide(decimal2, 0, BigDecimal.ROUND_UP);
         
        return tatalPage;
    }
 
}