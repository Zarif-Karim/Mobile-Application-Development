package com.example.assignmenttest.ui.data;

import java.util.ArrayList;
import java.util.List;

/**
 * Helper class for providing sample content for user interfaces created by
 * Android template wizards.
 * <p>
 * TODO: Replace all uses of this class before publishing your app.
 */
public class Content {

    /**
     * An array of sample (dummy) items.
     */
    public static final List<DummyItem> ITEMS = new ArrayList<DummyItem>();

    /**
     * A map of sample (dummy) items, by ID.
     */
    //public static final Map<String, DummyItem> ITEM_MAP = new HashMap<String, DummyItem>();

//    private static final int COUNT = 25;
//
//    static {
//        // Add some sample items.
//        for (int i = 1; i <= COUNT; i++) {
//            addItem(createDummyItem(i));
//        }
//    }

/*    private static void addItem(DummyItem item) {
        ITEMS.add(item);
        //ITEM_MAP.put(item.id, item);
    }

    private static DummyItem createDummyItem(int position) {
        return new DummyItem(String.valueOf(position), "Item " + position, makeDetails(position));
    }*/

    private static String makeDetails(int position) {
        StringBuilder builder = new StringBuilder();
        builder.append("Details about Item: ").append(position);
        for (int i = 0; i < position; i++) {
            builder.append("\nMore details information here.");
        }
        return builder.toString();
    }


    public static class DummyItem {
        public final int id;
        public final String name;
        public final String style;
        public final String location;
        public final float min;

        public DummyItem(int id, String n, String s, String l, float m) {
            this.id = id;
            this.name = n;
            this.style = s;
            this.location = l;
            this.min = m;
        }

        @Override
        public String toString() {
            return name;
        }
    }

    public static class FoodItem {
        public final int id;
        public final String name;
        public final float price;
        public final int restaurant_id;


        public FoodItem(int id, String n, float p, int r_id) {
            this.id = id;
            this.restaurant_id = r_id;
            this.name = n;
            this.price = p;
        }

        @Override
        public String toString() {
            return name;
        }
    }

    public static class Basket {
        public final int id;
        public final int order;
        public final int food;
        public final int quantity;


        public Basket(int id, int o, int f, int q) {
            this.id = id;
            this.order = o;
            this.food = f;
            this.quantity = q;
        }

        /*@Override
        public String toString() {
            return name;
        }*/
    }


}