package com.coupon.util;

import java.util.HashMap;
import java.util.Map;
 
import org.springframework.stereotype.Component;
 
@Component
public class PageableUtil {
     
    public Map<String, Object> getRowBounds(int pageNo, int pageSize){

        if(pageNo == 1)
        {
            pageNo = 0;
        }
        else
        {
            pageNo = (pageNo - 1) * pageSize;
        }
        
        Map<String, Object> objPageable = new HashMap<String, Object>();
         
        objPageable.put("pageno",   pageNo);
        objPageable.put("pagesize", pageSize);
         
        return objPageable;
    }
 
}