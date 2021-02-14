package it.unimi.di.tsp20.TailCallOptimization;

import it.unimi.di.tsp20.TailCallOptimization.annotation.ExecutionTime;
import com.google.common.base.Stopwatch;
import org.aspectj.lang.reflect.MethodSignature;
import java.lang.reflect.Method;

public aspect ExecutionTimeAspect pertarget(methodCall()){
    private static final Stopwatch timer= Stopwatch.createUnstarted();
    private  Method thisMethod=null;
    private int counter;

    pointcut methodCall(): call(@ExecutionTime * *.*(..)) && !within(*Aspect);

    before(): methodCall() {
        if(thisMethod==null)
            thisMethod= ((MethodSignature) thisJoinPointStaticPart.getSignature()).getMethod();

        if(timer.isRunning()) { //a bit verbose but helps to see  the time variation
            counter++;
            System.out.println(String.format( "\t%sRecursive Call n°%3d to '%s()'. Execution continues: %s%s", ConsoleColors.YELLOW, counter, thisMethod.getName(), timer,ConsoleColors.RESET));
        }else{
            System.out.println(String.format( "\t%sExecution START: '%s()'. \n\t\t%sTimer START: %s%s",ConsoleColors.GREEN_BOLD, thisMethod.getName(), ConsoleColors.YELLOW, timer, ConsoleColors.RESET));
            timer.start();
            counter=0;
        }
    }

    after() returning: methodCall(){

        if(timer.isRunning())
            timer.stop();
        if(!timer.elapsed().isZero()) {
            System.out.println(String.format( "\t%sExecution END: '%s()'.%s \n\t\tTOTAL TIME: %s.%s", ConsoleColors.RED_BOLD, thisMethod.getName(), ConsoleColors.YELLOW, timer, ConsoleColors.RESET));
            thisMethod=null;
        }
        timer.reset();  //avoid creation of more StopWatches
    }
}
