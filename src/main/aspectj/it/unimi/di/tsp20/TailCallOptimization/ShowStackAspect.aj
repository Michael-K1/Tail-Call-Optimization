package it.unimi.di.tsp20.TailCallOptimization;

import it.unimi.di.tsp20.TailCallOptimization.annotation.ShowStack;

/**
 * Aspect that prints the stack of a method annotated with <i>@ShowStack</i>
 */
public aspect ShowStackAspect {

    pointcut tailRecExecution(): execution(@ShowStack * *.*(..)) && !within(*Aspect);  //execution() to show the stack INSIDE the called method
    
    before(): tailRecExecution(){

        Throwable th = new Throwable();
        StackTraceElement[] stack = th.getStackTrace();
        int len=stack.length;
        System.out.println(String.format("\t%s########################################################################\n\tStackTrace:%s", ConsoleColors.RED_BOLD, ConsoleColors.RESET));

        for (int x =1;x<len;x++){    //starts with 1 because [0] is the call to THIS BEFORE to show the stack
            String color= x%2==0
                    ?ConsoleColors.BLUE_BOLD
                    :ConsoleColors.CYAN_BOLD;
            System.out.println(String.format("\t\t %s%3d: %s%s", color, len-x-1, stack[x].getMethodName(), ConsoleColors.RESET));
        }

    }
}
