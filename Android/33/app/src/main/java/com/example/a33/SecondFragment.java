package com.example.a33;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.NumberPicker;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.navigation.fragment.NavHostFragment;

import static com.example.a33.MainActivity.i;

public class SecondFragment extends Fragment {

    @Override
    public View onCreateView(
            LayoutInflater inflater, ViewGroup container,
            Bundle savedInstanceState
    ) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_second, container, false);
    }

    public void onViewCreated(@NonNull View view, Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        //number Picker settings
        NumberPicker np = view.findViewById(R.id.numberPicker);
        np.setMinValue(0);
        np.setMaxValue(70);
        np.setWrapSelectorWheel(true);

        view.findViewById(R.id.button_second).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                doFunc();
                NavHostFragment.findNavController(SecondFragment.this)
                        .navigate(R.id.action_SecondFragment_to_thirdFragment);
            }
        });
    }

    private void doFunc(){
        DatePicker dp = getView().findViewById(R.id.datePicker);
        NumberPicker np = getView().findViewById(R.id.numberPicker);
        EditText et = getView().findViewById(R.id.editName);

        int age = np.getValue();
        int day = dp.getDayOfMonth();
        int month = dp.getMonth();
        month += 1;
        int year = dp.getYear();

        i.age = age;
        i.day = day;
        i.month = month;
        i.year = year;
        i.name = et.getText().toString();
    }
}