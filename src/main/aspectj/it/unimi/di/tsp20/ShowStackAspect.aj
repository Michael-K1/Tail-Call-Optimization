package it.unimi.di.tsp20;

import org.aspectj.lang.reflect.MethodSignature;

public aspect ShowStackAspect {
    pointcut tailRecExecution(): execution(* *.*(..));
    
    before(): tailRecExecution(){
        MethodSignature thisMethod= (MethodSignature) thisJoinPointStaticPart.getSignature();
        
        if(thisMethod.getMethod().getAnnotation(TailRecursion.class)==null) return;

        Throwable th = new Throwable();
        System.out.println("########################################################################");
        for (int x =0;x<th.getStackTrace().length;x++)
            System.out.println("\t "+x+" " +th.getStackTrace()[x]);
        
    }
}
