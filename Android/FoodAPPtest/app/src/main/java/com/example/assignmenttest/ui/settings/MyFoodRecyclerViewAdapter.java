package com.example.assignmenttest.ui.settings;

import androidx.appcompat.app.AppCompatActivity;
import androidx.cardview.widget.CardView;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.RecyclerView;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TableRow;
import android.widget.TextView;
import android.widget.Toast;

import com.example.assignmenttest.R;
import com.example.assignmenttest.ui.DataBaseManager;
import com.example.assignmenttest.ui.data.Content;
import com.example.assignmenttest.ui.data.DbIdTransfer;
import com.example.assignmenttest.ui.data.Session;
import com.google.android.material.tabs.TabLayout;


import java.util.List;

/**
 * {@link RecyclerView.Adapter} that can display a {@link com.example.assignmenttest.ui.data.Content.FoodItem}.
 * TODO: Replace the implementation with code for your data type.
 */
public class MyFoodRecyclerViewAdapter extends RecyclerView.Adapter<MyFoodRecyclerViewAdapter.ViewHolder> {

    private final List<Content.FoodItem> mValues;

    public MyFoodRecyclerViewAdapter(List<Content.FoodItem> items) {
        mValues = items;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.layout_format_food_list, parent, false);
        CardView c = view.findViewById(R.id.mFoodListMainCard);
        c.setCardElevation(25);
        c.setRadius(10);
        c.setPadding(3,5,3,5);

        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, int position) {
        holder.mItem = mValues.get(position);
        holder.mItemName.setText(mValues.get(position).name);
        holder.mItemPrice.setText(Float.toString(mValues.get(position).price));
        holder.mItemNameEdit.setText(mValues.get(position).name);
        holder.mItemPriceEdit.setText(Float.toString(mValues.get(position).price));
        holder.mItemRestaurantEdit.setText(Integer.toString(mValues.get(position).restaurant_id));

        holder.mView.setOnClickListener(v -> {
            AppCompatActivity activity = (AppCompatActivity)v.getContext();

            DbIdTransfer tr = new DbIdTransfer();
            DataBaseManager db = new DataBaseManager(v.getContext());
            Session s = new Session();
            if(s.thisFragment == "EditFood") {
                TabLayout tl = v.findViewById(R.id.mFoodTabHeader);
                TableRow editForm = (TableRow) v.findViewById(R.id.mFoodTSForm);
                if (editForm.getVisibility() == View.GONE) {
                    editForm.setVisibility(View.VISIBLE);
                } else editForm.setVisibility(View.GONE);

                tr.food = holder.mItem.id;

                Button update = (Button) v.findViewById(R.id.mFoodListUpdateBtnTest);
                //set up update button
                update.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        int id = tr.food;
                        String[] columns = new String[]{"name", "price", "restaurant"};
                        String[] values = new String[]{holder.mItemNameEdit.getText().toString(), holder.mItemPriceEdit.getText().toString(), holder.mItemRestaurantEdit.getText().toString()};
                        int noRows = 0;
                        try {
                            noRows = db.updateRecord(DataBaseManager.DB_TABLE_FOOD, columns, values, "id='" + id + "'", null);
                            Toast.makeText(activity, noRows + " food item updated", Toast.LENGTH_SHORT).show();
                        } catch (Exception e) {
                            Toast.makeText(activity, "Updated Failed!", Toast.LENGTH_SHORT).show();
                        }
                    }
                });

                //set up remove button
                activity.findViewById(R.id.mFoodListRmvBtn).setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        int id = tr.food;
                        int noRows = 0;
                        try {
                            noRows = db.deleteRecord(DataBaseManager.DB_TABLE_FOOD, id);
                            Toast.makeText(activity, noRows + " Food item deleted", Toast.LENGTH_SHORT).show();
                        } catch (Exception e) {
                            Toast.makeText(activity, "Delete Failed!", Toast.LENGTH_SHORT).show();
                        }
                    }
                });
            }
            else if(s.thisFragment == "FoodFragment"){
                ConstraintLayout editForm = (ConstraintLayout) v.findViewById(R.id.foodItemAddBasket);
                if (editForm.getVisibility() == View.GONE) {
                    editForm.setVisibility(View.VISIBLE);
                } else editForm.setVisibility(View.GONE);
                EditText q = (EditText)v.findViewById(R.id.itemQuantity);
                v.findViewById(R.id.itemAddBasketBtn).setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        int quantity = Integer.parseInt(q.getText().toString());
                        //add information to session
                        s.food_id = holder.mItem.id;
                        s.quantity_add = quantity;
                        s.food_price = holder.mItem.price;

                        try {
                            if(s.orderNo_current == 0)
                                s.orderNo_current = db.addOrder(tr.restaurant, s.USER, s.quantity_add * s.food_price, null);

                            s.basket_id = db.addToBasket((int)s.orderNo_current, s.food_id, s.quantity_add, null);
                            Toast.makeText(v.getContext(), "Successfully Added to Basket!", Toast.LENGTH_SHORT).show();
                        } catch (Exception e) {
                            Toast.makeText(v.getContext(), "Failed: Add to Basket!", Toast.LENGTH_SHORT).show();
                        }
                    }
                });
            }
            else if(s.thisFragment == "OrderFragment") {

            }
        });
    }

    @Override
    public int getItemCount() {
        return mValues.size();
    }

    public class ViewHolder extends RecyclerView.ViewHolder {
        public final View mView;
        public final TextView mItemName;
        public final TextView mItemPrice;
        public final EditText mItemNameEdit;
        public final EditText mItemPriceEdit;
        public final EditText mItemRestaurantEdit;
        public Content.FoodItem mItem;

        public ViewHolder(View view) {
            super(view);
            mView = view;
            mItemName = view.findViewById(R.id.mFoodListFName);
            mItemPrice = view.findViewById(R.id.mFoodListFPrice);
            mItemNameEdit = view.findViewById(R.id.mFoodEditFormName);
            mItemPriceEdit = view.findViewById(R.id.mFoodEditFormPrice);
            mItemRestaurantEdit = view.findViewById(R.id.mFoodEditFormRID);
        }

        @Override
        public String toString() {
            return super.toString() + " '" + mItemName.getText().toString() + "'";
        }
    }
}