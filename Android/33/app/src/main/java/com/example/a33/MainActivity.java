package com.example.a33;

import android.os.Bundle;

import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.google.android.material.snackbar.Snackbar;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;

import android.view.View;

import android.view.Menu;
import android.view.MenuItem;
import android.widget.NumberPicker;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;

import org.w3c.dom.Text;

public class MainActivity extends AppCompatActivity {

    public static Info i = new Info();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        FloatingActionButton fab = findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG)
                        .setAction("Action", null).show();
            }
        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement

//        if (id == R.id.action_settings) {
//            return true;
//        }
        String o = "Your sauce is ";
        switch(id){
            case R.id.action_settings:
                return true;
            case R.id.tom:
                o = o + "Tomato";
                break;
            case R.id.bq:
                o = o + "BBQ";
                break;
            case R.id.sch:
                o = o + "Sweet Chilli";
                break;
            default:
                o = "";
        }
        TextView t = findViewById(R.id.output);
        t.setText(o);
        return super.onOptionsItemSelected(item);
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