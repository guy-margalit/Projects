package com.guy.catan;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    private LinearLayout list;
    private EditText nameBox;
    public static ArrayList<Player> players;
    public static int current = -1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        this.nameBox = findViewById(R.id.nameBox);
        this.list = findViewById(R.id.list);
        players = new ArrayList<>();
        findViewById(R.id.addPlayer).setOnClickListener(this);
    }

    private void addPlayer(String name) {
        final Player player = new Player(name);
        final Context context = this;
        players.add(player);
        Button button = new Button(this);
        button.setTextColor(Color.WHITE);
        button.setText(name);
        button.setTextSize(22);
        button.setBackground(getDrawable(R.drawable.rounded_blue));
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                current = players.indexOf(player);
                startActivity(new Intent(context, ProfileActivity.class));
            }
        });
        button.setOnLongClickListener(new View.OnLongClickListener() {
            @Override
            public boolean onLongClick(View view) {
                list.removeView(view);
                return true;
            }
        });
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
        params.setMargins(0, 0, 0, 25);
        button.setLayoutParams(params);
        list.addView(button);
    }

    @Override
    public void onClick(View view) {
        addPlayer(this.nameBox.getText().toString());
        this.nameBox.setText("");
    }
}
