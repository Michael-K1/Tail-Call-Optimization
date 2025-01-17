package it.unimi.di.tsp20.TailCallOptimization;

import it.unimi.di.tsp20.TailCallOptimization.annotation.ExecutionTime;
import com.google.common.base.Stopwatch;

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
    private String thisMethod=null;

    /**
     * Number of recursive calls inside the method.
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
        if(thisMethod==null) {
            thisMethod= thisJoinPointStaticPart.getSignature().toShortString();
        }

        if(timer.isRunning()) { //a bit verbose but helps to see  the time variation
            counter++;
            System.out.format( "\t%sRecursive Call n°%3d to '%s'. Execution continues: %s%s\n", ConsoleColors.YELLOW, counter, thisMethod, timer, ConsoleColors.RESET);
        }else{
            System.out.format( "\t%sExecution START: '%s'. \n\t\t%sTimer START: %s%s\n",ConsoleColors.GREEN_BOLD, thisMethod, ConsoleColors.YELLOW, timer, ConsoleColors.RESET);
            timer.start();
            counter=0;
        }
    }

    /*
     * Stops the timer after successfully returning from the execution of the function.
     */
    after() returning: methodCall(){

        if(timer.isRunning())
            timer.stop();
        if(!timer.elapsed().isZero()) {
            System.out.format( "\t%sExecution END: '%s'.%s \n\t\tTOTAL TIME: %s.\n\t\tTOTAL RECURSIVE CALLS: %3d%s\n", ConsoleColors.RED_BOLD, thisMethod, ConsoleColors.YELLOW, timer, counter, ConsoleColors.RESET);
            thisMethod=null;
        }
        timer.reset();  //avoid creation of more StopWatches
    }
}
