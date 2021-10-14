package com.example.firstapp;

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

    public void change(View v) {
        TextView n = findViewById(R.id.name);
        TextView a = findViewById(R.id.age);
        TextView h = findViewById(R.id.height);
        TextView w = findViewById(R.id.weight);
        TextView r = findViewById(R.id.result);

        double age = Integer.parseInt(a.getText().toString());
        double height = Double.parseDouble(h.getText().toString());
        double weight = Double.parseDouble(w.getText().toString());

        double bmi = weight/height/height * 10000;
        String s = "Hello " + n.getText() + "\n" +
                "Your BMI value is: " + bmi + "\n";

        if( (age < 50 && (bmi >= 18 && bmi <= 25)) || (age >= 50 && (bmi >= 22 && bmi <= 26))) {
            r.setText(s + "You are in good condition");
        } else {
            r.setText(s + "You are not in good condition");
        }
    }
}