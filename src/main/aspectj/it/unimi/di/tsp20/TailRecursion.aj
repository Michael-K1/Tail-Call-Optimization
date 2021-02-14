package it.unimi.di.tsp20;

public aspect TailRecursion {

    pointcut methodCall(int n, int i): call(* *.*(int, int)) && args(n, i) ; //only fact

    Object around(int n, int i): methodCall(n, i){

        if(thisEnclosingJoinPointStaticPart.getSignature().toString().equals(thisJoinPointStaticPart.getSignature().toString())){
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
