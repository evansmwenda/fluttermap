import 'package:flutter/material.dart';
import 'package:fluttermap/screens/landing.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart' as MyGeoLocator;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GoogleMapController mapController;
  bool _serviceEnabled=false;
  MyGeoLocator.Position _currentPosition;


//  final LatLng _center = const LatLng(45.521563, -122.677433);
  final LatLng _center = const LatLng(-1.2713434, 36.8917778);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  @override
  void initState() {
    super.initState();
    _checkAllPermissions();

  }

  final Location location = Location();

  Future<void> _checkService() async {
    final bool serviceEnabledResult = await location.serviceEnabled();
    setState(() {
      _serviceEnabled = serviceEnabledResult;
    });
  }

  Future<void> _requestService() async {
    if (_serviceEnabled == null || !_serviceEnabled) {
      final bool serviceRequestedResult = await location.requestService();
      setState(() {
        _serviceEnabled = serviceRequestedResult;
      });
      if (!serviceRequestedResult) {
        return;
      }
    }
  }

  PermissionStatus _permissionGranted;

  Future<void> _checkPermissions() async {
    final PermissionStatus permissionGrantedResult =
    await location.hasPermission();
    setState(() {
      _permissionGranted = permissionGrantedResult;
    });
  }

  Future<void> _requestPermission() async {
    if (_permissionGranted != PermissionStatus.granted) {
      final PermissionStatus permissionRequestedResult =
      await location.requestPermission();
      setState(() {
        _permissionGranted = permissionRequestedResult;
      });
      if (permissionRequestedResult != PermissionStatus.granted) {
        return;
      }
    }
  }

  void _checkAllPermissions(){
    _checkService();
    _checkPermissions();
  }
  void _requestAllPermissions (){
    _requestService();
    _requestPermission();
  }

  void _getCurrentLocation() {
    final MyGeoLocator.Geolocator geolocator = MyGeoLocator.Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: MyGeoLocator.LocationAccuracy.best)
        .then((MyGeoLocator.Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
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
              zoom: 15.8,
            ),
          ),
          //check if location services & permissions are enabled are enabled
          //if not display widget for requesting permissions
          _serviceEnabled && _permissionGranted == PermissionStatus.granted ? Container() :
          Positioned(
            bottom: 210,
            child: SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: Container(
                color: Colors.blue,
                child: ListTile(
                  onTap: (){
                    //request for location service and permissions
                    _requestAllPermissions();
                    //_requestService();
                  },
                  title: Text(
                    "To find your pickup location automatically, turn on location services",
                    style: TextStyle(color: Colors.white,fontSize: 13.0),
                  ),
                  trailing: Icon(
                    Icons.navigate_next,
                    size: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
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
                      color: Color(0xffDCDCDC),
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
