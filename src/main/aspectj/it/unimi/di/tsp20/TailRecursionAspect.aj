package it.unimi.di.tsp20;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.reflect.MethodSignature;

public aspect TailRecursionAspect {

    pointcut methodCall(int n, int i): call(* *.*(int, int)) && args(n, i) ; //only fact

    Object around(int n, int i): methodCall(n, i){
        MethodSignature thisMethod=(MethodSignature) thisJoinPointStaticPart.getSignature();
        MethodSignature enclosingMethod=(MethodSignature) thisEnclosingJoinPointStaticPart.getSignature();

/*
        if(thisMethod.getMethod().getAnnotation(TailRecursion.class)==null && enclosingMethod.getMethod().getAnnotation(TailRecursion.class)==null)
            return proceed(n,i);
*/

        if(enclosingMethod.getMethod().equals(thisMethod.getMethod())){
            System.out.println("print call " +n+" "+i);

            throw new TailRecursionException(n, i);
        }else{
            while(true)
                try {
                    return proceed(n, i);
                } catch (TailRecursionException tre) {
                    /*for (int x =0;x<tre.getStackTrace().length;x++)
                       System.out.println("\t "+x+" " +tre.getStackTrace()[x]);*/
                    n = tre.n;
                    i = tre.i;

                }
        }
    }



}
