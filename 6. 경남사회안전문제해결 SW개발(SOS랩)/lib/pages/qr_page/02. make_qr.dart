import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:format/format.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mysql1/mysql1.dart';
import '03. loading.dart';

class UploadObj extends StatefulWidget {
  const UploadObj({Key? key}) : super(key: key);

  @override
  _UploadObjState createState() => _UploadObjState();
}

class _UploadObjState extends State<UploadObj> {
  File? _image;
  final picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    setState(() {
      _image = File(image!.path); // 가져온 이미지를 _image에 저장
    });
  }

  // 이미지를 보여주는 위젯
  Widget showImage() {
    return Container(
        color: const Color(0xffd0cece),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.width,
        child: Center(
            child: _image == null
                ? Text('No image selected.')
                : Image.file(
                    File(
                      _image!.path,
                    ),
                    fit: BoxFit.fill,
                  )));
  }

  //!POST 이미지
  Future<void> uploadImage(obj, type) async {
    if (_image != null) {
      dynamic sendData = _image?.path;
      var formData = FormData.fromMap({
        'obj_id': area_controller.text + id_controller.text + obj.toString(),
        'loc_id': area_controller.text,
        'goods_id': id_controller.text,
        'type': obj.toString(),
        'image': await MultipartFile.fromFile(sendData),
        // 'qr': null,
      });
      var obj_id = area_controller.text + id_controller.text + obj.toString();
      print("사진을 서버에 업로드 합니다.");
      print(id_controller.text);
      var dio = new Dio();
      try {
        dio.options.contentType = 'multipart/form-data'; // 'application/json';
        dio.options.maxRedirects.isFinite;

        dio.options.headers = {
          //장고 setting.py_ 서비스키_(없어도 무관)
        };

        var response = await dio.post('http://121.156.13.83:8888/make_qrcode/',
            data: formData);

        info_insert(obj_id, type);
        print('성공적으로 업로드했습니다');
        return print(response.data);
      } catch (e) {
        print('오류');
      }
    }
  }

  Future<void> info_insert(obj_id, type) async {
    Position cuposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);

    var settings = new ConnectionSettings(
        host: '121.156.13.83',
        port: 7777,
        user: 'medijet',
        password: 'medijet',
        db: 'MDJ');
    var conn = await MySqlConnection.connect(settings);

    await conn.query(
        'insert into sample_goods(name, type, latitude, longtitude, obj_id) values("{0}", "{1}", {2}, {3}, "{4}");'
            .format(
                type, type, cuposition.latitude, cuposition.longitude, obj_id));
  }

  TextEditingController id_controller = TextEditingController();
  TextEditingController area_controller = TextEditingController();
  String obj = '소화기';
  final List<String> _valueList = ['소화기', 'AED', '방독면'];
  String _selectedValue = 'AED';
  @override
  Widget build(BuildContext context) {
    var objId = area_controller.text + id_controller.text + obj;
    // 화면 세로 고정
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
        backgroundColor: const Color(0xfff4f3f9),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 25.0),
                showImage(),
                SizedBox(
                  height: 50.0,
                ),
                SizedBox(
                  width: 280,
                  child: DropdownButton(
                    value: _selectedValue,
                    items: _valueList.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value.toString();
                        // print(_selectedValue);
                        if (_selectedValue == "소화기") {
                          obj = '소화기';
                        } else if (_selectedValue == "AED") {
                          obj = 'AED';
                        } else if (_selectedValue == "방독면") {
                          obj = '방독면';
                        }
                        // print(obj);
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: 280,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: area_controller,
                    decoration: const InputDecoration(
                        labelText: '건물번호 입력 (ex : 25동)',
                        border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: 280,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: id_controller,
                    decoration: const InputDecoration(
                        labelText: '안전물품에 부여된 일련 번호 입력 (ex : B_006)',
                        border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // 카메라 촬영 버튼
                    FloatingActionButton(
                      child: Icon(Icons.add_a_photo),
                      tooltip: 'pick Iamge',
                      onPressed: () {
                        getImage(ImageSource.camera);
                      },
                    ),

                    // 갤러리에서 이미지를 가져오는 버튼
                    FloatingActionButton(
                      child: Icon(Icons.wallpaper),
                      tooltip: 'pick Iamge',
                      onPressed: () {
                        getImage(ImageSource.gallery);
                      },
                    ),
                    FloatingActionButton(
                      child: Icon(Icons.qr_code),
                      onPressed: () => [
                        {
                          if (_selectedValue == "소화기")
                            {
                              uploadImage("소화기", "fire"),
                            }
                          else if (_selectedValue == "AED")
                            {
                              uploadImage("AED", "aed"),
                            }
                          else if (_selectedValue == "방독면")
                            {
                              uploadImage("방독면", "mask"),
                            },
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext) => Loading(objId)))
                        }
                      ],
                    ),
                  ],
                ),
              ],
            )));
  }
}
