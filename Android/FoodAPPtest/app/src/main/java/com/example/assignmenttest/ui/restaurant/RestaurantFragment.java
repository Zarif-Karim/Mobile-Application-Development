package com.example.assignmenttest.ui.restaurant;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.example.assignmenttest.R;
import com.example.assignmenttest.ui.DataBaseManager;
import com.example.assignmenttest.ui.MyRestaurantRecyclerViewAdapter;
import com.example.assignmenttest.ui.data.DbIdTransfer;
import com.example.assignmenttest.ui.data.Session;

public class RestaurantFragment extends Fragment {

    private static final String ARG_COLUMN_COUNT = "column-count";
    private int mColumnCount = 1;

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {

        View root = inflater.inflate(R.layout.fragment_home, container, false);
        Session fragment = new Session();
        fragment.thisFragment = "RestaurantFragment";
        return root;
    }

    //Global Variables
    DataBaseManager db;
    RecyclerView rv;

    public void onViewCreated (@NonNull View view, Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        db = new DataBaseManager(getActivity());

        rv = (RecyclerView) getActivity().findViewById(R.id.homeList);
        rv.setLayoutManager(new GridLayoutManager(getContext(), mColumnCount));
        rv.setAdapter(new MyRestaurantRecyclerViewAdapter(db.retrieveRowsRestaurantD()));

    }

}