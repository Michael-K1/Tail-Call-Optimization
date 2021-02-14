package it.unimi.di.tsp20;

public class MainApp {
    public String getGreeting(){return "Hello World!";}

    public static void main(String[] args) {
        MainApp ma =  new MainApp();

        System.out.println(ma.getGreeting());
        System.out.println("fact(10)= "+ma.tailFact(10, 1));
        System.out.println("fib(42)= "+ma.tailFib(42, 0, 1));

    }

    @TailRecursion
    private int tailFact(int n, int a){
        return n==1
                ? a
                :tailFact(n-1, a*n);
    }

    @TailRecursion
    private int tailFib(int n,  int prev, int next) {
        return n==0
                ?prev
                :n==1
                    ?next
                    :tailFib(n-1,next,prev+next);
    }


}
