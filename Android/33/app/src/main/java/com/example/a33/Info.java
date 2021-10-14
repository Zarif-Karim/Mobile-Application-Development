package com.example.a33;

public class Info {
    public String name;
    public int age;
    public int day;
    public int month;
    public int year;

    public String getOutput() {
        return "Hello " + name + " your DoB is: " +day+"/"+month+"/"+year+" and your age is "+age;
    }
}
