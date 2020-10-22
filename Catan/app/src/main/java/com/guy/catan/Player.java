package com.guy.catan;

public class Player {
    int wood = 0;
    int brick = 0;
    int wheat = 0;
    int sheep = 0;
    int iron = 0;
    String name;
    double percentage = 0.0;
    boolean[] states = new boolean[]
            {false, false, false, false, false, false, false, false, false, false};

    public Player(String name) {
        this.name = name;
    }
}
