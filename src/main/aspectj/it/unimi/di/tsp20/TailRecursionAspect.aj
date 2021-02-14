package it.unimi.di.tsp20;

import org.aspectj.lang.reflect.MethodSignature;

public aspect TailRecursionAspect {

    pointcut methodCall(Object[] a): call(* *.*(Object[])) && args(a);

    Object around(Object[] args): methodCall(args){
        MethodSignature thisMethod=(MethodSignature) thisJoinPointStaticPart.getSignature();
        MethodSignature enclosingMethod=(MethodSignature) thisEnclosingJoinPointStaticPart.getSignature();

        if(enclosingMethod.getMethod().equals(thisMethod.getMethod()))
            throw new TailRecursionException(args);
        else{
            while(true)
                try {
                    return proceed(args);
                } catch (TailRecursionException tre) {
                    args = tre.args;
                }
        }
    }



}
