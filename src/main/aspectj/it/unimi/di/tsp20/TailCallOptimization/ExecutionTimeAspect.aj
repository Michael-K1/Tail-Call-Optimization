package it.unimi.di.tsp20.TailCallOptimization;

import it.unimi.di.tsp20.TailCallOptimization.annotation.ExecutionTime;
import com.google.common.base.Stopwatch;
import org.aspectj.lang.reflect.MethodSignature;
import java.lang.reflect.Method;

/**
 * Aspect that logs the execution time of function annotated with <i>@ExecutionTime</i>.
 */
public aspect ExecutionTimeAspect pertarget(methodCall()){

    /**
     * Timer that tracks the execution time of the function.
     */
    private static final Stopwatch timer= Stopwatch.createUnstarted();

    /**
     * Reference to the method whose execution time is being recorded.
     */
    private Method thisMethod=null;

    /**
     * Number of recursive call inside the method.
     */
    private int counter;

    /*
     *  Pointcut that catches every call to a function annotated with <i>@ExecutionTime</i>.
     */
    pointcut methodCall(): call(@ExecutionTime * *.*(..)) && !within(*Aspect);

    /*
     * Starts the timer before the first call to the function.
     */
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

    /*
     * Stops the timer after the execution of the function.
     */
    after() returning: methodCall(){

        if(timer.isRunning())
            timer.stop();
        if(!timer.elapsed().isZero()) {
            System.out.println(String.format( "\t%sExecution END: '%s()'.%s \n\t\tTOTAL TIME: %s.\n\t\tTOTAL RECURSIVE CALLS: %3d%s", ConsoleColors.RED_BOLD, thisMethod.getName(), ConsoleColors.YELLOW, timer, counter, ConsoleColors.RESET));
            thisMethod=null;
        }
        timer.reset();  //avoid creation of more StopWatches
    }
}
