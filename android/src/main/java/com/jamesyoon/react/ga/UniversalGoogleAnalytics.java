package com.jamesyoon.react.ga;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;

import com.google.android.gms.analytics.GoogleAnalytics;
import com.google.android.gms.analytics.HitBuilders;
import com.google.android.gms.analytics.Tracker;
import com.google.android.gms.analytics.ecommerce.Product;
import com.google.android.gms.analytics.ecommerce.ProductAction;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map.Entry;

import android.util.Log;

public class UniversalGoogleAnalytics extends ReactContextBaseJavaModule {

    public Tracker tracker;

    public HashMap<Integer, String> customDimensions = new HashMap<Integer, String>();

    public UniversalGoogleAnalytics(ReactApplicationContext reactContext) {
        super(reactContext);
    }


    @Override
    public String getName() {
        return "UniversalGoogleAnalytics";
    }

    @ReactMethod
    public void setUniversalGAId(String id) {
        if (null != id && id.length() > 0) {
            tracker = GoogleAnalytics.getInstance(getReactApplicationContext()).newTracker(id);
            GoogleAnalytics.getInstance(getReactApplicationContext()).setLocalDispatchPeriod(10);
            tracker.enableAdvertisingIdCollection(true);
        }
    }

    @ReactMethod
    public void trackEvent(String category, String action, String label, Integer value) {
        if (null != category && category.length() > 0 && null != tracker) {
            HitBuilders.EventBuilder hitBuilder = new HitBuilders.EventBuilder();

            attachCustomDimensionsToHitBuilder(hitBuilder);

            tracker.send(hitBuilder
                    .setCategory(category)
                    .setAction(action)
                    .setLabel(label)
                    .setValue(value)
                    .build()
                    );
        }
    }

    @ReactMethod
    public void trackScreen(String screenName) {
        if (null != screenName && screenName.length() > 0 && null != tracker) {

            HitBuilders.ScreenViewBuilder hitBuilder = new HitBuilders.ScreenViewBuilder();

            tracker.setScreenName(screenName);

            attachCustomDimensionsToHitBuilder(hitBuilder);

            tracker.send(hitBuilder.build());
        }
    }

    @ReactMethod
    public void setCustomDimension(Integer key, String value) {
        customDimensions.put(key, value);
    }

    @ReactMethod
    public void trackProductImpression(ReadableArray products, String list, String screenName) {

        try {

            ReadableMap item;
            Product product;

            if (products != null && products.size() > 0 && null != tracker) {
                HitBuilders.ScreenViewBuilder builder = new HitBuilders.ScreenViewBuilder();

                attachCustomDimensionsToHitBuilder(builder);

                for (int i = 0; i < products.size(); i++) {
                    item = products.getMap(i);

                    product = new Product()
                        .setId(item.getString("id"))
                        .setName(item.getString("name"))
                        .setCategory(item.getString("category"))
                        .setPrice(item.getDouble("price"))
                        .setPosition(item.getInt("position"))
                        .setVariant(item.getString("variant"));

                    builder.addImpression(product, list);
                }

                if (null != screenName && screenName.length() > 0) {
                    tracker.setScreenName(screenName);
                }   

                tracker.send(builder.build());
            }
        } catch (Exception ex) {
            Log.getStackTraceString(ex);
        }    
    }

    @ReactMethod
    public void trackProductClick(ReadableArray products, String list) {

        try {

            ReadableMap item;
            Product product;

            if (products != null && products.size() > 0 && null != tracker) {
                HitBuilders.EventBuilder builder = new HitBuilders.EventBuilder();

                attachCustomDimensionsToHitBuilder(builder);

                ProductAction productAction = new ProductAction(ProductAction.ACTION_CLICK);
                productAction.setProductActionList(list);

                for (int i = 0; i < products.size(); i++) {
                    item = products.getMap(i);

                    product = new Product()
                        .setId(item.getString("id"))
                        .setName(item.getString("name"))
                        .setCategory(item.getString("category"))
                        .setPrice(item.getDouble("price"))
                        .setPosition(item.getInt("position"))
                        .setVariant(item.getString("variant"));
 
                    builder.addProduct(product);
                }

                builder
                    .setProductAction(productAction)
                    .setCategory("Ecommerce")
                    .setAction("Product Click");

                tracker.send(builder.build());
            }
        } catch (Exception ex) {
            Log.getStackTraceString(ex);
        }    
    }

    @ReactMethod
    public void trackAddToCart(ReadableArray products, String list) {

        try {

            ReadableMap item;
            Product product;

            if (products != null && products.size() > 0 && null != tracker) {
                HitBuilders.EventBuilder builder = new HitBuilders.EventBuilder();

                attachCustomDimensionsToHitBuilder(builder);

                ProductAction productAction = new ProductAction(ProductAction.ACTION_ADD);
                productAction.setProductActionList(list);

                for (int i = 0; i < products.size(); i++) {
                    item = products.getMap(i);

                    product = new Product()
                        .setId(item.getString("id"))
                        .setName(item.getString("name"))
                        .setCategory(item.getString("category"))
                        .setPrice(item.getDouble("price"))
                        .setPosition(item.getInt("position"))
                        .setQuantity(item.getInt("quantity"))
                        .setVariant(item.getString("variant"));
 
                    builder.addProduct(product);
                }

               builder
                    .setProductAction(productAction)
                    .setCategory("Ecommerce")
                    .setAction("Add To Cart");

                tracker.send(builder.build());
            }
        } catch (Exception ex) {
            Log.getStackTraceString(ex);
        }    
    }

    @ReactMethod
    public void trackPurchase(ReadableArray products, String list, String transactionId, String affiliation, String couponCode,
        Double revenue, Double shipping, Double tax) {

        try {

            ReadableMap item;
            Product product;

            if (products != null && products.size() > 0 && null != tracker) {
                HitBuilders.EventBuilder builder = new HitBuilders.EventBuilder();

                attachCustomDimensionsToHitBuilder(builder);

                ProductAction productAction = new ProductAction(ProductAction.ACTION_PURCHASE)
                        .setTransactionId(transactionId)
                        .setTransactionAffiliation(affiliation)
                        .setTransactionRevenue(revenue)
                        .setTransactionTax(tax)
                        .setTransactionShipping(shipping)
                        .setProductActionList(list);

                if (couponCode != null && !"".equals(couponCode)) {
                    productAction.setTransactionCouponCode(couponCode);
                }        

                for (int i = 0; i < products.size(); i++) {
                    item = products.getMap(i);

                    product = new Product()
                        .setId(item.getString("id"))
                        .setName(item.getString("name"))
                        .setCategory(item.getString("category"))
                        .setPrice(item.getDouble("price"))
                        .setPosition(item.getInt("position"))
                        .setQuantity(item.getInt("quantity"))
                        .setVariant(item.getString("variant"));
 
                    builder.addProduct(product);
                }

               builder
                    .setProductAction(productAction)
                    .setCategory("Ecommerce")
                    .setAction("Purchase");

                tracker.send(builder.build());
            }
        } catch (Exception ex) {
            Log.getStackTraceString(ex);
        }    
    }

    private <T> void attachCustomDimensionsToHitBuilder(T builder) {
        try {
            Method builderMethod = builder.getClass().getMethod("setCustomDimension", Integer.TYPE, String.class);

            for (Entry<Integer, String> entry : customDimensions.entrySet()) {
                Integer key = entry.getKey();
                String value = entry.getValue();
                
                builderMethod.invoke(builder, (key), value);
            }
        } catch (Exception e) {
        }
    }
}