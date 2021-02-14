package it.unimi.di.tsp20.TailCallOptimization;

public class TailRecursionException extends RuntimeException{
    public final Object[] args;
    public final String method;


    public TailRecursionException(String method, Object[] a){
        this.method=method;
        this.args=a;

    }
}
