package it.unimi.di.tsp20;
import com.google.common.base.Stopwatch;

public aspect CheckExecutionTime pertarget(methodCall()){
    public Stopwatch timer= Stopwatch.createUnstarted();
    pointcut methodCall(): call(* *.*(..))  ;

    before(): methodCall() && !cflowbelow(methodCall()){
        if(thisEnclosingJoinPointStaticPart.getSignature().toString().equals(thisJoinPointStaticPart.getSignature().toString())) return;
        System.out.println(thisJoinPoint+" execution started: "+timer);
        if(!timer.isRunning())
            timer.start();
    }

    after() returning: methodCall() && !cflowbelow(methodCall()){
        if(thisEnclosingJoinPointStaticPart.getSignature().toString().equals(thisJoinPointStaticPart.getSignature().toString())) return;

        timer.stop();

        System.out.println(thisJoinPoint+" execution Time: "+timer);
        timer.reset();
    }
}
