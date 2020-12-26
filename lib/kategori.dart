import 'package:flutter/material.dart';
import 'package:peluang_berbicara/model/SinglePostModel.dart';
import 'package:peluang_berbicara/single.dart';
import 'package:peluang_berbicara/kategori_single.dart';
import 'package:peluang_berbicara/config/AppConfig.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


class KategoriView extends StatefulWidget {


  @override
  _KategoriViewState createState() => _KategoriViewState();
}

class _KategoriViewState extends State<KategoriView> {
  AppConfig _appConfig = AppConfig();
  KategoriList kategories;

  getKategori() async {
    var response = await http.get(_appConfig.getApiBaseUrl() + 'api/kategori/');
    if (response.statusCode == 200) {
      setState(() {
        kategories = KategoriesFromJson(response.body);
      });
    } else if (response.statusCode == 404) {
      Navigator.pop(context);
      FlutterToast.showToast(msg: "Gagal mengambil data kategori", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
    } else {
      Navigator.pop(context);
      FlutterToast.showToast(msg: "Terjadi kesalahan pada server", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
    }
  }

  @override
  void initState() {
    getKategori();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return kategories==null?Scaffold(body: Center(child: CircularProgressIndicator(),)):SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Daftar Kategori:', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            SizedBox(height: 16,),
            ListView.builder(
                itemCount: kategories.kategories.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_,idx) { return  InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => KategoriSingleView(kategori: kategories.kategories[idx].idkategori.toString(),))),
                  child: Card(
                    elevation: 5,
                    child: Row(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only( top: 8.0, bottom:8.0, right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(kategories.kategories[idx].nama, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ); }
            )

          ],
        ),
      ),
    );
  }
}
