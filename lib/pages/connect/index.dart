import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';

class Connect extends StatefulWidget {
  const Connect({super.key});

  @override
  _WifiPageState createState() => _WifiPageState();
}

class _WifiPageState extends State<Connect> {
  final TextEditingController wifiNameController = TextEditingController(text: 'AP_C0011048');
  final TextEditingController passwordController = TextEditingController();

  void connectToWifi() async {
    String wifiName = wifiNameController.text;
    String password = passwordController.text;
   
    var connectionResult = await WiFiForIoTPlugin.connect(wifiName, password: password);
    print(connectionResult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect to WiFi'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: wifiNameController,
                decoration: InputDecoration(
                  hintText: 'WiFi Name',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: connectToWifi,
                child: Text('Connect'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
