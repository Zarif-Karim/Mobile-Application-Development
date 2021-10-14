package com.example.sdapp;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void change(View v){
        TextView m = findViewById(R.id.mainTxt);
        TextView c = findViewById(R.id.inputTxt);
        m.setText(c.getText().toString());
    }

    public void calculate(View v) {
        TextView r = findViewById(R.id.radius);
        double rad = Double.parseDouble(r.getText().toString());
        double a = 3.142*rad*rad;

        TextView s = findViewById(R.id.area);
        s.setText("Area: " + a);
    }
}