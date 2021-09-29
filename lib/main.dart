import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_openvpn/flutter_openvpn.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static Future<void> initPlatformState(String content) async {
    await FlutterOpenvpn.lunchVpn(
      content,
          (isProfileLoaded) {
        print('isProfileLoaded : $isProfileLoaded');
      },
          (vpnActivated) {
        print('vpnActivated : $vpnActivated');
      },
      // user: '4cPHLVX5n4aZ4w9ZC6XMA5eD',
      // pass: '7Q4AnpUpDAejYnEa75LwbpYZ',
      user: '4cPHLVX5n4aZ4w9ZC6XMA5eD',
      pass: '7Q4AnpUpDAejYnEa75LwbpYZ',
      onConnectionStatusChanged:
          (duration, lastPacketRecieve, byteIn, byteOut) {
        print('ByteIn : $byteIn');
        print('Duration : $duration');
      },
      expireAt: DateTime.now().add(
        const Duration(
          seconds: 15,
        ),
      ),
    );
  }

  static Future<void> initPlatform() async {
    var content = await rootBundle.loadString('assets/vpnConfig');
    await FlutterOpenvpn.init(
      providerBundleIdentifier: content,
    );
    initPlatformState(content);
  }

  static Future<void> stopVPN() async {
    var content = await rootBundle.loadString('assets/vpnConfig');
    await FlutterOpenvpn.stopVPN();
    initPlatformState(content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          ElevatedButton(
            child: Text('VPN connect'),
            onPressed: initPlatform,
          ),
          SizedBox(height: 25),
          ElevatedButton(
            child: Text('VPN disconnect'),
            onPressed: stopVPN,
          ),
        ],
      ),
    );
  }
}
