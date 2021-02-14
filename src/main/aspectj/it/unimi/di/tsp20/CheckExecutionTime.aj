package it.unimi.di.tsp20;
import com.google.common.base.Stopwatch;

public aspect CheckExecutionTime pertarget(methodCall()){
    public Stopwatch timer= Stopwatch.createUnstarted();
    pointcut methodCall(): call(* *.*(..));

    before(): methodCall() && !cflowbelow(methodCall()){
        System.out.println(thisJoinPoint+" execution started: "+timer);
        timer.start();
    }

    after() returning: methodCall() && !cflowbelow(methodCall()){
        timer.stop();

        System.out.println(thisJoinPoint+" execution Time: "+timer);
        timer.reset();
    }
}
