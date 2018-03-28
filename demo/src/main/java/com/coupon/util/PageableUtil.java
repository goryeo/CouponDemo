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
        
        Map<String, Object> pageable = new HashMap<String, Object>();
         
        pageable.put("start", pageNo);
        pageable.put("end",   pageSize);
         
        return pageable;
    }
 
}