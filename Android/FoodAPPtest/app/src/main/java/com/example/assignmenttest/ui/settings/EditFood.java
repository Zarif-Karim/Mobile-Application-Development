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
import android.widget.EditText;
import android.widget.TableLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.example.assignmenttest.R;
import com.example.assignmenttest.ui.DataBaseManager;
import com.example.assignmenttest.ui.data.DataTransfer;
import com.example.assignmenttest.ui.data.DbIdTransfer;
import com.example.assignmenttest.ui.data.Session;
import com.google.android.material.tabs.TabLayout;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link EditFood#newInstance} factory method to
 * create an instance of this fragment.
 */
public class EditFood extends Fragment {

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

    public EditFood() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment EditFood.
     */
    // TODO: Rename and change types and number of parameters
    public static EditFood newInstance(String param1, String param2, int columnCount) {
        EditFood fragment = new EditFood();
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
        View view = inflater.inflate(R.layout.fragment_edit_food, container, false);

        Session fragment = new Session();
        fragment.thisFragment = "EditFood";

        TextView res = view.findViewById(R.id.eFoodResNameDisplay);
        TextView id = view.findViewById(R.id.eFoodResIdDisplay);
        DataTransfer dt = new DataTransfer();
        /*DbIdTransfer tr = new DbIdTransfer();
        Cursor c = db.getRow(DataBaseManager.DB_TABLE_RESTAURANT, tr.restaurant);*/
        id.setText(Integer.toString(dt.id));
        res.setText(dt.name);
        // Inflate the layout for this fragment
        return view;
    }

    //Globals
    DataBaseManager db;
    DbIdTransfer dtr;
    RecyclerView rv;
    EditText n,p;
    TextView r;
    TabLayout tl;
    TableLayout tbl;

    public void onViewCreated(@NonNull View view, Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        n = view.findViewById(R.id.mFoodAddName);
        p = view.findViewById(R.id.mFoodAddPrice);
        r = view.findViewById(R.id.mFoodAddResIDView);
        tl = view.findViewById(R.id.mFoodTabHeader);
        tbl = view.findViewById(R.id.mFoodAddFormTable);
        db = new DataBaseManager(getActivity());
        dtr = new DbIdTransfer();

        r.setText(Integer.toString(dtr.restaurant));

        // Set the adapter
         rv = (RecyclerView)view.findViewById(R.id.mFoodList);
         if (mColumnCount <= 1) {
                rv.setLayoutManager(new LinearLayoutManager(getContext()));
         } else {
                rv.setLayoutManager(new GridLayoutManager(getContext(), mColumnCount));
         }
         rv.setAdapter(new MyFoodRecyclerViewAdapter(db.retrieveRowsFood(dtr.restaurant)));

         //set up clear button
         view.findViewById(R.id.mFoodAddFormClearBtn).setOnClickListener(new View.OnClickListener() {
             @Override
             public void onClick(View v) {
                 n.setText("");
                 p.setText("");
             }
         });

         //set up add button
        view.findViewById(R.id.mFoodAddFormAddBtn).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                try {
                    if(db.addRowFood(n.getText().toString(), Float.parseFloat(p.getText().toString()), Integer.parseInt(r.getText().toString()), null)) {
                        Toast.makeText(getActivity(), n.getText().toString() + " added.", Toast.LENGTH_SHORT).show();
                        tl.selectTab(tl.getTabAt(0));
                        v.refreshDrawableState();
                    }
                } catch (Exception e) {
                    Toast.makeText(getActivity(), "Failed to Add Food", Toast.LENGTH_SHORT).show();
                }
            }
        });

        tl.addOnTabSelectedListener(new TabLayout.OnTabSelectedListener() {

            @Override
            public void onTabSelected(TabLayout.Tab tab) {
                if(tab.getPosition() == 0) {
                    rv.setAdapter(new MyFoodRecyclerViewAdapter(db.retrieveRowsFood(dtr.restaurant)));
                    rv.setVisibility(View.VISIBLE);
                }
                if (tab.getPosition() == 1) {
                    tbl.setVisibility(View.VISIBLE);
                 }

            }

            @Override
            public void onTabUnselected(TabLayout.Tab tab) {
                if(tab.getPosition() == 0) rv.setVisibility(View.GONE);
                else{
                    tbl.setVisibility(View.GONE);
                }
            }

            @Override
            public void onTabReselected(TabLayout.Tab tab) {

            }
        });

    }

    public void updateR() {
        int id = dtr.food;
        String[] columns = new String[] {"name", "price", "restaurant"};
        String[] values = new String[] {n.getText().toString(), p.getText().toString(), r.getText().toString()};
        int noRows = 0;
        try {
            noRows = db.updateRecord(DataBaseManager.DB_TABLE_FOOD, columns, values, "id='" + id + "'", null);
            tl.selectTab(tl.getTabAt(0));
            Toast.makeText(getActivity(), noRows + "restaurant updated", Toast.LENGTH_SHORT).show();
            rv.refreshDrawableState();
        } catch (Exception e) {
            Toast.makeText(getActivity(), "Updated Failed!", Toast.LENGTH_SHORT).show();
        }
    }

    private void deleteR() {
        int id = dtr.food;
        int noRows = 0;
        try {
            noRows = db.deleteRecord(DataBaseManager.DB_TABLE_FOOD, id);
            tl.selectTab(tl.getTabAt(0));
            Toast.makeText(getActivity(), noRows + "Food item deleted", Toast.LENGTH_SHORT).show();
            rv.refreshDrawableState();
        } catch (Exception e) {
            Toast.makeText(getActivity(), "Delete Failed!", Toast.LENGTH_SHORT).show();
        }
    }
}