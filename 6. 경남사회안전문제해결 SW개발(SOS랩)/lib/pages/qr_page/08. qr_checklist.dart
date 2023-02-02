import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '07. check_screen.dart';
import '09. gnu_check.dart';

class SafetyCheck extends StatelessWidget {
  String obj_id = "";
  String kind = "";
  String loc = "";
  SafetyCheck(this.obj_id, this.kind, this.loc, {Key? key}) : super(key: key);

  TextEditingController name_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var wsize = MediaQuery.of(context).size.width;
    var hsize = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text('점검하기'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 125, 188, 247),
        ),
        backgroundColor: Colors.grey[200],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(30),
              padding: EdgeInsets.all(20),
              width: wsize,
              height: 300,
              decoration: BoxDecoration(
                  // border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 5.0,
                        offset: Offset(
                          5,
                          5,
                        ))
                  ],
                  color: Colors.white),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '점검물품의 정보 일치여부',
                    style: TextStyle(fontSize: 20),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 50),
                        Text(
                          '점검물품 등록 정보 : ' + loc,
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 70),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext) =>
                                              CheckScreenGNU(obj_id)));
                                },
                                child: Text('일치')),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('불일치'))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
