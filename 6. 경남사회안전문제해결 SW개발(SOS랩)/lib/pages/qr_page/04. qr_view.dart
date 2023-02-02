import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:our_safe/main.dart';

import '01. qr_test.dart';

class QrView extends StatelessWidget {
  String obj_id = "";
  QrView(this.obj_id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('QR발급이 완료되었습니다.'),
        Text('아래 보이는 QR코드를 안전물품에 부착하세요'),
        Container(
            color: const Color(0xffd0cece),
            child: Center(
                child: Image.network(
              'http://121.156.13.83:8888/media/qr_images/' + obj_id + '.png',
              fit: BoxFit.fill,
            ))),
        ElevatedButton(
            onPressed: () {
              var file = ('http://121.156.13.83:8888/media/qr_images/' +
                  obj_id +
                  '.png');
              GallerySaver.saveImage(file)
                  .then((value) => print('>>>> save value= $value'))
                  .catchError((err) {
                print('error :( $err');
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => QR_test()));
            },
            child: Text('저장'))
      ],
    ));
  }
}
