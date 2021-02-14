package it.unimi.di.tsp20.TestEnv;

import it.unimi.di.tsp20.MainApp;
public aspect TestAspect {

    before(): call(String MainApp.getGreeting()){
        System.err.println("about to greet...");
    }
}
