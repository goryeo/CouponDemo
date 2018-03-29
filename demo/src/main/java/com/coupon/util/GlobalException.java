package com.coupon.util;

public class GlobalException extends RuntimeException {
  private static final long serialVersionUID = -4905188315768559766L;

  public GlobalException(String strMessage) {
      super(strMessage);
  }
  
  public GlobalException(Throwable objCause) {
      super(objCause);
  }
}