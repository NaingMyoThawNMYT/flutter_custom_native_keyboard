package com.may.fkeyboard.flutter_custom_native_keyboard;

import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.Nullable;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL_NAME = "fkeyboard";
    private static final String START = "start";

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL_NAME).setMethodCallHandler(
                ((call, result) -> {
                    if(call.method.equals(START)) {
                        start();
                        result.success("start is called.");
                    }
                })
        );
    }

    private void start() {
        Intent enableIntent = new Intent("android.settings.INPUT_METHOD_SETTINGS");
        enableIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);   
        startActivity(enableIntent);
    }
}
