package com.example.assignmenttest.ui.settings;

import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;
import android.widget.Toast;

import com.example.assignmenttest.R;
import com.example.assignmenttest.ui.DataBaseManager;
import com.example.assignmenttest.ui.MyRestaurantRecyclerViewAdapter;
import com.example.assignmenttest.ui.data.DbIdTransfer;
import com.example.assignmenttest.ui.data.Session;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link ManageFood#newInstance} factory method to
 * create an instance of this fragment.
 */
public class ManageFood extends Fragment {

    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";
    private static final String ARG_COLUMN_COUNT = "column-count";
    private int mColumnCount = 1;

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;

    public ManageFood() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment ManageFood.
     */
    // TODO: Rename and change types and number of parameters
    public static ManageFood newInstance(String param1, String param2, int columnCount) {
        ManageFood fragment = new ManageFood();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        args.putInt(ARG_COLUMN_COUNT, columnCount);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
            mColumnCount = getArguments().getInt(ARG_COLUMN_COUNT);
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_manage_food, container, false);
        Session fragment = new Session();
        fragment.thisFragment = "ManageFood";
        return view;
    }

    //Global Variables
    DataBaseManager db;
    RecyclerView rv;

    public void onViewCreated (@NonNull View view, Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        db = new DataBaseManager(getActivity());

        rv = (RecyclerView) getActivity().findViewById(R.id.mFoodResList);
        if (mColumnCount <= 1) {
            rv.setLayoutManager(new LinearLayoutManager(getContext()));
        } else {
            rv.setLayoutManager(new GridLayoutManager(getContext(), mColumnCount));
        }
        rv.setAdapter(new MyRestaurantRecyclerViewAdapter(db.retrieveRowsRestaurantD()));
    }

}