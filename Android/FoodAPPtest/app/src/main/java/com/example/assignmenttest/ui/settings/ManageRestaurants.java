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
import android.widget.Button;
import android.widget.EditText;
import android.widget.TableLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.example.assignmenttest.R;
import com.example.assignmenttest.ui.DataBaseManager;
import com.example.assignmenttest.ui.MyRestaurantRecyclerViewAdapter;
import com.example.assignmenttest.ui.data.DataTransfer;
import com.example.assignmenttest.ui.data.DbIdTransfer;
import com.example.assignmenttest.ui.data.Session;
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.google.android.material.tabs.TabLayout;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link ManageRestaurants#newInstance} factory method to
 * create an instance of this fragment.
 */
public class ManageRestaurants extends Fragment {

    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";
    private static final String ARG_COLUMN_COUNT = "column-count";
    private int mColumnCount = 1;

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;

    public ManageRestaurants() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment ManageRestaurants.
     */
    // TODO: Rename and change types and number of parameters
    public static ManageRestaurants newInstance(String param1, String param2, int columnCount) {
        ManageRestaurants fragment = new ManageRestaurants();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        args.putInt(ARG_COLUMN_COUNT, columnCount);
        fragment.setArguments(args);
        return fragment;
    }
    // global view variables
    TableLayout tblL;
    TabLayout tl;
    TextView id;
    EditText n,s,l,m;
    DataBaseManager db;

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
        View view = inflater.inflate(R.layout.fragment_manage_restaurants, container, false);
        // Inflate the layout for this fragment
        Session fragment = new Session();
        fragment.thisFragment = "ManageRestaurants";
        return view;
    }


    public void onViewCreated (@NonNull View view, Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);


        id = (TextView)getActivity().findViewById(R.id.idValue);
        n = (EditText)getActivity().findViewById(R.id.addNameEdit);
        s = (EditText)getActivity().findViewById(R.id.addStyleEdit);
        l = (EditText)getActivity().findViewById(R.id.addLocationEdit);
        m = (EditText)getActivity().findViewById(R.id.addMinOrderEdit);
        tblL = (TableLayout)getActivity().findViewById(R.id.mResAddForm);
        tl = (TabLayout)getActivity().findViewById(R.id.mResTabLayout);
        db = new DataBaseManager(getActivity());


        Button add = (Button)getActivity().findViewById(R.id.mResAddFormAddBtn);
        RecyclerView rv = (RecyclerView)getActivity().findViewById(R.id.list);
        FloatingActionButton fa = (FloatingActionButton)getActivity().findViewById(R.id.delDB);
        Button takePhoto = (Button)getActivity().findViewById(R.id.addPhotosBtn);
        Button del = (Button)getActivity().findViewById(R.id.mResAddFormDltBtn);


        getActivity().findViewById(R.id.onClickEditChange).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                editChangeTab();
            }
        });

        if (mColumnCount <= 1) {
                rv.setLayoutManager(new LinearLayoutManager(getContext()));
            } else {
                rv.setLayoutManager(new GridLayoutManager(getContext(), mColumnCount));
            }
            rv.setAdapter(new MyRestaurantRecyclerViewAdapter(db.retrieveRowsRestaurantD()));

        rv.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Toast.makeText(getActivity(), "Text Clicked!", Toast.LENGTH_SHORT).show();
            }
        });

        tl.addOnTabSelectedListener(new TabLayout.OnTabSelectedListener() {


            @Override
            public void onTabSelected(TabLayout.Tab tab) {
                if(tab.getPosition() == 0) {
                    rv.setAdapter(new MyRestaurantRecyclerViewAdapter(db.retrieveRowsRestaurantD()));
                    rv.setVisibility(View.VISIBLE);
                }
                else {
                    if (tab.getPosition() == 1) {
                        add.setText("ADD");
                        clearFormFields();
                    }
                        else {
                            add.setText("UPDATE");
                            del.setVisibility(View.VISIBLE);
                    }
                    tblL.setVisibility(View.VISIBLE);
                }
            }

            @Override
            public void onTabUnselected(TabLayout.Tab tab) {
                if(tab.getPosition() == 0) rv.setVisibility(View.GONE);
                else{
                    tblL.setVisibility(View.GONE);
                    if(tab.getPosition() == 2) del.setVisibility(View.GONE);
                }
            }

            @Override
            public void onTabReselected(TabLayout.Tab tab) {

            }
        });

        add.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(add.getText().toString() == "ADD") addRestaurant();
                else updateRestaurant();
            }
        });

        fa.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(rv.getChildCount() < 1) {
                    resAdd(db);
                }
                else {
                    db.clearRecordsR();
                }
                rv.setAdapter(new MyRestaurantRecyclerViewAdapter(db.retrieveRowsRestaurantD()));
            }
        });

        takePhoto.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().findViewById(R.id.buttonMainPhoto).performClick();

                //Below code successfully turns on camera
                /*Intent takePictureIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
                try {
                    startActivityForResult(takePictureIntent, 1);
                } catch (ActivityNotFoundException e) {
                    // display error state to the user
                }*/
            }
        });

        del.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                deleteRestaurant();
            }
        });
    }

    private void addRestaurant(){

        DataBaseManager db = new DataBaseManager(getActivity());

        try {
            if(db.addRowRestaurant(n.getText().toString(),s.getText().toString(),l.getText().toString(), Float.parseFloat(m.getText().toString()), null)) {
                Toast.makeText(getActivity(), n.getText().toString() + " added.", Toast.LENGTH_SHORT).show();
                tl.selectTab(tl.getTabAt(0));
            }
        } catch (Exception e) {
            Toast.makeText(getActivity(), "Failed to Add Restaurant", Toast.LENGTH_SHORT).show();
        }
    }

    private void updateRestaurant(){
        String[] columns = new String[] {"name", "styleOfFood", "location", "minOrder"};
        String[] values = new String[] {n.getText().toString(), s.getText().toString(), l.getText().toString(), m.getText().toString()};
        int noRows = 0;
        try {
            noRows = db.updateRecord(DataBaseManager.DB_TABLE_RESTAURANT, columns, values, "id='" + id.getText().toString() + "'", null);
            tl.selectTab(tl.getTabAt(0));
            Toast.makeText(getActivity(), noRows + "restaurant updated", Toast.LENGTH_SHORT).show();
        } catch (Exception e) {
            Toast.makeText(getActivity(), "Updated Failed!", Toast.LENGTH_SHORT).show();
        }
    }

    private void deleteRestaurant() {
        int noRows = 0;
        try {
            noRows = db.deleteRecord(DataBaseManager.DB_TABLE_RESTAURANT, Integer.parseInt(id.getText().toString()));
            tl.selectTab(tl.getTabAt(0));
            Toast.makeText(getActivity(), noRows + "restaurant deleted", Toast.LENGTH_SHORT).show();
        } catch (Exception e) {
            Toast.makeText(getActivity(), "Delete Failed!", Toast.LENGTH_SHORT).show();
        }
    }

    private void resAdd(DataBaseManager db) {
        db.addRowRestaurant("Oporto","Fast Food", "Lakemba", (float)4.4, null);
        db.addRowRestaurant("House of thai","Thai", "Bankstown", (float)5.50, null);
        db.addRowRestaurant("Bubble Tea","Drinks", "Mt Druitt", (float)2.50, null);
    }

    private void editChangeTab(){
        DataTransfer dt = new DataTransfer();

        id.setText(Integer.toString(dt.id));
        n.setText(dt.name);
        s.setText(dt.style);
        l.setText(dt.location);
        m.setText(Float.toString(dt.minOrder));

        tl.selectTab(tl.getTabAt(2));
    }

    private void clearFormFields() {
        id.setText("");
        n.setText("");
        s.setText("");
        l.setText("");
        m.setText("");
    }

}