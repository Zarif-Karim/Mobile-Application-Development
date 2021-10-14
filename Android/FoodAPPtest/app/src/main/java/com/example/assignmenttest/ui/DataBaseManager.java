package com.example.assignmenttest.ui;

import android.database.sqlite.SQLiteDatabase;
import android.content.Context;
import android.content.ContentValues;
import android.database.Cursor;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

import com.example.assignmenttest.ui.data.Content;

import java.util.ArrayList;

public class DataBaseManager {

    public static final String DB_NAME = "FoodFest";
    public static final String DB_TABLE_RESTAURANT = "Restaurant";
    public static final String DB_TABLE_USER = "User";
    public static final String DB_TABLE_FOOD = "Food";
    public static final String DB_TABLE_ORDERS = "Orders";
    public static final String DB_TABLE_BASKET = "Basket";
    public static final int DB_VERSION = 1;
    private static final String CREATE_TABLE_RESTAURANT = "CREATE TABLE " + DB_TABLE_RESTAURANT + " (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, styleOfFood TEXT, location TEXT, minOrder FLOAT);";
    private static final String CREATE_TABLE_USER = "CREATE TABLE " + DB_TABLE_USER + " (id INTEGER PRIMARY KEY AUTOINCREMENT, fName TEXT, lName TEXT, age INTEGER, payMethod TEXT);";
    private static final String CREATE_TABLE_FOOD = "CREATE TABLE " + DB_TABLE_FOOD + " (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, price INTEGER, restaurant INTEGER REFERENCES " + DB_TABLE_RESTAURANT +"(id), image TEXT);";
    private static final String CREATE_TABLE_ORDERS = "CREATE TABLE " + DB_TABLE_ORDERS + " (id INTEGER PRIMARY KEY AUTOINCREMENT, restaurant INTEGER REFERENCES " + DB_TABLE_RESTAURANT +"(id), user INTEGER REFERENCES "+ DB_TABLE_USER +"(id), totalPrice INTEGER);";
    private static final String CREATE_TABLE_BASKET = "CREATE TABLE " + DB_TABLE_BASKET + " (id INTEGER PRIMARY KEY AUTOINCREMENT, orders INTEGER REFERENCES "+ DB_TABLE_ORDERS+"(id), food INTEGER REFERENCES "+DB_TABLE_FOOD+"(id), quantity INTEGER);";
    private SQLHelper helper;
    private SQLiteDatabase db;
    private Context context;

    public DataBaseManager(Context c) {
        this.context = c;
        helper = new SQLHelper(c);
        this.db = helper.getWritableDatabase();
    }

    public DataBaseManager openReadable() throws android.database.SQLException {
        helper = new SQLHelper(context);
        db = helper.getReadableDatabase();
        return this;
    }

    public void close() {
        helper.close();
    }

    public boolean addRowRestaurant(String name, String style, String location, Float min, Integer id) {
        synchronized(this.db) {

            ContentValues newProduct = new ContentValues();
            if(id != null) newProduct.put("id", id);
            newProduct.put("name", name);
            newProduct.put("StyleOfFood", style);
            newProduct.put("location", location);
            newProduct.put("minOrder", min);
            try {
                db.insertOrThrow(DB_TABLE_RESTAURANT, null, newProduct);
            } catch (Exception e) {
                Log.e("Error in inserting rows", e.toString());
                e.printStackTrace();
                return false;
            }
            //db.close();
            return true;
        }
    }

    public boolean addRowFood(String name, float price, int res, Integer id) {
        synchronized(this.db) {

            ContentValues newProduct = new ContentValues();
            if(id != null) newProduct.put("id", id);
            newProduct.put("name", name);
            newProduct.put("price", price);
            newProduct.put("restaurant", res);

            try {
                db.insertOrThrow(DB_TABLE_FOOD, null, newProduct);
            } catch (Exception e) {
                Log.e("Error in inserting rows", e.toString());
                e.printStackTrace();
                return false;
            }
            //db.close();
            return true;
        }
    }

    public long addOrder(int res, int user, float price, Integer id){
        synchronized (this.db) {
            ContentValues newProduct = new ContentValues();
            if(id != null) newProduct.put("id", id);
            newProduct.put("restaurant", res);
            newProduct.put("user", user);
            newProduct.put("totalPrice", price);
            long rVal;
            try {
               rVal = db.insertOrThrow(DB_TABLE_ORDERS, null, newProduct);
            } catch (Exception e) {
                Log.e("Error in inserting rows", e.toString());
                e.printStackTrace();
                return -1;
            }
            //db.close();
            return rVal;
        }
    }

    public long addToBasket(int orders, int food, int quantity, Integer id){
        synchronized (this.db) {
            ContentValues newProduct = new ContentValues();
            if(id != null) newProduct.put("id", id);
            newProduct.put("orders", orders);
            newProduct.put("food", food);
            newProduct.put("quantity", quantity);
            long rVal;
            try {
                rVal = db.insertOrThrow(DB_TABLE_BASKET, null, newProduct);
            } catch (Exception e) {
                Log.e("Error in inserting rows", e.toString());
                e.printStackTrace();
                return -1;
            }
            //db.close();
            return rVal;
        }
    }

//    public boolean addRow(Integer c, String n, Float p) {
//        synchronized(this.db) {
//
//            ContentValues newProduct = new ContentValues();
//            newProduct.put("code", c);
//            newProduct.put("product_name", n);
//            newProduct.put("price", p);
//            try {
//                db.insertOrThrow(DB_TABLE, null, newProduct);
//            } catch (Exception e) {
//                Log.e("Error in inserting rows", e.toString());
//                e.printStackTrace();
//                return false;
//            }
//            //db.close();
//            return true;
//        }
//    }
    public Cursor getRow(String table, String[] columns, int id) {
        return db.query(table, columns, "id = " +id, null, null, null, null);
    }

    public ArrayList<String> retrieveRowsRestaurant() {
        ArrayList<String> productRows = new ArrayList<String>();
        String[] columns = new String[] {"id", "name", "styleOfFood", "location", "minOrder"};
        Cursor cursor = db.query(DB_TABLE_RESTAURANT, columns, null, null, null, null, null);
        cursor.moveToFirst();
        while (cursor.isAfterLast() == false) {
            productRows.add(Integer.toString(cursor.getInt(0)) + ", " + cursor.getString(1) + ", " + Float.toString(cursor.getFloat(2)));
            cursor.moveToNext();
        }
        if (cursor != null && !cursor.isClosed()) {
            cursor.close();
        }
        return productRows;
    }

    public ArrayList<Content.DummyItem> retrieveRowsRestaurantD() {
        ArrayList<Content.DummyItem> productRows = new ArrayList<Content.DummyItem>();
        String[] columns = new String[] {"id", "name", "styleOfFood", "location", "minOrder"};
        Cursor cursor = db.query(DB_TABLE_RESTAURANT, columns, null, null, null, null, null);
        cursor.moveToFirst();
        while (cursor.isAfterLast() == false) {
            productRows.add(new Content.DummyItem(cursor.getInt(0), cursor.getString(1), cursor.getString(2), cursor.getString(3), cursor.getFloat(4) ));
            cursor.moveToNext();
        }
        if (cursor != null && !cursor.isClosed()) {
            cursor.close();
        }
        return productRows;
    }

    public ArrayList<Content.FoodItem> retrieveRowsFood(int id) {
        ArrayList<Content.FoodItem> productRows = new ArrayList<Content.FoodItem>();
        String[] columns = new String[] {"id", "name", "price", "restaurant"};
        Cursor cursor = db.query(DB_TABLE_FOOD, columns, "restaurant = "+id, null, null, null, null);
        cursor.moveToFirst();
        while (cursor.isAfterLast() == false) {
            productRows.add(new Content.FoodItem(cursor.getInt(0), cursor.getString(1), cursor.getFloat(2), cursor.getInt(3)));
            cursor.moveToNext();
        }
        if (cursor != null && !cursor.isClosed()) {
            cursor.close();
        }
        return productRows;
    }

    public ArrayList<Content.Basket> retrieveBasket(long id) {
        ArrayList<Content.Basket> productRows = new ArrayList<Content.Basket>();
        String[] columns = new String[] {"id", "orders", "food", "quantity"};
        Cursor cursor = db.query(DB_TABLE_BASKET, columns, "orders = "+id, null, null, null, null);
        cursor.moveToFirst();
        while (cursor.isAfterLast() == false) {
            productRows.add(new Content.Basket(cursor.getInt(0), cursor.getInt(1), cursor.getInt(2), cursor.getInt(3)));
            cursor.moveToNext();
        }
        if (cursor != null && !cursor.isClosed()) {
            cursor.close();
        }
        return productRows;
    }



    public void clearRecordsR()
    {
        db = helper.getWritableDatabase();
        db.delete(DB_TABLE_RESTAURANT, null, null);
    }

    public int updateRecord(String table, String[] colName, String[] colValue, String whereClause, String[] whereArgs)
    {
        db = helper.getWritableDatabase();
        ContentValues values = new ContentValues();
        for(int i = 0; i < colName.length; i++) {
            values.put(colName[i], colValue[i]);
        }
        return db.update(table, values, whereClause, whereArgs);
    }

    public int deleteRecord(String table, int id){
        return db.delete(table, "id="+id,null);
    }

    public class SQLHelper extends SQLiteOpenHelper {
        public SQLHelper (Context c) {
            super(c, DB_NAME, null, DB_VERSION);
        }

        @Override
        public void onCreate(SQLiteDatabase db) {

            db.execSQL(CREATE_TABLE_RESTAURANT);
            db.execSQL(CREATE_TABLE_USER);
            db.execSQL(CREATE_TABLE_FOOD);
            db.execSQL(CREATE_TABLE_ORDERS);
            db.execSQL(CREATE_TABLE_BASKET);
        }

        @Override
        public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
            Log.w("Products table", "Upgrading database i.e. dropping table and re-creating it");
            db.execSQL("DROP TABLE IF EXISTS " + DB_TABLE_BASKET);
            db.execSQL("DROP TABLE IF EXISTS " + DB_TABLE_ORDERS);
            db.execSQL("DROP TABLE IF EXISTS " + DB_TABLE_FOOD);
            db.execSQL("DROP TABLE IF EXISTS " + DB_TABLE_USER);
            db.execSQL("DROP TABLE IF EXISTS " + DB_TABLE_RESTAURANT);
            onCreate(db);
        }
    }

}
