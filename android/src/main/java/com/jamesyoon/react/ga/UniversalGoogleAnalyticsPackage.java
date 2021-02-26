package com.jamesyoon.react.ga;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import com.facebook.react.ReactPackage;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.uimanager.ViewManager;
import com.facebook.react.bridge.JavaScriptModule;

public class UniversalGoogleAnalyticsPackage implements ReactPackage {
    @Override
    public List<NativeModule> createNativeModules(ReactApplicationContext reactContext) {
        
        List<NativeModule> modules = new ArrayList<>();

        modules.add(new UniversalGoogleAnalytics(reactContext));

        return modules;
    }

    @Override
    public List<ViewManager> createViewManagers(ReactApplicationContext reactContext) {
        
        // return Arrays.<ViewManager>asList(new UniversalGoogleAnalyticsManager());
        return Collections.emptyList();
    }
}
