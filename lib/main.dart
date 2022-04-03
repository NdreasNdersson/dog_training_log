import 'dart:async';
import 'package:dog_training_log/models/dog.dart';
import 'package:dog_training_log/pages/activitylistpage.dart';
import 'package:dog_training_log/widgets/bottombar.dart';
import 'package:dog_training_log/widgets/headerbar.dart';
import 'package:dog_training_log/models/activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(ActivityAdapter());
  await Hive.openBox<Activity>('activities');

  Hive.registerAdapter(DogAdapter());
  await Hive.openBox<Dog>('dogs');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dog training log',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(17.385044, 78.486671),
    zoom: 18,
  );

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  late MarkerId markerId1;
  late Marker marker1;

  @override
  void initState() {
    super.initState();
    markerId1 = MarkerId("Current");
    marker1 = Marker(
        markerId: markerId1,
        position: LatLng(17.385044, 78.486671),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(
            title: "Hytech City", onTap: () {}, snippet: "Snipet Hitech City"));
    markers[markerId1] = marker1;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        drawer: const Drawer(),
        appBar: const HeaderBar('Map view'),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: Set<Marker>.of(markers.values),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomBar());
  }
}
