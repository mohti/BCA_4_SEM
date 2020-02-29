package com.example.bca4sem;


import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import com.example.bca4sem.adapter.RecycleViewAdapter;

import java.util.ArrayList;


/**
 * A simple {@link Fragment} subclass.
 */
public class computer_architecture extends Fragment {
private RecyclerView recyclerView;
ArrayList<suitCaseAdapter> arrlist =new ArrayList<>();
    public computer_architecture() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_computer_architecture, container, false);

        recyclerView=view.findViewById(R.id.recyleView_com_arch);

       addData(R.drawable.ic_launcher_background,"COA UNIT 1");
        addData(R.drawable.ic_launcher_background,"COA UNIT 2");
        addData(R.drawable.ic_launcher_background,"COA UNIT 3");
        addData(R.drawable.ic_launcher_background,"COA UNIT 4");
        addData(R.drawable.ic_launcher_background,"COA UNIT 5");

        RecycleViewAdapter adapter= new RecycleViewAdapter(view.getContext(),arrlist);


        LinearLayoutManager linearLayoutManager=new LinearLayoutManager(view.getContext(),LinearLayoutManager.VERTICAL,false);

      recyclerView.setLayoutManager(linearLayoutManager);

       recyclerView.setAdapter(adapter);

        return view;
    }
    public void addData(int image, String name){

        suitCaseAdapter suitCaseAdapter = new suitCaseAdapter(image,name);
        suitCaseAdapter.image=image;
        suitCaseAdapter.name=name;
        arrlist.add(suitCaseAdapter);

    }

}
