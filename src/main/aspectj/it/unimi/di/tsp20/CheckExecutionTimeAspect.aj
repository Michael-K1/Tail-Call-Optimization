package it.unimi.di.tsp20;
import com.google.common.base.Stopwatch;
import org.aspectj.lang.reflect.MethodSignature;

import java.lang.reflect.Method;

public aspect CheckExecutionTimeAspect pertarget(methodCall()){
    public Stopwatch timer= Stopwatch.createUnstarted();
    pointcut methodCall(): call(* *.*(..)) ;

    before(): methodCall() && !within(*Aspect){
        Method thisMethod= ((MethodSignature) thisJoinPointStaticPart.getSignature()).getMethod();
        if(thisMethod.getAnnotation(TailRecursion.class)==null) return;

        Throwable th = new Throwable();
        StackTraceElement[] stack = th.getStackTrace();
        int len=stack.length;

        if(len>=4 && stack[0].getMethodName().equals(stack[3].getMethodName())) return;

            if(!timer.isRunning()) {
            System.out.println("'"+thisMethod.getName()+"' execution started: "+timer);
            timer.start();
        }else
            System.out.println("Recursive Call to '"+thisMethod.getName()+"'. Execution continues: "+timer);
    }

    after() returning: methodCall() && !within(*Aspect){
        Method thisMethod= ((MethodSignature) thisJoinPointStaticPart.getSignature()).getMethod();
        if(thisMethod.getAnnotation(TailRecursion.class)==null) return;

        Throwable th = new Throwable();
        StackTraceElement[] stack = th.getStackTrace();
        int len=stack.length;

        if(len>=4 && stack[0].getMethodName().equals(stack[3].getMethodName())) return;

            timer.stop();

        System.out.println("'"+thisMethod.getName()+"' execution Time: "+timer);
        timer.reset();
    }
}
