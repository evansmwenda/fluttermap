import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';


class PickLocation extends StatefulWidget {
  static const routeName = '/picklocation';
  @override
  _PickLocationState createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {

  static const kGoogleApiKey = "AIzaSyDovrsN0ygji5HHmdhtWQnnOoPVFnZRVLc";

// to get places detail (lat/lng)
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

  List<Step> steps;
  int currentStep =1;
  bool complete=false;

  _goTo(int step){
    setState(() {
      currentStep = step;
    });
  }
   next(){
    currentStep != steps.length
        ? _goTo(currentStep +1 )
        : setState(() => complete =true);
  }
  cancel(){
    if(currentStep > 0){
      _goTo(currentStep -1);
    }
  }
  Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;

      scaffold.showSnackBar(
        SnackBar(content: Text("${p.description} - $lat/$lng")),
      );
    }
  }


  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  final searchScaffoldKey = GlobalKey<ScaffoldState>();




  @override
  Widget build(BuildContext context) {
    steps = [
      Step(
          title: Text("Umoja 3 Hospital"),
          isActive: true,
          content: Container(
            child: Text("Umoja 3 Hospital"),
          ),
          state: StepState.complete
      ),
      Step(
          title: Text("Where to ?"),
          isActive: true,
          content: TextField(
            onTap: () async{
              Prediction p = await PlacesAutocomplete.show(
                  context: context,
                  apiKey: kGoogleApiKey,
                  mode: Mode.fullscreen, // Mode.fullscreen
                  language: "en",
                  components: [ Component(Component.country, "ke")]);
              displayPrediction(p, homeScaffoldKey.currentState);
            },
            cursorColor: Colors.black,
            //controller: appState.destinationController,
            textInputAction: TextInputAction.go,
            onSubmitted: (value) {
              print("defcon:"+ value);
              //appState.sendRequest(value);
            },
            decoration: InputDecoration(
              icon: Container(
                margin: EdgeInsets.only(left: 20, top: 5),
                width: 10,
                height: 10,
                child: Icon(
                  Icons.local_taxi,
                  color: Colors.black,
                ),
              ),
              hintText: "destination?",
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
            ),
          ),
          state: StepState.editing
      ),

    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps App'),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stepper(
              steps: steps,
              currentStep: currentStep,
              onStepCancel: cancel,
              onStepContinue: next,
              onStepTapped: (step) => _goTo(step),
            ),
          ),
        ],
      ),
    );
  }
}
