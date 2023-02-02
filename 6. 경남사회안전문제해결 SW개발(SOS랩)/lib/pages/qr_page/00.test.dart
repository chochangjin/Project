import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:mysql1/mysql1.dart';
import 'package:our_safe/main.dart';

import '01. qr_test.dart';

//TODO QR발급이력조회

class Test extends StatefulWidget {
  // String obj_id = "";
  // Test(this.obj_id, {Key? key}) : super(key: key);
  Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  List obj_list = [];

  TextEditingController loc_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('QR발급이력'),
          centerTitle: true,
          // backgroundColor: ,
        ),
        // backgroundColor: Color.fromARGB(255, 226, 226, 226),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: 150,
                  height: 60,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: loc_controller,
                    decoration: const InputDecoration(
                        labelText: '건물번호', border: OutlineInputBorder()),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        obj_list = [];
                      });
                      dbConnect();
                      Timer(const Duration(seconds: 2), () {
                        //시간 지연 시킨 후 코드 실행
                      });
                    },
                    child: const Text('조회')),
              ],
            ),

            // Expanded(child: (QRlist(obj_list))),
            Expanded(
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: qr_table(obj_list)))
          ],
        ));
  }

  Future dbConnect() async {
    var settings = new ConnectionSettings(
        host: '121.156.13.83',
        port: 7777,
        user: 'medijet',
        password: 'medijet',
        db: 'MDJ');
    var conn = await MySqlConnection.connect(settings);
    var eqlocation = await conn.query(
        'select * from sos_app_qrcode where loc_id = "' +
            loc_controller.text +
            '";');

    for (var row in eqlocation) {
      String obj_id_view = '${row[0]}';
      String loc_id_view = '${row[1]}';
      String goods_id_view = '${row[2]}';
      String type_view = '${row[3]}';
      // String loc_id_view = '${row[4]}';
      obj_list.add([obj_id_view, loc_id_view, goods_id_view, type_view]);
    }

    setState(() {
      obj_list = obj_list;
    });
    print(obj_list);
  }

  Future dbdelete(del_id) async {
    var settings = new ConnectionSettings(
        host: '121.156.13.83',
        port: 7777,
        user: 'medijet',
        password: 'medijet',
        db: 'MDJ');
    var conn = await MySqlConnection.connect(settings);
    await conn
        .query('DELETE  from sos_app_qrcode where obj_id = "' + del_id + '";');
  }

//todo 리스트뷰 함수 생성 (건물번호 입력 -> 조회버튼 클릭 -> 리스트뷰 동작 )

  // Widget QRlist(obj_list) {
  //   return ListView.separated(
  //     scrollDirection: Axis.vertical,
  //     itemCount: obj_list.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       return Container(
  //           height: 70,
  //           color: const Color.fromARGB(255, 255, 255, 255),
  //           alignment: Alignment.center,
  //           child: Text('${obj_list[index]}'));
  //     },
  //     separatorBuilder: (BuildContext context, int index) {
  //       return const Divider();
  //     },
  //   );
  // }

  List<DataRow> _getRows(obj_list) {
    List<DataRow> dataRow = [];
    for (var i = 0; i < obj_list.length; i++) {
      var obj_datacell = obj_list[i];
      List<DataCell> cells = [];
      for (var j = 1; j < obj_datacell.length; j++) {
        cells.add(DataCell(Text(obj_datacell[j])));
      }
      cells.add(DataCell(IconButton(
          onPressed: () {
            String del_id = obj_datacell[0];
            print(del_id);
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    _PopupDialog(context, del_id));
          },
          icon: Icon(Icons.delete))));
      dataRow.add(DataRow(cells: cells));
    }
    print(dataRow);

    return dataRow;
  }

  List<DataRow> _noRows(obj_list) {
    List<DataRow> dataRow = [];
    List<DataCell> cells = [];
    return dataRow;
  }

  Widget qr_table(obj_list) {
    if (obj_list.isEmpty == true) {
      return DataTable(columns: [
        const DataColumn(
            label: Text(
          '건물번호',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        )),
        const DataColumn(
            label: Text(
          '일련번호',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
        const DataColumn(
            label: Text(
          '물품종류',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
        const DataColumn(label: Text('')),
      ], rows: _noRows(obj_list));
    } else {
      return DataTable(columns: [
        const DataColumn(
            label: Text(
          '건물번호',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
        const DataColumn(
            label: Text(
          '일련번호',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
        const DataColumn(
            label: Text(
          '물품종류',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
        const DataColumn(label: Text('')),
      ], rows: _getRows(obj_list));
    }
  }

  Widget _PopupDialog(BuildContext context, del_id) {
    return AlertDialog(
      title: const Text('삭제하시겠습니까?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(del_id)],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            dbdelete(del_id);
            Timer(const Duration(seconds: 1), () {
              setState(() {
                obj_list = [];
                dbConnect();
              });

              Navigator.of(context).pop(); //시간 지연 시킨 후 코드 실행
            });
          },
          child: const Text('삭제'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('취소'),
        ),
      ],
    );
  }
}



// ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     itemCount: a.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Container(
//                           height: 70,
//                           color: Colors.grey,
//                           alignment: Alignment.center,
//                           child: Text('item: ${a[index]}'));
//                     })