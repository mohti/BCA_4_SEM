package com.example.bca4sem;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

import android.os.Bundle;
import android.view.MenuItem;

import com.google.android.material.bottomnavigation.BottomNavigationView;

public class Home extends AppCompatActivity {
BottomNavigationView BNV;
int flag=0;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);
        BNV=findViewById(R.id.Bottom_navigation);
        loadFragment(new computer_architecture());
        BNV.setOnNavigationItemSelectedListener(new BottomNavigationView.OnNavigationItemSelectedListener() {
            @Override
            public boolean onNavigationItemSelected(@NonNull MenuItem item) {

                int id = item.getItemId();

                if (id==R.id.item1){
                    //vb.net
                    loadFragment(new vbnet_fragment());

                } else if (id==R.id.item2){
                    //conum
                    loadFragment(new conam_fragment());

                } else if (id==R.id.item3){
                 //os
                    loadFragment(new os_fragment()  );

                } else if (id==R.id.item4){
                    //graphics
                    loadFragment(new graphics_fragment());

                } else if (id==R.id.item5){
                    //coa
                    loadFragment(new computer_architecture());
                }
                return true;
            }
        });



    }

    private void loadFragment(Fragment fragment) {

        FragmentManager fm = getSupportFragmentManager();
        FragmentTransaction ft = fm.beginTransaction();
        if(flag==0) {
            flag++;
            ft.add(R.id.fragment, fragment);
        }


        else
            ft.replace(R.id.fragment,fragment);

        ft.commit();
    }
}
