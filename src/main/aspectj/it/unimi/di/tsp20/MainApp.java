package it.unimi.di.tsp20;

public class MainApp {
    public String getGreeting(){return "Hello World!";}
    Throwable th;
    public static void main(String[] args) {
        MainApp ma =  new MainApp();

        System.out.println(ma.getGreeting());
        System.out.println("fact "+ma.tailFact(new Object[]{10, 1}));
        System.out.println("fib "+ma.tailFib(new Object[]{42, 0, 1}));

    }

    @TailRecursion
    private int tailFact(Object[]args){

        int n= (int) args[0];
        int a= (int) args[1];
        args[0]=n-1;            //avoid creation of Obj and clogging the HEAP
        args[1]=n*a;
        return n==1
                ? a
                :tailFact(args);
    }

    @TailRecursion
    private int tailFib(Object[] args) {

        int n= (int) args[0];
        int prev= (int) args[1];
        int next= (int) args[2];

        args[0]=n-1;
        args[1]=next;
        args[2]=prev+next;

        return n==0
                ?prev
                :n==1
                    ?next
                    :tailFib(args);
    }


}
