package it.unimi.di.tsp20;

import org.aspectj.lang.reflect.MethodSignature;

import java.lang.reflect.Method;

public aspect ShowStackAspect {
    pointcut tailRecExecution(): execution(* *.*(..));
    
    before(): tailRecExecution(){
        Method thisMethod= ((MethodSignature) thisJoinPointStaticPart.getSignature()).getMethod();
        
        if(thisMethod.getAnnotation(TailRecursion.class)==null) return;

        Throwable th = new Throwable();
        StackTraceElement[] stack = th.getStackTrace();
        int len=stack.length;
        System.out.println("########################################################################");

        for (int x =1;x<len;x++)
            System.out.println("\t "+String.format("%3d",len-x-1)+" " +stack[x].getMethodName());
        
    }
}
