package it.unimi.di.tsp20;
import com.google.common.base.Stopwatch;
import org.aspectj.lang.reflect.MethodSignature;

public aspect CheckExecutionTimeAspect pertarget(methodCall()){
    public Stopwatch timer= Stopwatch.createUnstarted();
    pointcut methodCall(): call(* *.*(..)) ;

    before(): methodCall() && !cflowbelow(methodCall()){
        MethodSignature thisMethod=(MethodSignature) thisJoinPointStaticPart.getSignature();
        MethodSignature enclosingMethod=(MethodSignature) thisEnclosingJoinPointStaticPart.getSignature();

        if(enclosingMethod.getMethod().equals(thisMethod.getMethod()))return;

        if(!timer.isRunning()) {
            System.out.println(thisMethod.getName()+" execution started: "+timer);
            timer.start();
        }else
            System.out.println("Recursive Call to "+thisMethod.getName()+". Execution continues: "+timer);
    }

    after() returning: methodCall() && !cflowbelow(methodCall()){
        MethodSignature thisMethod=(MethodSignature) thisJoinPointStaticPart.getSignature();
        MethodSignature enclosingMethod=(MethodSignature) thisEnclosingJoinPointStaticPart.getSignature();

        if(enclosingMethod.getMethod().equals(thisMethod.getMethod())) return;

        timer.stop();

        System.out.println(thisMethod.getName()+" execution Time: "+timer);
        timer.reset();
    }
}
