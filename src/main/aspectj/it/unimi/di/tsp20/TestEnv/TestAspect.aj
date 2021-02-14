package it.unimi.di.tsp20.TestEnv;

public aspect TestAspect {

    before(): call(java.lang.String it.unimi.di.tsp20.MainApp.getGreeting()){
        System.err.println("about to greet...");
    }
}
