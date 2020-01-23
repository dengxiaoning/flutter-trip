package com.example.plugin.asr;

import android.app.Activity;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class AsrPlugin implements MethodChannel.MethodCallHandler {
    private static final String TAG = "AsrManager";
    private final Activity activity;
    private ResultStateful resultStateful;

    public static void registerWith(PluginRegistry.Registrar registrar){
        MethodChannel channel = new MethodChannel(registrar.messenger(),"asr_plug");
        AsrPlugin instance = new AsrPlugin(registrar);
        channel.setMethodCallHandler(instance);
    }
    public AsrPlugin(PluginRegistry.Registrar registrar){
        this.activity = registrar.activity();
    }
    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        switch (methodCall.method){
            case "start": 
                resultStateful = ResultStateful.of(result);
                start(methodCall,resultStateful)
                break;
            case "stop":
                break;
            case "cancel":
                break;
                default:
                    result.notImplemented();
        }
    }

    private void start(MethodCall methodCall, ResultStateful resultStateful) {
    }
}
