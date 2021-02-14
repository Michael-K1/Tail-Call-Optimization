package it.unimi.di.tsp20;

public class MainApp {
    public String getGreeting(){return "Hello World!";}
    Throwable th;
    public static void main(String[] args) {
        MainApp ma =  new MainApp();

        System.out.println(ma.getGreeting());
        System.out.println("fact "+ma.tailFact(10, 1));
        System.out.println("fib "+ma.tailFib(42, 0, 1));


    }


    private int tailFact(int n, int a){ //tail recursive
        th=new Throwable();
        System.out.println("########################################################################");
        for (int x =0;x<th.getStackTrace().length;x++)
            System.out.println("\t "+x+" " +th.getStackTrace()[x]);
        return n==1
                ? a
                :tailFact(n-1, a*n);
    }


    private int tailFib(int n, int prev, int next) {
        return n==1
                ?next
                :tailFib(n-1, next, prev+next);

    }
}
