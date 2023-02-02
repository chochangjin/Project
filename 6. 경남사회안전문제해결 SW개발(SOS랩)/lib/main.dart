import 'package:flutter/material.dart';
import 'package:our_safe/pages/home_class/login.dart';
import 'package:our_safe/model/tabicon.dart';
import 'package:our_safe/pages/home_class/bottom_bar.dart';
import 'package:our_safe/pages/01.%20home_page.dart';
import 'package:our_safe/pages/02.%20map_page.dart';
import 'package:our_safe/pages/03.%20edu_page.dart';
import 'package:our_safe/pages/04.%20point_page.dart';

// 실증 위한 import 문
import 'dart:async';
import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:flutter/services.dart';
import 'package:format/format.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mysql1/mysql1.dart';
import 'package:url_launcher/url_launcher.dart';
import 'pages/qr_page/01. qr_test.dart';
import 'dart:ui' as ui;

void main() => runApp(MaterialApp(
      title: 'Login',
      home: LogIn(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

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
    setCustomMapPin();
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
        host: '121.156.13.83',
        port: 7777,
        user: 'medijet',
        password: 'medijet',
        db: 'MDJ');
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
    List<Marker> _markers = [];
    setState(() {
      _markers;
      getMap(_markers);
    });

    var settings = new ConnectionSettings(
        host: '121.156.13.83',
        port: 7777,
        user: 'medijet',
        password: 'medijet',
        db: 'MDJ');
    var conn = await MySqlConnection.connect(settings);

    var eqlocation = await conn.query(
        'select latitude, longtitude from sample_goods where type = "{0}";'
            .format(a));

    await marker_add(eqlocation);

    markerIcon = (await getBytesFromAsset('assets/img/{0}.png'.format(a), 100));
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

// 실증 위해 원래 로그인 화면 주석 처리
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Builder(
//         builder: (context) {
//           return SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 Padding(padding: EdgeInsets.only(top: 30.0, bottom: 5.0)),
//                 Center(
//                   child: Image.asset('assets/img/logo.png', scale: 3),
//                 ),
//                 Form(
//                     child: Container(
//                   padding: EdgeInsets.all(50.0),
//                   child: Column(
//                     children: <Widget>[
//                       TextFormField(
//                         decoration: InputDecoration(
//                           prefixIcon: Opacity(opacity: 0.7),
//                           labelText: '아이디를 입력하세요',
//                           hintText: '아이디를 입력하세요.',
//                           labelStyle: TextStyle(color: Colors.green[300]),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(20.0)),
//                             borderSide: BorderSide(
//                                 width: 1,
//                                 color: Color.fromARGB(255, 97, 123, 64)),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(20.0)),
//                             borderSide: BorderSide(
//                                 width: 1,
//                                 color: Color.fromARGB(255, 97, 123, 64)),
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(20.0)),
//                           ),
//                           filled: true,
//                           fillColor: Colors.white,
//                         ),
//                         keyboardType: TextInputType.emailAddress,
//                       ),
//                       Padding(padding: EdgeInsets.only(top: 20.0)),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           prefixIcon: Opacity(opacity: 0.7),
//                           labelText: '패스워드를 입력하세요',
//                           hintText: '패스워드를 입력하세요.',
//                           labelStyle: TextStyle(
//                             color: Colors.green[300],
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(20.0)),
//                             borderSide: BorderSide(
//                                 width: 1,
//                                 color: Color.fromARGB(255, 97, 123, 64)),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(20.0)),
//                             borderSide: BorderSide(
//                                 width: 1,
//                                 color: Color.fromARGB(255, 97, 123, 64)),
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(20.0)),
//                           ),
//                           filled: true,
//                           fillColor: Colors.white,
//                         ),
//                         keyboardType: TextInputType.emailAddress,
//                       ),
//                       Padding(padding: const EdgeInsets.only(top: 20.0)),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: <Widget>[
//                           SizedBox(
//                             height: 50,
//                             width: 50,
//                             child: ElevatedButton(
//                               child: Image.asset('assets/img/naver.png',
//                                   fit: BoxFit.fill, scale: 1),
//                               style: ElevatedButton.styleFrom(
//                                   primary: Colors.green),
//                               onPressed: () {},
//                             ),
//                           ),
//                           SizedBox(
//                             height: 50,
//                             width: 50,
//                             child: ElevatedButton(
//                               child: Image.asset(
//                                 'assets/img/kakao.png',
//                                 fit: BoxFit.fill,
//                                 scale: 1,
//                               ),
//                               style: ElevatedButton.styleFrom(
//                                   primary: Colors.yellow),
//                               onPressed: () {},
//                             ),
//                           ),
//                           SizedBox(
//                             height: 50,
//                             width: 50,
//                             child: ElevatedButton(
//                               child: Image.asset('assets/img/google.png',
//                                   fit: BoxFit.fill, scale: 1),
//                               style: ElevatedButton.styleFrom(
//                                   primary: Colors.white),
//                               onPressed: () {},
//                             ),
//                           ),
//                         ],
//                       ),
//                       Padding(padding: const EdgeInsets.only(top: 30.0)),
//                       ButtonTheme(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20.0)),
//                           minWidth: 400.0,
//                           height: 50.0,
//                           child: ElevatedButton(
//                               child: Text(
//                                 '로그인',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               onPressed: () {
//                                 Login().login_check(
//                                     controller, controller2, context);
//                               })),
//                       SizedBox(
//                         height: 10.0,
//                       ),
//                       ButtonTheme(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20.0)),
//                           minWidth: 400.0,
//                           height: 50.0,
//                           child: ElevatedButton(
//                               child: Text(
//                                 '아이디/비밀번호 찾기',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               onPressed: () {
//                                 Login().login_check(
//                                     controller, controller2, context);
//                               })),
//                       SizedBox(
//                         height: 10.0,
//                       ),
//                       ButtonTheme(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20.0)),
//                           minWidth: 400.0,
//                           height: 50.0,
//                           child: ElevatedButton(
//                               child: Text(
//                                 '회원가입',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               onPressed: () {
//                                 Login().login_check(
//                                     controller, controller2, context);
//                               })),
//                       Padding(padding: const EdgeInsets.only(top: 20.0)),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           ButtonTheme(
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20.0)),
//                               minWidth: 150.0,
//                               height: 100.0,
//                               child: ElevatedButton(
//                                   child: Text(
//                                     '긴급신고',
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   onPressed: () {
//                                     // Navigator.push(
//                                     //     context,
//                                     //     MaterialPageRoute(
//                                     //         builder: (context) => Emergency()));
//                                   })),
//                           ButtonTheme(
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20.0)),
//                               minWidth: 150.0,
//                               height: 100.0,
//                               child: ElevatedButton(
//                                   child: Text(
//                                     '대응 메뉴얼',
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   onPressed: () {
//                                     // Navigator.push(
//                                     //     context,
//                                     //     MaterialPageRoute(
//                                     //         builder: (context) => Manual()));
//                                   })),
//                         ],
//                       )
//                     ],
//                   ),
//                 ))
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class _MyApp extends State<MyApp> with TickerProviderStateMixin {
  int currentIndex = 0;
  final screens = [
    HomePage(animationController: null),
    MapPage(),
    EduPage(),
    PointPage()
  ];

  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: Colors.white,
  );

  @override
  void initState() {
    for (var tab in tabIconsList) {
      tab.isSelected = false;
    }
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = MapPage(animationController: animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return Stack(
              children: <Widget>[
                tabBody,
                //bottomBar(),
              ],
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = HomePage(animationController: animationController);
                });
              });
            } else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = MapPage(animationController: animationController);
                });
              });
            } else if (index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = EduPage(animationController: animationController);
                });
              });
            } else if (index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = PointPage(animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }
}
