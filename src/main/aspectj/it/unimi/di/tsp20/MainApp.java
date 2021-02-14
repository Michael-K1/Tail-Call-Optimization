package it.unimi.di.tsp20;

import it.unimi.di.tsp20.TailCallOptimization.annotation.ExecutionTime;
import it.unimi.di.tsp20.TailCallOptimization.annotation.ShowStack;
import it.unimi.di.tsp20.TailCallOptimization.annotation.TailRecursion;

/**
 * Collection of Recursive Functions and comparison with Tail Recursive Functions with Tail Call Optimization
 */
public class MainApp {
    public static void main(String[] args) {
        MainApp ma =  new MainApp();

        System.out.println("tailFact(10)= "+ma.tailFact(10, 1));
        System.out.println("tailFactNotOptimized(10)= "+ma.tailFactNotOptimized(10, 1));
        System.out.println("fact(10)= "+ma.fact(10));
        System.out.println("tailFib(42)= "+ma.tailFib(42, 0, 1));
        System.out.println("fib(15)= "+ma.fib(15));
        System.out.println("arraySum( 2, 55, 1, 7, 10, 73, 5)= "+ma.arraySum(new int[]{ 2, 55, 1, 7, 10, 73, 5 }, 7, 0));

        System.out.println("isOdd(10)= "+ ma.is_odd(10));
        System.out.println("isEven(10)= "+ ma.is_even(10));
        System.out.println("isOdd(11)= "+ ma.is_odd(11));
        System.out.println("isEven(11)= "+ ma.is_even(11));
    }

    @ShowStack
    @ExecutionTime
    @TailRecursion
    private int tailFact(int n, int a){
        return n==1
                ? a
                :tailFact(n-1, a*n);
    }

    @ShowStack
    @ExecutionTime
    private int tailFactNotOptimized(int n, int a){
        return n==1
                ? a
                :tailFactNotOptimized(n-1, a*n);
    }

    @ShowStack
    @ExecutionTime
    private int fact(int n){
        return n==1
                ? 1
                :n*fact(n-1);
    }

    @ShowStack
    @ExecutionTime
    @TailRecursion
    private int tailFib(int n,  int prev, int next) {
        return n==0
                ?prev
                :n==1
                    ?next
                    :tailFib(n-1,next,prev+next);
    }
    @ShowStack
    @ExecutionTime
    private int fib(int n) {
        return n==0
                ?0
                :n==1
                ?1
                :fib(n-1)+fib(n-2);
    }

    @ShowStack
    @ExecutionTime
    @TailRecursion
    private int arraySum(int[] array, int size, int sum) {
        return size==0
                ?sum
                :arraySum(array, size - 1, sum + array[size - 1]);
    }

    @ShowStack
    @ExecutionTime
    @TailRecursion
    boolean is_even( int n) {
        return n == 0
                ?true
                : is_odd(n - 1);
    }

    @ShowStack
    @ExecutionTime
    @TailRecursion
    boolean is_odd(int n) {
        return n == 0
                ?false
                :is_even(n - 1);
    }
}
