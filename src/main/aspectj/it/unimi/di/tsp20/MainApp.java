package it.unimi.di.tsp20;

public class MainApp {
    public String getGreeting(){return "Hello World!";}

    public static void main(String[] args) {
        MainApp ma =  new MainApp();

        System.out.println(ma.getGreeting());
        System.out.println("fact "+ma.fact(42));
        System.out.println("fib "+ma.fib(42));


    }

    public int fact(int n){
        return tailFact(n,1);
    }

    private int tailFact(int n, int a){ //tail recursive

        return n==1
                ?a
                :tailFact(n-1, a*n);
    }

    public int fib(int n){
        return tailFib(n, 0, 1);
    }

    private int tailFib(int n, int prev, int next) {
        return n==1
                ?next
                :tailFib(n-1, next, prev+next);

    }
}
