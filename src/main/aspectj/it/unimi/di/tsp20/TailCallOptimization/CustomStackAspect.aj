package it.unimi.di.tsp20.TailCallOptimization;

import it.unimi.di.tsp20.TailCallOptimization.annotation.TailRecursion;
import org.aspectj.lang.Signature;
import java.util.Stack;

/**
 * Aspect that creates a custom, more efficient, Stack that helps the Tail Call Optimization Aspect. From each entry it is possible to get all the references
 * of the original method.
 */
public aspect CustomStackAspect {
    /**
     * Stack of Signature
     */
    public static Stack<Signature> customStack =new Stack<>();

    pointcut methodCall(): call(@TailRecursion * *.*(..)) && !within(*Aspect);

    before(): methodCall(){
        customStack.push( thisJoinPoint.getSignature());
    }

    after() : methodCall(){
        if(!customStack.isEmpty())
            customStack.pop();
    }


}
