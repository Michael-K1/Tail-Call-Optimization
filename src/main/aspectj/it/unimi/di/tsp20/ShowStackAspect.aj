package it.unimi.di.tsp20;

import org.aspectj.lang.reflect.MethodSignature;
import java.lang.reflect.Method;

public aspect ShowStackAspect {
    pointcut tailRecExecution(): execution(* *.*(..));
    
    before(): tailRecExecution(){
        Method thisMethod= ((MethodSignature) thisJoinPointStaticPart.getSignature()).getMethod();
        
        if(thisMethod.getAnnotation(TailRecursion.class)==null) return; //only with @TailRecursion the stack is shown

        Throwable th = new Throwable();
        StackTraceElement[] stack = th.getStackTrace();
        int len=stack.length;
        System.out.println("########################################################################");

        for (int x =1;x<len;x++)    //starts with 1 because [0] is the call to THIS BEFORE to show the stack
            System.out.println("\t "+String.format("%3d",len-x-1)+" " +stack[x].getMethodName());
        
    }
}
