package com.example.tute31;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.CheckBox;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void click(View v) {
        CheckBox h, p, a, o;
        TextView tv;

        h = findViewById(R.id.ham);
        p = findViewById(R.id.pineapple);
        a = findViewById(R.id.anchovies);
        o = findViewById(R.id.olives);
        tv = findViewById(R.id.output);

        StringBuilder s = new StringBuilder();
        s.append("Your toppings are ");

        if(h.isChecked()) s.append("Ham,");
        if(p.isChecked()) s.append("Pineapple,");
        if(a.isChecked()) s.append("Anchovies,");
        if(o.isChecked()) s.append("Olives.");

        String output = s.toString();

        if(output.length() <= 18) tv.setText("");
        else {
            tv.setText(output);
        }

    }
}