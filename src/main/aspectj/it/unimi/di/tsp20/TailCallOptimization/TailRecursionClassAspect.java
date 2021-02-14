package it.unimi.di.tsp20.TailCallOptimization;

import it.unimi.di.tsp20.TailCallOptimization.annotation.TailRecursion;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Aspect
public class TailRecursionClassAspect {

    //moved to SpringAOP to take advantage of the ProceedingJoinPoint
    @Around("execution(@TailRecursion * *.*(..)) && !within(*Aspect)")
    public Object TailCallOptimization(ProceedingJoinPoint thisJoinPoint) {
        var args=thisJoinPoint.getArgs();

        Method thisMethod= ((MethodSignature) thisJoinPoint.getStaticPart().getSignature()).getMethod();

        Throwable th = new Throwable();
        StackTraceElement[] stack = th.getStackTrace();
        Stream<StackTraceElement> ls= Arrays.stream(stack)
                .filter(p->p.getClassName().equals(thisMethod.getDeclaringClass().getCanonicalName())
                            && p.getMethodName().equals(thisMethod.getName()));
        
        if(ls.count() ==2)
            throw new TailRecursionException(thisJoinPoint.getSignature().toLongString(), args);
        else{
            while(true)
                try {
                    return thisJoinPoint.proceed(args);
                } catch (TailRecursionException tre) {
                    if(thisJoinPoint.getSignature().toLongString().equals(tre.method))
                        args = tre.args;
                    else
                        throw tre;
                } catch (Throwable throwable) {
                    throwable.printStackTrace();
                }
        }
    }
}
