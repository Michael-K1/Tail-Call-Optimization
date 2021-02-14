package it.unimi.di.tsp20.TailCallOptimization;

import it.unimi.di.tsp20.TailCallOptimization.annotation.TailRecursion;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;

import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.stream.Stream;

/**
 * Aspect that performs Tail Call Optimization (TCO) to functions annotated with <i>@TailRecursion</i>
 */
@Aspect
public class TailRecursionClassAspect {

    /**
     * Wraps the tail recursive function to perform TCO.<br>
     * This opptimization drastically reduces the the amount of stack frames genereted<br>
     * by a method.<br>
     * Works with Simple and <a href=https://en.wikipedia.org/wiki/Mutual_recursion>Mutual Recursive</a> functions
     *
     * @param thisJoinPoint ProceedingJoinPoint in the corresponding method
     *
     * @return the result of the tail recursive function.
     */
    @Around("execution(@TailRecursion * *.*(..)) && !within(*Aspect)")
    public Object TailCallOptimization(ProceedingJoinPoint thisJoinPoint) {
        var args=thisJoinPoint.getArgs();

        Method thisMethod= ((MethodSignature) thisJoinPoint.getStaticPart().getSignature()).getMethod();

        Throwable th = new Throwable();
        StackTraceElement[] stack = th.getStackTrace();
        Stream<StackTraceElement> streamSTE= Arrays.stream(stack)
                .filter(p->p.getClassName().equals(thisMethod.getDeclaringClass().getCanonicalName())
                            && p.getMethodName().equals(thisMethod.getName()));

        if(streamSTE.count() ==2)
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
