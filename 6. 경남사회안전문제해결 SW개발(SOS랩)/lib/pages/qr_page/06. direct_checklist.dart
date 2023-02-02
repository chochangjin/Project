import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:group_button/group_button.dart';

import '07. check_screen.dart';
import '09. gnu_check.dart';

class DirectCheckScreen extends StatefulWidget {
  const DirectCheckScreen({Key? key}) : super(key: key);

  @override
  State<DirectCheckScreen> createState() => _DirectCheckScreenState();
}

enum Selected { T, F }

class _DirectCheckScreenState extends State<DirectCheckScreen> {
  TextEditingController company_controller = TextEditingController();

  TextEditingController model_controller = TextEditingController();

  TextEditingController mfgdate_controller = TextEditingController();

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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '* 장비정보',
                            style: TextStyle(fontSize: 16),
                          ),
                          Row(
                            children: [
                              Text('제조사 : '),
                              Flexible(
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: company_controller,
                                  validator: (value) {},
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('제품명(모델명)  : '),
                              Flexible(
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: model_controller,
                                  validator: (value) {},
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('제조 연월일  : '),
                              Flexible(
                                  child: TextFormField(
                                style: const TextStyle(fontSize: 16),
                                controller: mfgdate_controller,
                                validator: (value) {},
                                onTap: () async {
                                  DateTime date = DateTime(1900);
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());

                                  date = (await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now()))!;

                                  mfgdate_controller.text =
                                      DateFormat('yyyy-MM-dd').format(date);
                                  date.toString();
                                },
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: wsize,
                      height: 40,
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 30),
                      child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {}
                          },
                          child: Text('다음')),
                    )
                  ],
                ))));
  }
}
