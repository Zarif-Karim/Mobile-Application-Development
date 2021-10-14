package com.example.assignmenttest.ui.forYou;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

import com.example.assignmenttest.R;
import com.example.assignmenttest.ui.data.DbIdTransfer;
import com.example.assignmenttest.ui.data.Session;

public class DashboardFragment extends Fragment {

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {
        View root = inflater.inflate(R.layout.fragment_dashboard, container, false);
        Session fragment = new Session();
        fragment.thisFragment = "DashboardFragment";
        return root;
    }
}