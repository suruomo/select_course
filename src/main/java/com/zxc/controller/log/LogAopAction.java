package com.zxc.controller.log;

import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.zxc.model.LogEntity;
import com.zxc.service.LogService;
 
@Aspect
public class LogAopAction {
    //注入service,用来将日志信息保存在数据库
    @Resource
    private LogService logservice;
    
     //配置接入点,切点实在空方法上去配置的，当然这是简便写法，因为这样的话，后面方法上面的切面就直接可以用户这个空的方法名去代替这样就避免了重复去写契入点
    @Pointcut("execution(* com.zxc.controller..*.*(..))") 
     private void controllerAspect(){}//定义一个切入点
    /**
     * 环绕通知（Around advice） ：包围一个连接点的通知，类似Web中Servlet规范中的Filter的doFilter方法。可以在方法的调用前后完成自定义的行为，也可以选择不执行。
     */
     @Around("controllerAspect()")
     public Object around(ProceedingJoinPoint pjp) throws Throwable {
         //常见日志实体对象
         LogEntity log = new LogEntity(); 
         //获取登录用户账户
         HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
         System.out.println("会话id"+request.getSession().getAttribute("id"));
         Object id =request.getSession().getAttribute("id");
         if(id==null) {    //第一次登陆为null
             log.setId(logservice.getCurrentId());
             log.setUserId("第一个登陆者");
         }
         else {
             log.setId(logservice.getCurrentId());
             log.setUserId(id.toString());
         }
         //获取系统时间
         String time = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss").format(new Date());
         log.setData(time);
         
         //获取用户名
         String username = (String) request.getSession().getAttribute("username");
         log.setUsername(username);
         
        //方法通知前获取时间,为什么要记录这个时间呢？当然是用来计算模块执行时间的
         long start = System.currentTimeMillis();
        // 拦截的实体类，就是当前正在执行的controller
        Object target = pjp.getTarget();
        // 拦截的方法名称。当前正在执行的方法
        String methodName = pjp.getSignature().getName();
        // 拦截的方法参数
        Object[] args = pjp.getArgs();
        // 拦截的放参数类型
        Signature sig = pjp.getSignature();
        MethodSignature msig = null;
        if (!(sig instanceof MethodSignature)) {
            throw new IllegalArgumentException("该注解只能用于方法");
        }
        msig = (MethodSignature) sig;
        Class[] parameterTypes = msig.getMethod().getParameterTypes();
        
        Object object = null;
        // 获得被拦截的方法
        Method method = null;
        try {
            method = target.getClass().getMethod(methodName, parameterTypes);
        } catch (NoSuchMethodException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        } catch (SecurityException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
        if (null != method) {
            // 判断是否包含自定义的注解，说明一下这里的SystemLog就是我自己自定义的注解
            if (method.isAnnotationPresent(SystemLog.class)) {
            	try {
            		SystemLog systemlog = method.getAnnotation(SystemLog.class);
                    log.setModule(systemlog.module());
                    log.setMethod(systemlog.methods());
                        object = pjp.proceed();
                        long end = System.currentTimeMillis();
                        //将计算好的时间保存在实体中
                        log.setResponse_date(""+(end-start));
                        log.setCommit("执行成功！");
                        //保存进数据库
                        logservice.addLog(log);
            	  }catch (Throwable e) {
                    // TODO Auto-generated catch block
                    long end = System.currentTimeMillis();
                    log.setResponse_date(""+(end-start));
                    log.setCommit("执行失败");
                    logservice.addLog(log);
                }  
            } else {//没有包含注解
                object = pjp.proceed();
            }
        }
            else { //不需要拦截直接执行
            object = pjp.proceed();
        }
        return object;
     }
}
