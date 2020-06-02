package com.example.demo.controller;

public class Test {
    public static void main(String[] args) {
        //csnf='2020-05-01', yf='null', rq='null'
        String   str= "2020-05-01";
        String  temp = str.substring(0,4);
        String  temp1 = str.substring(5,7);
        String  temp2 = str.substring(8,10);
        System.err.println(temp+"dddd-----------"+temp1+"fff-------------"+temp2);

    }
}
