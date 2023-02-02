import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:group_button/group_button.dart';

class CheckScreen extends StatefulWidget {
  const CheckScreen({Key? key}) : super(key: key);

  @override
  State<CheckScreen> createState() => _CheckScreenState();
}

enum Selected { T, F }

class _CheckScreenState extends State<CheckScreen> {
  Selected _Selected1 = Selected.F; // 1-1
  Selected _Selected2 = Selected.F; // 1-2
  Selected _Selected3 = Selected.F; // 1-3
  Selected _Selected4 = Selected.F; // 2-1
  Selected _Selected5 = Selected.F; // 2-2
  Selected _Selected6 = Selected.F; // 2-3
  Selected _Selected7 = Selected.F; // 2-4
  Selected _Selected8 = Selected.F; // 2-5
  Selected _Selected9 = Selected.F; // 3-1
  Selected _Selected10 = Selected.F; // 3-2
  Selected _Selected11 = Selected.F; // 4
  Selected _Selected12 = Selected.F; // 5

  TextEditingController company_controller =
      TextEditingController(text: '(주)OOO');
  bool _isEnable = false;
  String edit_text = '수정';

  TextEditingController model_controller =
      TextEditingController(text: 'ABCDEFG1234');
  bool _isEnable1 = false;
  String edit_text1 = '수정';

  TextEditingController mfgdate_controller =
      TextEditingController(text: '2022-07-08');
  bool _isEnable2 = false;
  String edit_text2 = '수정';

  TextEditingController name_controller = TextEditingController();
  TextEditingController newname_controller = TextEditingController();
  TextEditingController new_phone = TextEditingController();
  TextEditingController dateCtl = TextEditingController();
  TextEditingController pad = TextEditingController();
  TextEditingController battery = TextEditingController();
  final formKey = GlobalKey<FormState>();

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

                    // todo  본체 작동 상태 확인
                    Container(
                      margin: EdgeInsets.all(30),
                      padding: EdgeInsets.all(20),
                      width: wsize,
                      height: 600,
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
                          Text(
                            ' 1. 본체 작동 상태 확인',
                            style: TextStyle(fontSize: 16),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '1-1. 전원 표시 상태등 점멸',
                                // style: TextStyle(fontSize: 20),
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
                              Text('1-2. 환자 부착용 패드 유무'),
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
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TextFormField(
                                style: const TextStyle(fontSize: 16),
                                controller: pad,
                                decoration: const InputDecoration(
                                  hintText: "패드 교체 예정일자",
                                  labelText: "* 패드 교체 예정일자",
                                ),
                                onTap: () async {
                                  DateTime date = DateTime(2000);
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());

                                  date = (await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2100)))!;

                                  pad.text =
                                      DateFormat('yyyy년 MM월 dd일').format(date);
                                  date.toString();
                                },
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('1-3. 건전지 충전 상태'),
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
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TextFormField(
                                style: const TextStyle(fontSize: 16),
                                controller: battery,
                                decoration: const InputDecoration(
                                  hintText: "건전지 교체 예정일자",
                                  labelText: "* 건전지 교체 예정일자",
                                ),
                                onTap: () async {
                                  DateTime date = DateTime(2000);
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());

                                  date = (await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2100)))!;

                                  battery.text =
                                      DateFormat('yyyy년 MM월 dd일').format(date);
                                  date.toString();
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    //todo 2. 보관함 상태
                    Container(
                      margin: EdgeInsets.all(30),
                      padding: EdgeInsets.all(20),
                      width: wsize,
                      height: 600,
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
                          Text(
                            ' 2. 보관함 상태',
                            style: TextStyle(fontSize: 16),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '2-1. 도난경보장치 작동 여부',
                                // style: TextStyle(fontSize: 20),
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
                                '2-2. 보관함 각종 안내문구 상태',
                                // style: TextStyle(fontSize: 20),
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
                                '2-3. 비상연락망 표시 여부',
                                // style: TextStyle(fontSize: 20),
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
                                '2-4. 심폐소생술 방법 안내책자 여부',
                                // style: TextStyle(fontSize: 20),
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
                                '2-5. 환자부착용 패드 및 건전지 유효기간 표시 여부',
                                // style: TextStyle(fontSize: 20),
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
                                        groupValue: _Selected8,
                                        onChanged: (Selected? value) {
                                          setState(() {
                                            _Selected8 = value ?? _Selected8;
                                          });
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
                                        groupValue: _Selected8,
                                        onChanged: (Selected? value) {
                                          setState(() {
                                            _Selected8 = value ?? _Selected8;
                                          });
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
                    ), //todo 3. 자동심장충격기 위치 안내
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ' 3. 자동심장충격기 위치 안내',
                            style: TextStyle(fontSize: 16),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '3-1. 기관(건물) 입구 안내 표지',
                                // style: TextStyle(fontSize: 20),
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
                                        groupValue: _Selected9,
                                        onChanged: (Selected? value) {
                                          setState(() {
                                            _Selected9 = value ?? _Selected9;
                                          });
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
                                        groupValue: _Selected9,
                                        onChanged: (Selected? value) {
                                          setState(() {
                                            _Selected9 = value ?? _Selected9;
                                          });
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
                                '3-2. 기관내 설치 위치 및 방향 표지',
                                // style: TextStyle(fontSize: 20),
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
                                        groupValue: _Selected10,
                                        onChanged: (Selected? value) {
                                          setState(() {
                                            _Selected10 = value ?? _Selected10;
                                          });
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
                                        groupValue: _Selected10,
                                        onChanged: (Selected? value) {
                                          setState(() {
                                            _Selected10 = value ?? _Selected10;
                                          });
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
                    ), //todo 4. 관리서류 작성 및 비치 여부
                    Container(
                      margin: EdgeInsets.all(30),
                      padding: EdgeInsets.all(20),
                      width: wsize,
                      // height: 300,
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
                                  '4. 관리서류 작성 및 비치 여부',
                                  // style: TextStyle(fontSize: 20),
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
                                          groupValue: _Selected11,
                                          onChanged: (Selected? value) {
                                            setState(() {
                                              _Selected11 =
                                                  value ?? _Selected11;
                                            });
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
                                          groupValue: _Selected11,
                                          onChanged: (Selected? value) {
                                            setState(() {
                                              _Selected11 =
                                                  value ?? _Selected11;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ]),
                    ), //todo 5. 관리자 변경사항
                    Container(
                      margin: EdgeInsets.all(30),
                      padding: EdgeInsets.all(20),
                      width: wsize,
                      // height: 500,
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
                                  '5. 관리자 변경사항',
                                  // style: TextStyle(fontSize: 20),
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: ListTile(
                                        title: const Text(
                                          "있음",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        // tileColor: Colors.pink[100],
                                        horizontalTitleGap: 0,
                                        leading: Radio<Selected>(
                                          value: Selected.T,
                                          groupValue: _Selected12,
                                          onChanged: (Selected? value) {
                                            setState(() {
                                              _Selected12 =
                                                  value ?? _Selected12;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: ListTile(
                                        title: const Text(
                                          "없음",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        // tileColor: Colors.pink[100],
                                        horizontalTitleGap: 0,
                                        leading: Radio<Selected>(
                                          value: Selected.F,
                                          groupValue: _Selected12,
                                          onChanged: (Selected? value) {
                                            setState(() {
                                              _Selected12 =
                                                  value ?? _Selected12;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TextField(
                                  keyboardType: TextInputType.text,
                                  controller: newname_controller,
                                  decoration: const InputDecoration(
                                      labelText: '* 관리자 이름(변경사항 있을 경우 기재)'),
                                  style: TextStyle(fontSize: 16),
                                ),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: new_phone,
                                  decoration: const InputDecoration(
                                      labelText: '* 관리자 전화번호(변경사항 있을 경우 기재)'),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ]),
                    ),
                    Container(
                      width: wsize,
                      height: 40,
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 30),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('점검완료')),
                    )
                  ],
                ))));
  }
}
