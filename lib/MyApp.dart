import 'package:flutter/material.dart';
import 'package:fluttermap/screens/landing.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GoogleMapController mapController;

//  final LatLng _center = const LatLng(45.521563, -122.677433);
  final LatLng _center = const LatLng(-1.2713434, 36.8917778);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps App'),
        backgroundColor: Colors.green[700],
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15.0,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 210.0,
              width: MediaQuery.of(context).size.width,
//              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LandingScreen.routeName);
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Where to ?",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 15.0),
                      color: Color(0xffC0C0C0),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text("Home"),
                    subtitle: Text("Umoja Estate"),
                    trailing: Icon(Icons.chevron_right),
                    dense: true,
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text("Ring Road Parklands"),
                    subtitle: Text("Ring Road Parklands"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    dense: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
