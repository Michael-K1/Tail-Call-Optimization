package it.unimi.di.tsp20;

import com.google.common.base.Stopwatch;
import it.unimi.di.tsp20.annotation.ExecutionTime;

import it.unimi.di.tsp20.annotation.TailRecursion;
import org.aspectj.lang.reflect.MethodSignature;
import java.lang.reflect.Method;

public aspect CheckExecutionTimeAspect pertarget(methodCall()){
    public Stopwatch timer= Stopwatch.createUnstarted();

    public int counter;

    pointcut methodCall(): call(@ExecutionTime * *.*(..)) && !within(*Aspect);

    before(): methodCall() {
        Method thisMethod= ((MethodSignature) thisJoinPointStaticPart.getSignature()).getMethod();

        Throwable th = new Throwable();
        StackTraceElement[] stack = th.getStackTrace();
        int len=stack.length;

        //position [1,2] are closure to the tail recursive function added from the "around" advice in "TailRecursionClassAspect"
        if(len>=5 && stack[1].getMethodName().equals(stack[4].getMethodName())) return;

        if(timer.isRunning()) {
            counter++;
            System.out.println(String.format( "\t%sRecursive Call n°%3d to '%s()'. Execution continues: %s%s", ConsoleColors.YELLOW, counter, thisMethod.getName(), timer,ConsoleColors.RESET));
        }else{   //a bit verbose but helps to see  the time variation
            System.out.println(String.format( "\t%sExecution START: '%s()'. \n\t\t%sTimer START: %s%s",ConsoleColors.GREEN_BOLD, thisMethod.getName(), ConsoleColors.YELLOW, timer, ConsoleColors.RESET));
            timer.start();
            counter=0;
        }
    }

    after() returning: methodCall(){
        Method thisMethod= ((MethodSignature) thisJoinPointStaticPart.getSignature()).getMethod();

        Throwable th = new Throwable();
        StackTraceElement[] stack = th.getStackTrace();
        int len=stack.length;

        if(len>=5 && stack[1].getMethodName().equals(stack[4].getMethodName())) return;

        if(timer.isRunning())
            timer.stop();
        if(!timer.elapsed().isZero()) {
            System.out.println(String.format( "\t%sExecution END: '%s()'.%s \n\t\tTOTAL TIME: %s.%s", ConsoleColors.RED_BOLD, thisMethod.getName(), ConsoleColors.YELLOW, timer, ConsoleColors.RESET));
            if(counter>0 && thisMethod.getAnnotation(TailRecursion.class)!=null)
                System.out.println(String.format( "\t\t%sTOTAL STACK FRAMES SAVED: %3d%s", ConsoleColors.YELLOW,counter,ConsoleColors.RESET));

        }
        timer.reset();  //avoid creation of more StopWatches
    }
}
