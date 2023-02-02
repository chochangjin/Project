import 'dart:async';

import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:format/format.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mysql1/mysql1.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;

import 'qr_page/01. qr_test.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key, AnimationController? animationController});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/img/logo.png',
                      scale: 5,
                      alignment: Alignment.topLeft,
                    ),
                  ],
                ),
              ),
              getMap(_markers),
            ],
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
            child: AnimatedFloatingActionButton(fabButtons: <Widget>[
              add_floating(),
              aed_floating(),
              fire_extinguisher_floating(),
              mask_floating()
            ], animatedIconData: AnimatedIcons.menu_close),
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    dbConnect();
    addAllListData();
  }

  List<Widget> listViews = <Widget>[];

  void addAllListData() {
    listViews.add(SizedBox(height: 730, child: getMap(_markers)));
  }

  Completer<GoogleMapController> _controller = Completer();

  List<Marker> _markers = [];
  late Uint8List markerIcon;

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  Future<void> _getauthority(GoogleMapController controller) async {
    bool serviceEnabled;
    LocationPermission permission;

    _controller.complete(controller);

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  static final CameraPosition stlocation =
      CameraPosition(target: LatLng(35.152477, 128.104881), zoom: 17);

// DB 연결
  Future<void> dbConnect() async {
    var settings = new ConnectionSettings(
        host: '121.156.13.69',
        port: 7070,
        user: 'nsquare',
        password: 'nsquare@123',
        db: 'our_safe');
    var conn = await MySqlConnection.connect(settings);

    var eqlocation = await conn.query(
        'select latitude, longtitude from sample_goods where type = "aed";');

    await marker_add(eqlocation);
  }

// 구글 맵 로드
  Widget getMap(var _markers) {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: GoogleMap(
          zoomGesturesEnabled: true,
          zoomControlsEnabled: false,
          mapType: MapType.normal,
          initialCameraPosition: stlocation,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          markers: Set.from(_markers),
          onMapCreated: _getauthority),
    );
  }

// 지도 로드 시 마커 추가
  Future<void> marker_add(var eqlocation) async {
    setState(() {
      _markers = [];
    });

    for (var row in eqlocation) {
      _markers.add(Marker(
          markerId: MarkerId(row.toString()),
          draggable: true,
          icon: BitmapDescriptor.fromBytes(markerIcon),
          onTap: () {
            navi_function(row[0], row[1]);
            launch(
                'kakaomap://route?sp=35.152477, 128.104881&ep={0:.6f},{1:.6f}&by=FOOT'
                    .format(row[0], row[1]));
          },
          position: LatLng(row[0], row[1])));
    }

    getMap(_markers);
  }

  Future<void> navi_function(var row1, var row2) async {
    Position cuposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    launch('kakaomap://route?sp={0:.6f}, {1:.6f}&ep={2:.6f},{3:.6f}&by=FOOT'
        .format(cuposition.latitude, cuposition.longitude, row1, row2));
  }

// 마커 생성 --------------------->
  void setCustomMapPin() async {
    markerIcon = (await getBytesFromAsset('assets/img/aed.png', 100));
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

// floating button 클릭 시 해당 마커 생성
  Future<void> maker_change(var a) async {
    setState(() {
      _markers = [];
    });

    var settings = new ConnectionSettings(
        host: '121.156.13.69',
        port: 7070,
        user: 'nsquare',
        password: 'nsquare@123',
        db: 'our_safe');
    var conn = await MySqlConnection.connect(settings);

    var eqlocation = await conn.query(
        'select latitude, longtitude from sample_goods where type = "{0}";'
            .format(a));

    markerIcon = (await getBytesFromAsset('assets/img/{0}.png'.format(a), 100));

    await marker_add(eqlocation);
  }

// floating button 선언 --------------------->
  Widget add_floating() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => QR_test()));
        },
        tooltip: '안전물품 추가',
        backgroundColor: Colors.teal[700],
        child: Icon(Icons.add),
        elevation: 0,
      ),
    );
  }

  Widget aed_floating() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          maker_change("aed");
        },
        tooltip: 'AED',
        backgroundColor: Colors.cyan[300],
        child: Icon(Icons.heart_broken),
        elevation: 0,
      ),
    );
  }

  Widget fire_extinguisher_floating() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          maker_change("fire");
        },
        tooltip: '소화기',
        backgroundColor: Colors.cyan[300],
        child: Icon(Icons.fire_extinguisher),
        elevation: 0,
      ),
    );
  }

  Widget mask_floating() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          maker_change("mask");
        },
        tooltip: '방독면',
        backgroundColor: Colors.cyan[300],
        child: Icon(Icons.masks),
        elevation: 0,
      ),
    );
  }
}
