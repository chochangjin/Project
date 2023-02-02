import 'dart:io';
import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:http/http.dart' as http;
import '02. make_qr.dart';
import '06. direct_checklist.dart';
import '08. qr_checklist.dart';

class QRscanner extends StatefulWidget {
  const QRscanner({Key? key}) : super(key: key);

  @override
  State<QRscanner> createState() => _QRscannerState();
}

class _QRscannerState extends State<QRscanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool status = false;
  var object_id;
  var loc;
  var kind;
  var id;

  @override
  void reassemble() {
    super.reassemble();

    controller?.pauseCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('점검하기'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 125, 188, 247),
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 7, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // if (result != null) Text(result!.code.toString()),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext) => UploadObj()));
                        },
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Icon(Icons.chevron_left, color: Colors.black),
                            Text(
                              'QR코드 발급받기',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        )),
                    // TextButton(
                    //     onPressed: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (BuildContext) =>
                    //                   DirectCheckScreen()));
                    //     },
                    //     child: Row(
                    //       // ignore: prefer_const_literals_to_create_immutables
                    //       children: [
                    //         Text(
                    //           '물품정보 직접 입력하기',
                    //           style:
                    //               TextStyle(fontSize: 16, color: Colors.black),
                    //         ),
                    //         Icon(Icons.chevron_right, color: Colors.black)
                    //       ],
                    //     )),
                  ],
                ),
                SizedBox(
                  height: 5,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return Stack(children: [
      QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderColor: Colors.red,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: scanArea),
        onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
      ),
      Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 50),
            child: Text(
              '점검하고자 하는 물품의 QR코드를 촬영하세요.',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          )),
      Positioned(
        bottom: 20,
        right: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 5, 0),
              child: Text(
                '카메라 ON/OFF',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
              // width: 100,
              // height: 70,
              child: FlutterSwitch(
                activeColor: Colors.green,
                inactiveColor: Color.fromARGB(255, 174, 173, 173),
                width: 80.0,
                height: 40.0,
                valueFontSize: 12.0,
                toggleSize: 30.0,
                value: status,
                borderRadius: 30.0,
                padding: 6.0,
                showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    status = val;
                    if (val == true) {
                      controller?.resumeCamera();
                    } else {
                      controller?.pauseCamera();
                    }
                  });
                },
              ),
            ),
          ],
        ),
      )
    ]);
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        object_id = scanData.code.toString();
        loc = object_id.toString();
        object_id == null
            ? kind = ''
            : object_id.toString().contains('소화기') == true
                ? kind = '소화기'
                : object_id.toString().contains('AED') == true
                    ? kind = 'AED'
                    : kind = '방독면';
        if (scanData.code != null) {
          //스캔된 QR코드에 특정 키워드가 들어있다면
          //QR스캔을 정지하고 이 화면을 닫으면서 QR결과값을 보내주도록한다.
          this.controller!.dispose();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SafetyCheck(object_id, kind, loc)));
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
