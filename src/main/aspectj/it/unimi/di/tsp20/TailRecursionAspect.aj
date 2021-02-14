package it.unimi.di.tsp20;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.reflect.MethodSignature;

public aspect TailRecursionAspect {

    pointcut methodCall(Object[] a): call(* *.*(Object[])) && args(a) ; //only fact

    Object around(Object[] args): methodCall(args){
        MethodSignature thisMethod=(MethodSignature) thisJoinPointStaticPart.getSignature();
        MethodSignature enclosingMethod=(MethodSignature) thisEnclosingJoinPointStaticPart.getSignature();


/*
        if(thisMethod.getMethod().getAnnotation(TailRecursion.class)==null && enclosingMethod.getMethod().getAnnotation(TailRecursion.class)==null)
            return proceed(n,i);
*/

        if(enclosingMethod.getMethod().equals(thisMethod.getMethod())){
            //System.out.println("print call " +n+" "+i);

            throw new TailRecursionException(args);
        }else{
            while(true)
                try {
                    return proceed(args);
                } catch (TailRecursionException tre) {
                    /*for (int x =0;x<tre.getStackTrace().length;x++)
                       System.out.println("\t "+x+" " +tre.getStackTrace()[x]);*/
                    args = tre.args;
                }
        }
    }



}
