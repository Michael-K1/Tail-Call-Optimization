package it.unimi.di.tsp20;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

@Aspect
public class TailRecursionClassAspect {

    //moved to SpringAOP to take advantage of the ProceedingJoinPoint
    @Around("execution(* *.*(..)) && !within(*Aspect)")
    public Object TailCallOptimization(ProceedingJoinPoint thisJoinPoint) {
        var args=thisJoinPoint.getArgs();

        Throwable th = new Throwable();
        StackTraceElement[] stack = th.getStackTrace();
        int len=stack.length;

        //[1] and [4] are the stack frames of the recursive function;
        //between them there are frames created by this Advice
        if(len>=5 && stack[1].getMethodName().equals(stack[4].getMethodName()))
            throw new TailRecursionException(args);
        else{
            while(true)
                try {
                    //a call to 'proceed' generates 3 frames: 2 for the management of the Advice and 1 of the recursive call
                    return thisJoinPoint.proceed(args);
                } catch (TailRecursionException tre) {
                    args = tre.args;
                } catch (Throwable throwable) {
                    throwable.printStackTrace();
                }
        }
    }
}
