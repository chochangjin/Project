import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:format/format.dart';
import 'package:intl/intl.dart';
import 'package:group_button/group_button.dart';
import 'package:mysql1/mysql1.dart';
import 'package:our_safe/pages/qr_page/01.%20qr_test.dart';

//TODO 점검체크리스트 응답현황

class CheckView extends StatefulWidget {
  List view_list;
  CheckView(this.view_list, {Key? key}) : super(key: key);

  @override
  State<CheckView> createState() => _CheckViewState();
}

class _CheckViewState extends State<CheckView> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var wsize = MediaQuery.of(context).size.width;
    var hsize = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text('점검사항 응답이력'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 125, 188, 247),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical, child: checklist()))
          ],
        ));
  }

  Widget checklist() {
    String ans1;
    String ans2;
    String ans3;
    String ans4;
    String ans5;
    String ans6;
    String ans7;
    String obj_id = widget.view_list[0].toString();
    String date = widget.view_list[1].toString();
    String name = widget.view_list[2].toString();
    if (widget.view_list[3].toString() == '0') {
      ans1 = '이상없음';
    } else {
      ans1 = '이상있음';
    }
    if (widget.view_list[4].toString() == '0') {
      ans2 = '이상없음';
    } else {
      ans2 = '이상있음';
    }
    if (widget.view_list[5].toString() == '0') {
      ans3 = '이상없음';
    } else {
      ans3 = '이상있음';
    }
    if (widget.view_list[6].toString() == '0') {
      ans4 = '이상없음';
    } else {
      ans4 = '이상있음';
    }
    if (widget.view_list[7].toString() == '0') {
      ans5 = '이상없음';
    } else {
      ans5 = '이상있음';
    }
    if (widget.view_list[8].toString() == '0') {
      ans6 = '이상없음';
    } else {
      ans6 = '이상있음';
    }
    if (widget.view_list[9].toString() == '0') {
      ans7 = '이상없음';
    } else {
      ans7 = '이상있음';
    }
    var wsize = MediaQuery.of(context).size.width;
    var hsize = MediaQuery.of(context).size.height;
    return Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
              padding: EdgeInsets.all(20),
              width: wsize,
              height: 150,
              decoration: BoxDecoration(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '물품정보 : ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        obj_id,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '점검일자 : ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        date,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '점검자 : ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        name,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // 점검 내용
            Container(
              margin: EdgeInsets.all(30),
              padding: EdgeInsets.all(20),
              width: wsize,
              height: 500,
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '1. 점검표에 검사일 기재유무',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        ans1,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: ans1 == '이상없음' ? Colors.blue : Colors.red),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '2. 소화기 검정인 탈락 여부',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        ans2,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: ans2 == '이상없음' ? Colors.blue : Colors.red),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '3. 소화방법 및 적응화재 표시 유무',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        ans3,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: ans3 == '이상없음' ? Colors.blue : Colors.red),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '4. 용기본체의 부식 여부',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        ans4,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: ans4 == '이상없음' ? Colors.blue : Colors.red),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '5. 소화기 표지 부착 여부',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(ans5,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: ans5 == '이상없음' ? Colors.blue : Colors.red))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '6. 밸브 및 패킹 노후 및 탈락 여부',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        ans6,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: ans6 == '이상없음' ? Colors.blue : Colors.red),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '7. 노즐파손 및 이물질 유무',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        ans7,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: ans7 == '이상없음' ? Colors.blue : Colors.red),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
