package it.unimi.di.tsp20;

import com.google.common.base.Stopwatch;
import org.aspectj.lang.reflect.MethodSignature;
import java.lang.reflect.Method;

public aspect CheckExecutionTimeAspect pertarget(methodCall()){
    public Stopwatch timer= Stopwatch.createUnstarted();

    public int counter;

    pointcut methodCall(): call(* *.*(..)) ;

    before(): methodCall() && !within(*Aspect){
        Method thisMethod= ((MethodSignature) thisJoinPointStaticPart.getSignature()).getMethod();
        if(thisMethod.getAnnotation(TailRecursion.class)==null) return; //only with @TailRecursion a timer is started to check the performance

        Throwable th = new Throwable();
        StackTraceElement[] stack = th.getStackTrace();
        int len=stack.length;

        //position [1,2] are closure to the tail recursive function added from the "around" advice in "TailRecursionClassAspect"
        if(len>=5 && stack[1].getMethodName().equals(stack[4].getMethodName())) return;
        //System.out.println(stack[1].getMethodName()+"_:_"+stack[4].getMethodName());
        if(!timer.isRunning()) {
            System.out.println(String.format( "\t%sExecution START: '%s'. \n\t\t%sTimer START: %s%s",ConsoleColors.GREEN_BOLD, thisMethod.getName(), ConsoleColors.YELLOW, timer, ConsoleColors.RESET));
            timer.start();
            counter=0;
        }else{   //a bit verbose but helps to see  the time variation
            counter++;
            System.out.println(String.format( "\t%sRecursive Call n°%3d to '%s'. Execution continues: %s%s", ConsoleColors.YELLOW, counter, thisMethod.getName(), timer,ConsoleColors.RESET));
        }
    }

    after() returning: methodCall() && !within(*Aspect){
        Method thisMethod= ((MethodSignature) thisJoinPointStaticPart.getSignature()).getMethod();
        if(thisMethod.getAnnotation(TailRecursion.class)==null) return;

        Throwable th = new Throwable();
        StackTraceElement[] stack = th.getStackTrace();
        int len=stack.length;

        if(len>=5 && stack[1].getMethodName().equals(stack[4].getMethodName())) return;

        timer.stop();

        System.out.println(String.format( "\t%sExecution END: '%s'.%s \n\t\tTOTAL TIME: %s. \n\t\tTOTAL STACK FRAMES SAVED: %3d%s", ConsoleColors.RED_BOLD, thisMethod.getName(), ConsoleColors.YELLOW, timer, counter, ConsoleColors.RESET));
        timer.reset();  //avoid creation of more StopWatches
    }
}
