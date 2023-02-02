import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mysql1/mysql1.dart';

import '00.test4_1.dart';
import '03. loading.dart';

//TODO 점검이력조회

class Check_History extends StatefulWidget {
  const Check_History({super.key});

  @override
  State<Check_History> createState() => _Check_HistoryState();
}

class _Check_HistoryState extends State<Check_History> {
  List obj_list = [];
  List view_list = [];

  TextEditingController loc_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('점검이력조회'),
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
                        labelText: '점검자', border: OutlineInputBorder()),
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
    List check_list = [];
    var settings = new ConnectionSettings(
        host: '121.156.13.83',
        port: 7777,
        user: 'medijet',
        password: 'medijet',
        db: 'MDJ');
    var conn = await MySqlConnection.connect(settings);
    var eqlocation = await conn.query(
        'select * from sos_app_checklist_gnu where name = "' +
            loc_controller.text +
            '";');

    for (var row in eqlocation) {
      // String obj_id_view = '${row[0]}';
      String name = '${row[1]}';
      String date = '${row[2]}';
      String obj_id = '${row[10]}';
      // String loc_id_view = '${row[4]}';
      String check1 = '${row[3]}';
      String check2 = '${row[4]}';
      String check3 = '${row[5]}';
      String check4 = '${row[6]}';
      String check5 = '${row[7]}';
      String check6 = '${row[8]}';
      String check7 = '${row[9]}';
      String check_all = '';
      check_list.add([check1, check2, check3, check4, check5, check6, check7]);
      for (int i = 0; i < check_list.length; i++) {
        int count = 0;
        List result = [];
        for (int j = 0; j < check_list[i].length; j++) {
          if (check_list[i][j] == '1') {
            count = count + 1;
            result.add(j + 1);
          }
        }
        if (count == 0) {
          check_all = '이상없음';
          continue;
        } else
          check_all = count.toString() + '개 항목 이상있음';
        continue;
      }
      print(check_all);
      print(check_list);
      obj_list.add([
        // obj_id_view,
        obj_id,
        date,
        name,
        check_all
      ]);
      view_list.add([
        obj_id,
        date,
        name,
        check1,
        check2,
        check3,
        check4,
        check5,
        check6,
        check7
      ]);
    }
    print(obj_list);
    setState(() {
      obj_list = obj_list;
      view_list = view_list;
    });
    print(obj_list);
    print(view_list);
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
      var view_datacell = view_list[i];
      List<DataCell> cells = [];
      for (var j = 0; j < obj_datacell.length; j++) {
        cells.add(DataCell(Text(obj_datacell[j])));
      }
      cells.add(DataCell(IconButton(
          onPressed: () {
            String view_id = obj_datacell[0];
            List view_list = view_datacell; //todo
            print(view_id);
            print('view:' + view_list.toString());
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext) => CheckView(view_list)));
          },
          icon: Icon(Icons.navigate_next))));
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
          '물품ID',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
        const DataColumn(
            label: Text(
          '점검일자',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
        const DataColumn(
            label: Text(
          '점검자',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
        const DataColumn(
            label: Text(
          '점검결과',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
        const DataColumn(label: Text("")),
      ], rows: _noRows(obj_list));
    } else {
      return DataTable(columns: [
        const DataColumn(
            label: Text(
          '물품ID',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
        const DataColumn(
            label: Text(
          '점검일자',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
        const DataColumn(
            label: Text(
          '점검자',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
        const DataColumn(
            label: Text(
          '점검결과',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
        const DataColumn(label: Text("")),
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
