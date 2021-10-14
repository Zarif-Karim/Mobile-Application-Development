package com.example.assignmenttest.ui.orders;

import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AlertDialog;
import androidx.fragment.app.Fragment;
import androidx.navigation.Navigation;
import androidx.navigation.fragment.NavHostFragment;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.example.assignmenttest.R;
import com.example.assignmenttest.ui.DataBaseManager;
import com.example.assignmenttest.ui.data.Session;
import com.google.android.material.snackbar.Snackbar;

public class OrdersFragment extends Fragment {


    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {
        View root = inflater.inflate(R.layout.fragment_orders, container, false);
        Session fragment = new Session();
        fragment.thisFragment = "OrdersFragment";

        Spinner s;
        s.setOnItemS
        return root;
    }

    public float getMultiplication(int toNumber) {

    }

    //globals
    RecyclerView rv;
    DataBaseManager db;
    Session sc;

    //Edi
    EditText t;
    CheckBox
    public void onViewCreated(@NonNull View view, Bundle savedInstanceState){
        super.onViewCreated(view, savedInstanceState);

        t = getActivity().findViewById(R.id.)
        db = new DataBaseManager(view.getContext());
        sc = new Session();

        // set Adapter
        rv = (RecyclerView) view.findViewById(R.id.orderList);
        rv.setLayoutManager(new LinearLayoutManager(view.getContext()));
        MyOrdersRecyclerViewAdapter morva = new MyOrdersRecyclerViewAdapter(db.retrieveBasket((sc.orderNo_current)));
        rv.setAdapter(morva);

        Button confirm = (Button)view.findViewById(R.id.ConfirmOrder);
        if(morva.getItemCount() < 1) confirm.setVisibility(View.GONE);
        else confirm.setVisibility(View.VISIBLE);
        confirm.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                AlertDialog.Builder alert = new AlertDialog.Builder(getActivity());
                alert.setTitle("Confim Order");
                alert.setMessage("Click Pay if you want to Place the order.");
                alert.setCancelable(true);
                alert.setPositiveButton("PAY", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        sc.orderNo_current = 0;
                        rv.setAdapter(new MyOrdersRecyclerViewAdapter(db.retrieveBasket(sc.orderNo_current)));
                        Snackbar.make(getView(),"Order has been sent!", Snackbar.LENGTH_LONG).setAction("Action",null).show();
                        NavHostFragment.findNavController(OrdersFragment.this).navigate(R.id.action_navigation_notifications_to_navigation_home);
                    }
                });
                alert.show();
            }
        });
    }
}