import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:format/format.dart';
import 'package:intl/intl.dart';
import 'package:group_button/group_button.dart';
import 'package:mysql1/mysql1.dart';
import 'package:our_safe/pages/qr_page/01.%20qr_test.dart';

class CheckScreenGNU extends StatefulWidget {
  String obj_id;
  CheckScreenGNU(this.obj_id, {Key? key}) : super(key: key);

  @override
  State<CheckScreenGNU> createState() => _CheckScreenGNUState();
}

enum Selected { T, F }

class _CheckScreenGNUState extends State<CheckScreenGNU> {
  Selected _Selected1 = Selected.F; // 1번사항
  Selected _Selected2 = Selected.F; // 2번사항
  Selected _Selected3 = Selected.F; // 3번사항
  Selected _Selected4 = Selected.F; // 4번사항
  Selected _Selected5 = Selected.F; // 5번사항
  Selected _Selected6 = Selected.F; // 6번사항
  Selected _Selected7 = Selected.F; // 7번사항
  Selected _Selected8 = Selected.F; // 관리자

  bool num_1 = false;
  bool num_2 = false;
  bool num_3 = false;
  bool num_4 = false;
  bool num_5 = false;
  bool num_6 = false;
  bool num_7 = false;
  bool manager_change = false;

  TextEditingController name_controller = TextEditingController(); //점검자
  TextEditingController dateCtl = TextEditingController(); //점검일자
  TextEditingController newname_controller =
      TextEditingController(); // 변경된 관리자 이름
  TextEditingController new_phone = TextEditingController(); //변경된 전화번호

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var wsize = MediaQuery.of(context).size.width;
    var hsize = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text('소화기 점검하기'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 125, 188, 247),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(30),
                      padding: EdgeInsets.all(20),
                      width: wsize,
                      // height: 180,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ' * 점검자 정보 입력',
                            style: TextStyle(fontSize: 16),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: name_controller,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return '필수값 입니다';
                            //   } else
                            //     return null;
                            // },
                            decoration:
                                const InputDecoration(labelText: '점검자 이름'),
                            style: TextStyle(fontSize: 16),
                          ),
                          TextFormField(
                            style: const TextStyle(fontSize: 16),
                            controller: dateCtl,
                            decoration: const InputDecoration(
                              hintText: "점검일자 입력",
                              labelText: "점검일자 입력",
                            ),
                            onTap: () async {
                              DateTime date = DateTime(1900);
                              FocusScope.of(context).requestFocus(FocusNode());

                              date = (await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now()))!;

                              dateCtl.text =
                                  DateFormat('yyyy년 MM월 dd일').format(date);
                              date.toString();
                            },
                          )
                        ],
                      ),
                    ),

                    // todo  점검 내용
                    Container(
                      margin: EdgeInsets.all(30),
                      padding: EdgeInsets.all(20),
                      width: wsize,
                      height: 1000,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '1. 점검표에 검사일 기재유무',
                                style: TextStyle(fontSize: 18),
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: ListTile(
                                      title: const Text(
                                        "이상있음",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      // tileColor: Colors.pink[100],
                                      horizontalTitleGap: 0,
                                      leading: Radio<Selected>(
                                        value: Selected.T,
                                        groupValue: _Selected1,
                                        onChanged: (Selected? value) {
                                          setState(() {
                                            _Selected1 = value ?? _Selected1;
                                          });
                                          num_1 = true;
                                        },
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: ListTile(
                                      title: const Text(
                                        "이상없음",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      // tileColor: Colors.pink[100],
                                      horizontalTitleGap: 0,
                                      leading: Radio<Selected>(
                                        value: Selected.F,
                                        groupValue: _Selected1,
                                        onChanged: (Selected? value) {
                                          setState(() {
                                            _Selected1 = value ?? _Selected1;
                                          });
                                          num_1 = false;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '2. 소화기 검정인 탈락 여부',
                                style: TextStyle(fontSize: 18),
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: ListTile(
                                      title: const Text(
                                        "이상있음",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      // tileColor: Colors.pink[100],
                                      horizontalTitleGap: 0,
                                      leading: Radio<Selected>(
                                        value: Selected.T,
                                        groupValue: _Selected2,
                                        onChanged: (Selected? value) {
                                          setState(() {
                                            _Selected2 = value ?? _Selected2;
                                          });
                                          num_2 = true;
                                        },
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: ListTile(
                                      title: const Text(
                                        "이상없음",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      // tileColor: Colors.pink[100],
                                      horizontalTitleGap: 0,
                                      leading: Radio<Selected>(
                                        value: Selected.F,
                                        groupValue: _Selected2,
                                        onChanged: (Selected? value) {
                                          setState(() {
                                            _Selected2 = value ?? _Selected2;
                                          });
                                          num_2 = false;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '3. 소화방법 및 적응화재 표시 유무',
                                style: TextStyle(fontSize: 18),
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: ListTile(
                                      title: const Text(
                                        "이상있음",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      // tileColor: Colors.pink[100],
                                      horizontalTitleGap: 0,
                                      leading: Radio<Selected>(
                                        value: Selected.T,
                                        groupValue: _Selected3,
                                        onChanged: (Selected? value) {
                                          setState(() {
                                            _Selected3 = value ?? _Selected3;
                                          });
                                          num_3 = true;
                                        },
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: ListTile(
                                      title: const Text(
                                        "이상없음",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      // tileColor: Colors.pink[100],
                                      horizontalTitleGap: 0,
                                      leading: Radio<Selected>(
                                        value: Selected.F,
                                        groupValue: _Selected3,
                                        onChanged: (Selected? value) {
                                          setState(() {
                                            _Selected3 = value ?? _Selected3;
                                          });
                                          num_3 = false;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '4. 용기본체의 부식 여부',
                                style: TextStyle(fontSize: 18),
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: ListTile(
                                      title: const Text(
                                        "이상있음",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      // tileColor: Colors.pink[100],
                                      horizontalTitleGap: 0,
                                      leading: Radio<Selected>(
                                        value: Selected.T,
                                        groupValue: _Selected4,
                                        onChanged: (Selected? value) {
                                          setState(() {
                                            _Selected4 = value ?? _Selected4;
                                          });
                                          num_4 = true;
                                        },
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: ListTile(
                                      title: const Text(
                                        "이상없음",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      // tileColor: Colors.pink[100],
                                      horizontalTitleGap: 0,
                                      leading: Radio<Selected>(
                                        value: Selected.F,
                                        groupValue: _Selected4,
                                        onChanged: (Selected? value) {
                                          setState(() {
                                            _Selected4 = value ?? _Selected4;
                                          });
                                          num_4 = false;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '5. 소화기 표지 부착 여부',
                                style: TextStyle(fontSize: 18),
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: ListTile(
                                      title: const Text(
                                        "이상있음",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      // tileColor: Colors.pink[100],
                                      horizontalTitleGap: 0,
                                      leading: Radio<Selected>(
                                        value: Selected.T,
                                        groupValue: _Selected5,
                                        onChanged: (Selected? value) {
                                          setState(() {
                                            _Selected5 = value ?? _Selected5;
                                          });
                                          num_5 = true;
                                        },
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: ListTile(
                                      title: const Text(
                                        "이상없음",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      // tileColor: Colors.pink[100],
                                      horizontalTitleGap: 0,
                                      leading: Radio<Selected>(
                                        value: Selected.F,
                                        groupValue: _Selected5,
                                        onChanged: (Selected? value) {
                                          setState(() {
                                            _Selected5 = value ?? _Selected5;
                                          });
                                          num_5 = false;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '6. 밸브 및 패킹 노후 및 탈락 여부',
                                style: TextStyle(fontSize: 18),
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: ListTile(
                                      title: const Text(
                                        "이상있음",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      // tileColor: Colors.pink[100],
                                      horizontalTitleGap: 0,
                                      leading: Radio<Selected>(
                                        value: Selected.T,
                                        groupValue: _Selected6,
                                        onChanged: (Selected? value) {
                                          setState(() {
                                            _Selected6 = value ?? _Selected6;
                                          });
                                          num_6 = true;
                                        },
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: ListTile(
                                      title: const Text(
                                        "이상없음",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      // tileColor: Colors.pink[100],
                                      horizontalTitleGap: 0,
                                      leading: Radio<Selected>(
                                        value: Selected.F,
                                        groupValue: _Selected6,
                                        onChanged: (Selected? value) {
                                          setState(() {
                                            _Selected6 = value ?? _Selected6;
                                          });
                                          num_6 = false;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '7. 노즐파손 및 이물질 유무',
                                style: TextStyle(fontSize: 18),
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: ListTile(
                                      title: const Text(
                                        "이상있음",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      // tileColor: Colors.pink[100],
                                      horizontalTitleGap: 0,
                                      leading: Radio<Selected>(
                                        value: Selected.T,
                                        groupValue: _Selected7,
                                        onChanged: (Selected? value) {
                                          setState(() {
                                            _Selected7 = value ?? _Selected7;
                                          });
                                          num_7 = true;
                                        },
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: ListTile(
                                      title: const Text(
                                        "이상없음",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      // tileColor: Colors.pink[100],
                                      horizontalTitleGap: 0,
                                      leading: Radio<Selected>(
                                        value: Selected.F,
                                        groupValue: _Selected7,
                                        onChanged: (Selected? value) {
                                          setState(() {
                                            _Selected7 = value ?? _Selected7;
                                          });
                                          num_7 = false;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    //todo 5. 관리자 변경사항
                    // Container(
                    //   margin: EdgeInsets.all(30),
                    //   padding: EdgeInsets.all(20),
                    //   width: wsize,
                    //   // height: 500,
                    //   decoration: BoxDecoration(
                    //       // border: Border.all(width: 1, color: Colors.black),
                    //       borderRadius: BorderRadius.all(Radius.circular(20)),
                    //       boxShadow: [
                    //         BoxShadow(
                    //             color: Colors.grey.withOpacity(0.5),
                    //             spreadRadius: 0,
                    //             blurRadius: 5.0,
                    //             offset: Offset(
                    //               5,
                    //               5,
                    //             ))
                    //       ],
                    //       color: Colors.white),
                    //   child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             const Text(
                    //               '관리자 변경사항',
                    //               style: TextStyle(fontSize: 18),
                    //             ),
                    //             Row(
                    //               children: [
                    //                 Flexible(
                    //                   child: ListTile(
                    //                     title: const Text(
                    //                       "있음",
                    //                       style: TextStyle(fontSize: 16),
                    //                     ),
                    //                     // tileColor: Colors.pink[100],
                    //                     horizontalTitleGap: 0,
                    //                     leading: Radio<Selected>(
                    //                       value: Selected.T,
                    //                       groupValue: _Selected8,
                    //                       onChanged: (Selected? value) {
                    //                         setState(() {
                    //                           _Selected8 = value ?? _Selected8;
                    //                         });
                    //                         manager_change = true;
                    //                       },
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Flexible(
                    //                   child: ListTile(
                    //                     title: const Text(
                    //                       "없음",
                    //                       style: TextStyle(fontSize: 16),
                    //                     ),
                    //                     // tileColor: Colors.pink[100],
                    //                     horizontalTitleGap: 0,
                    //                     leading: Radio<Selected>(
                    //                       value: Selected.F,
                    //                       groupValue: _Selected8,
                    //                       onChanged: (Selected? value) {
                    //                         setState(() {
                    //                           _Selected8 = value ?? _Selected8;
                    //                         });
                    //                         manager_change = false;
                    //                       },
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             TextField(
                    //               keyboardType: TextInputType.text,
                    //               controller: newname_controller,
                    //               decoration: const InputDecoration(
                    //                   labelText: '* 관리자 이름(변경사항 있을 경우 기재)'),
                    //               style: TextStyle(fontSize: 16),
                    //             ),
                    //             TextField(
                    //               keyboardType: TextInputType.number,
                    //               controller: new_phone,
                    //               decoration: const InputDecoration(
                    //                   labelText: '* 관리자 전화번호(변경사항 있을 경우 기재)'),
                    //               style: TextStyle(fontSize: 16),
                    //             ),
                    //           ],
                    //         ),
                    //       ]),
                    // ),
                    Container(
                      width: wsize,
                      height: 40,
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 30),
                      child: ElevatedButton(
                          onPressed: () {
                            print(widget.obj_id);
                            Save_list();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext) => QR_test()));
                          },
                          child: Text('점검완료')),
                    )
                  ],
                ))));
  }

  Future<void> Save_list() async {
    //todo api 통해서 db에 저장하기
    var settings = new ConnectionSettings(
        host: '121.156.13.83',
        port: 7777,
        user: 'medijet',
        password: 'medijet',
        db: 'MDJ');
    var conn = await MySqlConnection.connect(settings);

    await conn.query(
        'insert into sos_app_checklist_gnu(name, date, check_01, check_02, check_03, check_04, check_05, check_06, check_07, obj_id) values("{0}", "{1}", {2}, {3}, {4}, {5}, {6}, {7}, {8}, "{9}");'
            .format(name_controller.text, dateCtl.text, num_1, num_2, num_3,
                num_4, num_5, num_6, num_7, widget.obj_id));
  }
}
