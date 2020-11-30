import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CameraPosition _pos = CameraPosition(
      target: LatLng(37.32148022403878, -122.2677608213269),
      tilt: 60,
      zoom: 14.0,
      bearing: 0);
  void _onMapCreated(MapboxMapController controller) async {
    while (true) {
      _pos = CameraPosition(
          target: _pos.target,
          zoom: _pos.zoom,
          tilt: _pos.tilt,
          bearing: (_pos.bearing + 0.5) % 360.0);
      controller.moveCamera(CameraUpdate.newCameraPosition(_pos));
      setState(() {});
      await Future.delayed(Duration(milliseconds: 10));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mapbox iOS Performance Problem',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Stack(
        children: [
          MapboxMap(
            onMapCreated: _onMapCreated,
            accessToken: 'ACCESS_TOKEN_REPLACE_ME',
            initialCameraPosition: _pos,
            scrollGesturesEnabled: false,
            zoomGesturesEnabled: false,
            rotateGesturesEnabled: false,
            compassEnabled: false,
            myLocationEnabled: true,
            myLocationRenderMode: MyLocationRenderMode.NORMAL,
            styleString: MapboxStyles.OUTDOORS,
          ),
          Positioned(
            bottom: 50,
            right: 20,
            child: Container(
              child: Text(
                _pos.bearing.toStringAsFixed(1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
