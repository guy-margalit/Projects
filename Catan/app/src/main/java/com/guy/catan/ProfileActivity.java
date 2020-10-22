package com.guy.catan;

import androidx.appcompat.app.AppCompatActivity;
import androidx.cardview.widget.CardView;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

public class ProfileActivity extends AppCompatActivity implements View.OnClickListener {

    private TextView percentage;
    private TextView countWood;
    private TextView countWheat;
    private TextView countIron;
    private TextView countSheep;
    private TextView countBrick;
    private TextView title;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_profile);
        this.percentage = findViewById(R.id.percentage);
        this.percentage = findViewById(R.id.percentage);
        this.countWood = findViewById(R.id.countWood);
        this.countWheat = findViewById(R.id.countWheat);
        this.countBrick = findViewById(R.id.countBrick);
        this.countIron = findViewById(R.id.countIron);
        this.countSheep = findViewById(R.id.countSheep);
        this.title = findViewById(R.id.title);

        findViewById(R.id.cardViewPercentage).setOnClickListener(this);
        findViewById(R.id.resources).setOnClickListener(this);
    }

    @Override
    public void onStart() {
        super.onStart();
        if (MainActivity.current != -1) {
            Player player = MainActivity.players.get(MainActivity.current);
            this.countWood.setText(player.wood + "");
            this.countBrick.setText(player.brick + "");
            this.countSheep.setText(player.sheep + "");
            this.countIron.setText(player.iron + "");
            this.countWheat.setText(player.wheat + "");
            this.percentage.setText(player.percentage + "%");
            this.title.setText(player.name);
        }
    }

    @Override
    public void onClick(View view) {
        switch(view.getId()) {
            case R.id.cardViewPercentage:
                startActivity(new Intent(this, PercentageActivity.class));
                break;
            case R.id.resources:
                startActivity(new Intent(this, ResourcesActivity.class));
                break;
        }
    }
}
