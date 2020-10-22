package com.guy.catan;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.TextView;
import android.widget.ToggleButton;

public class ResourcesActivity extends AppCompatActivity implements View.OnClickListener {

    private TextView woodAmount;
    private TextView wheatAmount;
    private TextView sheepAmount;
    private TextView brickAmount;
    private TextView ironAmount;
    private ToggleButton op;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_resources);
        this.op = findViewById(R.id.toggleButton);
        this.woodAmount = findViewById(R.id.woodAmount);
        this.wheatAmount = findViewById(R.id.wheatAmount);
        this.sheepAmount = findViewById(R.id.sheepAmount);
        this.brickAmount = findViewById(R.id.brickAmount);
        this.ironAmount = findViewById(R.id.ironAmount);
        findViewById(R.id.imageButton).setOnClickListener(this);
        findViewById(R.id.imageButton2).setOnClickListener(this);
        findViewById(R.id.imageButton3).setOnClickListener(this);
        findViewById(R.id.imageButton4).setOnClickListener(this);
        findViewById(R.id.imageButton5).setOnClickListener(this);
    }

    @Override
    public void onStart() {
        super.onStart();
        if (MainActivity.current != -1) {
            Player player = MainActivity.players.get(MainActivity.current);
            this.woodAmount.setText(player.wood + "");
            this.wheatAmount.setText(player.wheat + "");
            this.ironAmount.setText(player.iron + "");
            this.brickAmount.setText(player.brick + "");
            this.sheepAmount.setText(player.sheep + "");
        }
    }

    @Override
    public void onClick(View view) {
        Player player = MainActivity.players.get(MainActivity.current);
        int toAdd = this.op.isChecked() ? -1 : 1;
        switch(view.getId()) {
            case R.id.imageButton:
                player.brick += toAdd;
                if (player.brick < 0)
                    player.brick = 0;
                this.brickAmount.setText(player.brick + "");
                break;
            case R.id.imageButton2:
                player.iron += toAdd;
                if (player.iron < 0)
                    player.iron = 0;
                this.ironAmount.setText(player.iron + "");
                break;
            case R.id.imageButton3:
                player.sheep += toAdd;
                if (player.sheep < 0)
                    player.sheep = 0;
                this.sheepAmount.setText(player.sheep + "");
                break;
            case R.id.imageButton4:
                player.wheat += toAdd;
                if (player.wheat < 0)
                    player.wheat = 0;
                this.wheatAmount.setText(player.wheat + "");
                break;
            case R.id.imageButton5:
                player.wood += toAdd;
                if (player.wood < 0)
                    player.wood = 0;
                this.woodAmount.setText(player.wood + "");
                break;
        }
    }
}
