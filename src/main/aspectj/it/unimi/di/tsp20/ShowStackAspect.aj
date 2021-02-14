package it.unimi.di.tsp20;

import org.aspectj.lang.reflect.MethodSignature;

public aspect ShowStackAspect {
    pointcut tailRecExecution(): execution(* *.*(..));
    
    before(): tailRecExecution(){
        MethodSignature thisMethod= (MethodSignature) thisJoinPointStaticPart.getSignature();
        
        if(thisMethod.getMethod().getAnnotation(TailRecursion.class)==null) return;

        Throwable th = new Throwable();
        System.out.println("########################################################################");
        int len=th.getStackTrace().length;
        for (int x =1;x<len;x++)
            System.out.println("\t "+String.format("%3d",len-x-1)+" " +th.getStackTrace()[x].getMethodName());
        
    }
}
