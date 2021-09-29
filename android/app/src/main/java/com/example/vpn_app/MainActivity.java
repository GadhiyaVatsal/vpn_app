package com.example.vpn_app;

import android.content.Intent;

import io.flutter.embedding.android.FlutterActivity;
import com.topfreelancerdeveloper.flutter_openvpn.FlutterOpenvpnPlugin;

public class MainActivity extends FlutterActivity {

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == 1) {
            if (resultCode == RESULT_OK) {
                FlutterOpenvpnPlugin.setPermission(true);
            } else {
                FlutterOpenvpnPlugin.setPermission(false);
            }
        }
    }
}
