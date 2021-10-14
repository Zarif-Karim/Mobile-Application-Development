package com.example.assignmenttest.ui.restaurant;

import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TableLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.example.assignmenttest.R;
import com.example.assignmenttest.ui.DataBaseManager;
import com.example.assignmenttest.ui.data.DataTransfer;
import com.example.assignmenttest.ui.data.DbIdTransfer;
import com.example.assignmenttest.ui.data.Session;
import com.example.assignmenttest.ui.settings.MyFoodRecyclerViewAdapter;
import com.google.android.material.tabs.TabLayout;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link FoodFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class FoodFragment extends Fragment {

    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";
    // TODO: Customize parameter argument names
    private static final String ARG_COLUMN_COUNT = "column-count";
    // TODO: Customize parameters
    private int mColumnCount = 1;

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;

    public FoodFragment() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment FoodFragment.
     */
    // TODO: Rename and change types and number of parameters
    public static FoodFragment newInstance(String param1, String param2, int columnCount) {
        FoodFragment fragment = new FoodFragment();
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
        Session fragment = new Session();
        fragment.thisFragment = "FoodFragment";
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_food, container, false);
    }

    //Globals
    DataBaseManager db;
    DbIdTransfer dtr;
    DataTransfer resDetails;
    RecyclerView rv;
    TextView r,id;

    public void onViewCreated(@NonNull View view, Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        db = new DataBaseManager(getActivity());
        dtr = new DbIdTransfer();
        resDetails = new DataTransfer();
        r = (TextView) view.findViewById(R.id.fFragRName);
        id = (TextView) view.findViewById(R.id.fFragRId);

        id.setText(Integer.toString(dtr.restaurant));
        r.setText(resDetails.name);

        // Set the adapter
        rv = (RecyclerView)view.findViewById(R.id.fFragList);
        if (mColumnCount <= 1) {
            rv.setLayoutManager(new LinearLayoutManager(getContext()));
        } else {
            rv.setLayoutManager(new GridLayoutManager(getContext(), mColumnCount));
        }
        rv.setAdapter(new MyFoodRecyclerViewAdapter(db.retrieveRowsFood(dtr.restaurant)));
    }

    private void addToCart(){
        Session sc = new Session();

        try {
            if(sc.orderNo_current == 0)
            sc.orderNo_current = db.addOrder(Integer.parseInt(id.getText().toString()), sc.USER, sc.quantity_add * sc.food_price, null);

            sc.basket_id = db.addToBasket((int)sc.orderNo_current, sc.food_id, sc.quantity_add, null);
            Toast.makeText(getActivity(), "Successfully Added to Basket!", Toast.LENGTH_SHORT).show();
        } catch (Exception e) {
            Toast.makeText(getActivity(), "Failed: Add to Basket!", Toast.LENGTH_SHORT).show();
        }
    }


}