package it.unimi.di.tsp20;

public class TailRecursionException extends RuntimeException{
    public final Object[] args;

    public TailRecursionException(Object[] a){
        this.args=a;

    }
}
