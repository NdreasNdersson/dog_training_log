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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CameraPosition _initialpos =
      const CameraPosition(target: LatLng(57.708870, 11.974560), zoom: 14.0);
  Completer<GoogleMapController> _controller = Completer();
  Location _location = Location();
  late LatLng _currentlocation;
  List<LatLng> points = [];
  late Set<Polyline> _polyline = {
    Polyline(
      polylineId: PolylineId("poly"),
      visible: true,
      points: [],
      color: Colors.blue,
    )
  };
  bool track = false;
  IconData _icon = Icons.play_circle;
  Color _color = Colors.green;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => _addPosition());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawer(),
        appBar: const HeaderBar('Map view'),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: _initialpos,
                polylines: _polyline,
                mapType: MapType.satellite,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  _location.onLocationChanged.listen((l) {
                    _currentlocation = LatLng(l.latitude!, l.longitude!);
                  });
                },
                myLocationEnabled: true,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            track = !track;
            setState(() {
              if (track) {
                _icon = Icons.stop_circle;
                _color = Colors.red;
              } else {
                _icon = Icons.play_circle;
                _color = Colors.green;
              }
            });
          },
          tooltip: 'Track position',
          child: Icon(_icon),
          backgroundColor: _color,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: const BottomBar());
  }

  void _addPosition() {
    if (track) {
      setState(() {
        points.add(_currentlocation);
        _polyline = {
          Polyline(
            polylineId: PolylineId("poly"),
            visible: true,
            points: points,
            color: Colors.blue,
          )
        };
      });
    }
  }
}
