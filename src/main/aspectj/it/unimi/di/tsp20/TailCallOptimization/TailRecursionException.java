package it.unimi.di.tsp20.TailCallOptimization;

/**
 * Exception that helps in handling the tail recursion.
 */
public class TailRecursionException extends RuntimeException{
    public final Object[] args;
    public final String method;


    /**
     * @param method Full canonical name of the method with returnType and parameterType.<br>
     *          (i.e. returnType org.foo.bar.methodName(parameterType1, parameterType2))
     * @param a Array of parameters of the Tail Recursive function.
     */
    public TailRecursionException(String method, Object[] a){
        this.method=method;
        this.args=a;

    }
}
