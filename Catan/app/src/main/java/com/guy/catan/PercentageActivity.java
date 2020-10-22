package com.guy.catan;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class PercentageActivity extends AppCompatActivity implements View.OnClickListener {

    private TextView text;
    private double[] odds = new double[]{2.78, 5.56, 8.33, 11.11, 13.89, 13.89, 11.11, 8.33, 5.56, 2.78};
    private Button[] numbers = new Button[10];

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_percentage);
        this.text = findViewById(R.id.text);
        this.numbers[0] = findViewById(R.id.two);
        this.numbers[1] = findViewById(R.id.three);
        this.numbers[2] = findViewById(R.id.four);
        this.numbers[3] = findViewById(R.id.five);
        this.numbers[4] = findViewById(R.id.six);
        this.numbers[5] = findViewById(R.id.eight);
        this.numbers[6] = findViewById(R.id.nine);
        this.numbers[7] = findViewById(R.id.ten);
        this.numbers[8] = findViewById(R.id.eleven);
        this.numbers[9] = findViewById(R.id.twelve);

    }

    @Override
    protected void onStart() {
        super.onStart();
        if (MainActivity.current != -1) {
            for (int i = 0; i < this.numbers.length; ++i) {
                this.numbers[i].setOnClickListener(this);
                if (MainActivity.players.get(MainActivity.current).states[i])
                    this.toggle(this.numbers[i], i);
            }
            this.text.setText(MainActivity.players.get(MainActivity.current).percentage + "%");
        }
    }

    private void updatePercentage(int num) {
        Player player = MainActivity.players.get(MainActivity.current);
        player.states[num] = !player.states[num];
        double odd = this.odds[num] * (player.states[num] ? 1 : -1);
        player.percentage = Math.round((player.percentage + odd) * 100.0) / 100.0;
        this.text.setText(player.percentage + "%");
    }

    private void toggle(Button button, int num) {
        if (MainActivity.players.get(MainActivity.current).states[num]) {
            button.setBackground(getDrawable(R.drawable.rounded_orange));
        } else {
            button.setBackground(getDrawable(R.drawable.rounded_blue));
        }
    }

    @Override
    public void onClick(View view) {
        Button button = (Button) view;
        switch (view.getId()) {
            case R.id.two:
                this.updatePercentage(0);
                this.toggle(button, 0);
                break;
            case R.id.three:
                this.updatePercentage(1);
                this.toggle(button, 1);
                break;
            case R.id.four:
                this.updatePercentage(2);
                this.toggle(button, 2);
                break;
            case R.id.five:
                this.updatePercentage(3);
                this.toggle(button, 3);
                break;
            case R.id.six:
                this.updatePercentage(4);
                this.toggle(button, 4);
                break;
            case R.id.eight:
                this.updatePercentage(5);
                this.toggle(button, 5);
                break;
            case R.id.nine:
                this.updatePercentage(6);
                this.toggle(button, 6);
                break;
            case R.id.ten:
                this.updatePercentage(7);
                this.toggle(button, 7);
                break;
            case R.id.eleven:
                this.updatePercentage(8);
                this.toggle(button, 8);
                break;
            case R.id.twelve:
                this.updatePercentage(9);
                this.toggle(button, 9);
                break;
        }
    }
}
