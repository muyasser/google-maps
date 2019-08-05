import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'modal.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

const double drawerFontSize = 18;

const TextStyle drawerFontStyle = TextStyle(
    fontWeight: FontWeight.bold, fontSize: drawerFontSize, color: Colors.black);

final Set<Marker> markers = Set<Marker>();

Map<String, LatLng> markersinfo = {
  //'newyork' : LatLng(40.7128, -74.0060),
  'tahrirsq': LatLng(30.044657, 31.235670),
  'sadat': LatLng(30.044115, 31.234004),
  'pizzahut': LatLng(30.043837, 31.236665),
  'auc': LatLng(30.042667, 31.236547),
  'mac': LatLng(30.044065, 31.237187),
};

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GoogleMapController mapController;

  Geolocator geolocator = Geolocator();

  Position userLocation;

  Modal modal = Modal();

  Container customWalletTile = Container(
    //width: 10,
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: Colors.green.withOpacity(.1),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      '0 EGP',
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.green[600],
      ),
    ),
  );

  @override
  Widget build(BuildContext buildContext) {
    return OKToast(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Maps Sample App'),
            backgroundColor: Colors.green[700],
          ),
          body: GoogleMap(
            circles: {
              Circle(
                circleId: CircleId('circle'),
                center: LatLng(30.044657, 31.235670),
                radius: 100,
                strokeColor: Colors.black,
                visible: true,
                strokeWidth: 3,
              )
            },
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(30.044657, 31.235670),
              zoom: 15.8,
            ),
            markers: buildMarkers(context),
          ),
          drawer: buildDrawer(),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add_location),
            onPressed: () {
              modal.mainBottomSheet(buildContext);
            },
          ),
        ),
      ),
    );
  }

  Widget buildDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Mahmoud Ahmed',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              'Your Trips',
              style: drawerFontStyle,
            ),
            onTap: () {
              showtoastMessage('Your Trips');
            },
          ),
          ListTile(
            leading: Text(
              'Wallet',
              style: drawerFontStyle,
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[customWalletTile],
            ),
            onTap: () {
              showtoastMessage('Wallet');
            },
          ),
          ListTile(
            title: Text(
              'Payment',
              style: drawerFontStyle,
            ),
            onTap: () {
              showtoastMessage('Payment');
            },
          ),
          ListTile(
            title: Text(
              'Free Rides',
              style: TextStyle(
                  fontSize: drawerFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
            ),
            onTap: () {
              showtoastMessage('Free Rides');
            },
          ),
          ListTile(
            title: Text(
              'Settings',
              style: drawerFontStyle,
            ),
            onTap: () {
              showtoastMessage('Settings');
            },
          ),
          ListTile(
            title: Text(
              'Help',
              style: drawerFontStyle,
            ),
            onTap: () {
              showtoastMessage('Help');
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text(
              'v5.3.6',
              style: TextStyle(color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }

  Set<Marker> buildMarkers(BuildContext context) {
    markersinfo.forEach((name, location) {
      markers.add(Marker(
          markerId: MarkerId(name),
          position: location,
          onTap: () {
            showMarkerInfo(location);
          }));
    });

    return markers;
  }

  @override
  void initState() {
    super.initState();

    _getLocation().then((position) {
      userLocation = position;
    });
  }

  void showMarkerInfo(LatLng location) {}

  void showtoastMessage(String message) {
    print('it works');
    showToast(
      message,
      textStyle: TextStyle(fontSize: 18, color: Colors.black),
      backgroundColor: Colors.grey[200],
      position: ToastPosition.center,
      dismissOtherToast: true,
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Position> _getLocation() async {
    var currentLocation;
    try {
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }
}
