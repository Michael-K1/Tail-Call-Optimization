package it.unimi.di.tsp20;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

@Aspect
public class TailRecursionClassAspect {

    @Around("execution(* *.*(..)) && !within(*Aspect)")
    public Object test(ProceedingJoinPoint thisJoinPoint)throws Throwable{
        var args=thisJoinPoint.getArgs();

        Throwable th = new Throwable();
        StackTraceElement[] stack = th.getStackTrace();
        int len=stack.length;

        if(len>=4 && stack[0].getMethodName().equals(stack[3].getMethodName())) {
            throw new TailRecursionException(args);
        } else{
            while(true)
                try {
                    return thisJoinPoint.proceed(args);
                } catch (TailRecursionException tre) {
                    args = tre.args;
                } catch (Throwable throwable) {
                    throwable.printStackTrace();
                }
        }
    }
}
