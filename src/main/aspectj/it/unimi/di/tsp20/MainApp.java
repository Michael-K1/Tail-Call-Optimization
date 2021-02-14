package it.unimi.di.tsp20;

public class MainApp {
    public String getGreeting(){return "Hello World!";}
    Throwable th;
    public static void main(String[] args) {
        MainApp ma =  new MainApp();

        System.out.println(ma.getGreeting());
        System.out.println("fact "+ma.tailFact(new Object[]{10, 1}));
        System.out.println("fib "+ma.tailFib(42, 0, 1));


    }

    @TailRecursion
    private int tailFact(Object[]args){ //tail recursive
        th=new Throwable();
        System.out.println("########################################################################");
        for (int x =0;x<th.getStackTrace().length;x++)
            System.out.println("\t "+x+" " +th.getStackTrace()[x]);
        int n= (int) args[0];
        int a= (int) args[1];
        args[0]=n-1;
        args[1]=n*a;
        return n==1
                ? a
                :tailFact(args);
    }


    private int tailFib(int n, int prev, int next) {

        return n==0
                ?prev
                :n==1
                    ?next
                    :tailFib(n-1, next, prev+next);

    }
}
