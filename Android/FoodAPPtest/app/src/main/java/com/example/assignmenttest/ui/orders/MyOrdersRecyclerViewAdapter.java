package com.example.assignmenttest.ui.orders;

import androidx.appcompat.app.AppCompatActivity;
import androidx.navigation.Navigation;
import androidx.recyclerview.widget.RecyclerView;

import android.app.Activity;
import android.database.Cursor;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.example.assignmenttest.R;
import com.example.assignmenttest.ui.DataBaseManager;
import com.example.assignmenttest.ui.data.Content;
import com.example.assignmenttest.ui.data.Session;

import java.util.List;

/**
 * {@link RecyclerView.Adapter} that can display a {@link}.
 * TODO: Replace the implementation with code for your data type.
 */
public class MyOrdersRecyclerViewAdapter extends RecyclerView.Adapter<MyOrdersRecyclerViewAdapter.ViewHolder> {

    private final List<Content.Basket> mValues;


    public MyOrdersRecyclerViewAdapter(List<Content.Basket> items) {
        mValues = items;
    }
    DataBaseManager db;

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.layout_orders, parent, false);
        db = new DataBaseManager(view.getContext());
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, int position) {

        holder.mItem = mValues.get(position);


        String[] columns = new String[] {"name", "price"};
        Cursor c = db.getRow("Food", columns, holder.mItem.food);
        c.moveToFirst();
        holder.mName.setText(c.getString(0));
        holder.mPrice.setText("$ "+c.getFloat(1)*holder.mItem.quantity);
        holder.mQuantity.setText(Integer.toString(holder.mItem.quantity));

        holder.mView.setOnClickListener(v -> {
            v.findViewById(R.id.removeItemOrder).setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    try {
                        db.deleteRecord("Basket", holder.mItem.id);
                        Toast.makeText(v.getContext(),"Item Removed",Toast.LENGTH_SHORT).show();
                        Navigation.findNavController((Activity) v.getContext(),R.id.nav_host_fragment).navigate(R.id.action_navigation_notifications_self);
                    } catch (Exception e) {
                        Toast.makeText(v.getContext(),"Remove Failed",Toast.LENGTH_SHORT).show();
                    }
                }
            });
        });
    }

    @Override
    public int getItemCount() {
        return mValues.size();
    }

    public class ViewHolder extends RecyclerView.ViewHolder {
        public final View mView;
        public final TextView mName;
        public final TextView mPrice;
        public final EditText mQuantity;
        public Content.Basket mItem;

        public ViewHolder(View view) {
            super(view);
            mView = view;
            mName = (TextView) view.findViewById(R.id.nameFood);
            mPrice = (TextView) view.findViewById(R.id.priceFood);
            mQuantity = (EditText) view.findViewById(R.id.quantityOrders);
        }

        /*@Override
        public String toString() {
            return super.toString() + " '" + mContentView.getText() + "'";
        }*/
    }
}