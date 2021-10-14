package com.example.tute32;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.CheckBox;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void click(View v) {
        RadioGroup r = findViewById(R.id.rg);
        RadioButton t, b, s;
        TextView tv;

        t = findViewById(R.id.tomato);
        b = findViewById(R.id.BBQ);
        s = findViewById(R.id.sc);
        tv = findViewById(R.id.output);

        String o = "Your sauce is ";

        if(t.isChecked()) o = o + "Tomato";
        if(b.isChecked()) o = o + "BBQ";
        if(s.isChecked()) o = o + "Sweet Chilli";

        tv.setText(o);
    }
}