package it.unimi.di.tsp20;

public aspect TailRecursion {

    pointcut methodCall(int n, int i): call(* *.*(int, int)) && args(n, i); //only fact

    int around(int n, int i): methodCall(n, i){

        if(thisEnclosingJoinPointStaticPart.getSignature().toString().equals(thisJoinPointStaticPart.getSignature().toString())){
            System.out.println("recursive call " +thisJoinPoint.getArgs().length);
            System.out.println("print call " +n+" "+i);


            throw new TailRecursionException(n, i);


        }else{
            while(true)
                try {
                    return proceed(n, i);
                } catch (TailRecursionException tre) {

                    n = tre.n;
                    i = tre.i;

                }
        }
    }



}
