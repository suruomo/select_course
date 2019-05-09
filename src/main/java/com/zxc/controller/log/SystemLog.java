package com.zxc.controller.log;

import java.lang.annotation.*;
@Target({ElementType.PARAMETER, ElementType.METHOD})  
@Retention(RetentionPolicy.RUNTIME)  
@Documented 
public @interface SystemLog {
    String module()  default "";    //模块
    String methods()  default "";    //方法
}
