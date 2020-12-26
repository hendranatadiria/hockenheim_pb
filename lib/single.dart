import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:peluang_berbicara/config/AppConfig.dart';
import 'package:http/http.dart' as http;
import 'package:peluang_berbicara/model/SinglePostModel.dart';

class Single extends StatefulWidget {
  String id;
  Single({
    this.id,
});
  @override
  _SingleState createState() => _SingleState();
}

class _SingleState extends State<Single> {
  SinglePost postData;
  AppConfig _appConfig = AppConfig();
  getPost(String id) async {
    var response = await http.get(_appConfig.getApiBaseUrl() + 'api/post/'+id);
    if (response.statusCode == 200) {
    setState(() {
    postData = singlePostFromJson(response.body);
    });
    } else if (response.statusCode == 404) {
    Navigator.pop(context);
    FlutterToast.showToast(msg: "Postingan tidak ditemukan", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
    } else {
    Navigator.pop(context);
    FlutterToast.showToast(msg: "Terjadi kesalahan pada server", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getPost(widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return postData==null ? Scaffold(body: Center(child: CircularProgressIndicator(),)) : Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(postData.post.judul),
          backgroundColor: Color(0xffffc107),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 24),
          child: Column(
            children: [
              Image.network(postData.post.fileGambar!=null?_appConfig.getApiBaseUrl()+'img/'+postData.post.fileGambar:'https://picsum.photos/600/400'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical:16.0),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Text(postData.post.judul, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                    SizedBox(height: 2,),
                    Text('Ditulis oleh: '+postData.post.penulis.nama + ' | Kategori: '+postData.post.kategori.nama),
                    SizedBox(height: 5,),
                    Text(DateFormat("dd MMMM yyyy").format(postData.post.updatedAt)),
                    SizedBox(height: 18,),
                    HtmlWidget(
                      '<div style="text-align: justify;">' + postData.post.isipost + '</div>',
                      webView: true,
                      textStyle: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 36,),
                    Text('Komentar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),

                  ],
                ),

              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_,idx) => ListTile(
                    title: Row(children: [Text(postData.komentar[idx].penulis.nama, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),), Text(' pada '+DateFormat("dd MMMM yyyy").format(postData.komentar[idx].createdAt), style: TextStyle(fontSize: 14),)],),
                    subtitle: Text(postData.komentar[idx].isi, style: TextStyle(fontSize: 14),),
                  ),
                  itemCount: postData.komentar.length,),
              ),
              postData.komentar.length==0?Text('Belum ada komentar.'):Container(),

            ],

          ),
        ),
      ),
    );
  }
}
