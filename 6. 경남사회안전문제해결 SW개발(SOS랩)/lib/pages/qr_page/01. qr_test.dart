import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:our_safe/pages/qr_page/00.test.dart';
import 'package:our_safe/pages/qr_page/00.test2.dart';
import '02. make_qr.dart';
import '05. qr_scanner.dart';
import '07. check_screen.dart';

class QR_test extends StatefulWidget {
  const QR_test({Key? key}) : super(key: key);

  @override
  State<QR_test> createState() => _QR_testState();
}

class _QR_testState extends State<QR_test> {
  String qrResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext) => UploadObj()));
                },
                child: Text('안전물품 등록 및 QR발급')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext) => QRscanner()));
                },
                child: Text('물품 점검하기')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext) => Test()));
                },
                child: Text('QR발급이력')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext) => Check_History()));
                },
                child: Text('점검이력')),

            //     ElevatedButton(
            //         onPressed: () {
            //           Navigator.push(context,
            //               MaterialPageRoute(builder: (BuildContext) => Test()));
            //         },
            //     child: Text('QR 발급현황')),
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (BuildContext) => Test()));
            //     },
            //     child: Text('점검이력조회'))
          ],
        )
      ],
    ));
  }
}
