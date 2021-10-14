package com.example.assignmenttest.ui;

import androidx.appcompat.app.AppCompatActivity;
import androidx.navigation.Navigation;
import androidx.recyclerview.widget.RecyclerView;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

import com.example.assignmenttest.R;
import com.example.assignmenttest.ui.data.Content.DummyItem;
import com.example.assignmenttest.ui.data.DataTransfer;
import com.example.assignmenttest.ui.data.DbIdTransfer;

import java.util.List;

/**
 * {@link RecyclerView.Adapter} that can display a {@link DummyItem}.
 * TODO: Replace the implementation with code for your data type.
 */
public class MyRestaurantRecyclerViewAdapter extends RecyclerView.Adapter<MyRestaurantRecyclerViewAdapter.ViewHolder> {

    private final List<DummyItem> mValues;

    public MyRestaurantRecyclerViewAdapter(List<DummyItem> items) {
        mValues = items;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.fragment_restaurant_list, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, int position) {
        holder.mItem = mValues.get(position);
        holder.mIdView.setText(holder.mItem.name);
        holder.mContentView.setText(holder.mItem.style);
        holder.mContentView2.setText(holder.mItem.location);
        holder.mContentView3.setText(Float.toString(holder.mItem.min));

        /*holder.mView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Toast.makeText(v.getContext(), holder.mItem.name, Toast.LENGTH_SHORT).show();
                DataTransfer dt = new DataTransfer();
                dt.name = holder.mItem.name;
                dt.style = holder.mItem.style;
                dt.location = holder.mItem.location;
                dt.minOrder = holder.mItem.min;

                NavHostFragment.findNavController().navigate(R.id.action_manageRestaurants_to_editRestaurant);
            }
        });*/

        holder.mView.setOnClickListener(v -> {
            Toast.makeText(v.getContext(), holder.mItem.name, Toast.LENGTH_SHORT).show();

            DataTransfer dt = new DataTransfer();
            DbIdTransfer dbt = new DbIdTransfer();

            dt.id = holder.mItem.id;
            dt.name = holder.mItem.name;
            dt.style = holder.mItem.style;
            dt.location = holder.mItem.location;
            dt.minOrder = holder.mItem.min;

            dbt.restaurant = holder.mItem.id;

           AppCompatActivity activity = (AppCompatActivity)v.getContext();
           if(activity.findViewById(R.id.onClickEditChange) != null) //if in Restaurant Manage Page
               activity.findViewById(R.id.onClickEditChange).performClick();
           if(activity.findViewById(R.id.mFoodTitle) != null) //if in Food Manage Page
               Navigation.findNavController(activity, R.id.nav_host_fragment).navigate(R.id.action_manageFood_to_editFood);
            if(activity.findViewById(R.id.homeList) != null) //if in Food Manage Page
                Navigation.findNavController(activity, R.id.nav_host_fragment).navigate(R.id.action_navigation_home_to_foodFragment);
        });
    }

    @Override
    public int getItemCount() {
        return mValues.size();
    }

    public class ViewHolder extends RecyclerView.ViewHolder {
        public final View mView;
        public final TextView mIdView;
        public final TextView mContentView;
        public final TextView mContentView2;
        public final TextView mContentView3;
        public DummyItem mItem;

        public ViewHolder(View view) {
            super(view);
            mView = view;
            mIdView = (TextView) view.findViewById(R.id.item_number);
            mContentView = (TextView) view.findViewById(R.id.content);
            mContentView2 = (TextView) view.findViewById(R.id.content2);
            mContentView3 = (TextView) view.findViewById(R.id.content3);
        }

        @Override
        public String toString() {
            return super.toString() + " '" + mContentView.getText() + "'";
        }
    }
}