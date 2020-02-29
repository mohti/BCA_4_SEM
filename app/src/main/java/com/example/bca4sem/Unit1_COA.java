package com.example.bca4sem;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.text.method.ScrollingMovementMethod;
import android.widget.TextView;

public class Unit1_COA extends AppCompatActivity {
TextView textView;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_unit1__co);
       int inter=15;
        textView=findViewById(R.id.txt);
textView.setMovementMethod(new ScrollingMovementMethod());
    }
}
