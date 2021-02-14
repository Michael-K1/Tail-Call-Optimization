package it.unimi.di.tsp20;

public class TailRecursionException extends RuntimeException{
    public final int n;
    public final int i;


    public TailRecursionException(int n, int i){
        this.n=n;
        this.i=i;
    }
}
