import 'package:flutter/material.dart';
import 'package:peluang_berbicara/model/SinglePostModel.dart';
import 'package:peluang_berbicara/single.dart';
import 'package:peluang_berbicara/config/AppConfig.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


class PencarianView extends StatefulWidget {


  @override
  _PencarianViewState createState() => _PencarianViewState();
}

class _PencarianViewState extends State<PencarianView> {
  AppConfig _appConfig = AppConfig();
  PostList posts;
  bool searching=false, done=false;

  getPosts(String query) async {

    setState(() {
      posts = null;
      searching = true;
      done = false;
    });
    var response = await http.get(_appConfig.getApiBaseUrl() + 'api/search?q='+query);
    if (response.statusCode == 200) {
      setState(() {
        posts = PostsFromJson(response.body);
        searching=false;
        done=true;
      });
    } else if (response.statusCode == 404) {
      Navigator.pop(context);
      FlutterToast.showToast(msg: "Gagal mengambil post data", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
    } else {
      Navigator.pop(context);
      FlutterToast.showToast(msg: "Terjadi kesalahan pada server", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Masukkan kata pencarian...'
            ),
            onSubmitted: getPosts,
          ),
        ),
        SizedBox(height: 16,),

        posts==null||posts.posts.isEmpty?Container():Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: posts.posts.length,
              itemBuilder: (_,idx) { return  InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Single(id: posts.posts[idx].idpost.toString()))),
                child: Card(
                  elevation: 5,
                  child: Row(
                    children: [
                      Expanded(child: Image.network(posts.posts[idx].fileGambar!=null?_appConfig.getApiBaseUrl()+'img/'+posts.posts[idx].fileGambar:'https://picsum.photos/600/400?random='+idx.toString()),
                        flex: 2,),
                      SizedBox(width: 10),
                      Flexible(
                        flex:3,
                        child: Padding(
                          padding: const EdgeInsets.only( top: 8.0, bottom:8.0, right: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(posts.posts[idx].judul, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),),
                              SizedBox(height:4),
                              Text(posts.posts[idx].penulis.nama+' | '+DateFormat("dd MMMM yyyy").format(posts.posts[idx].createdAt)),
                              SizedBox(height:2),
                              Text('Kategori: ' + posts.posts[idx].kategori.nama, style: TextStyle(fontSize: 12.0))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ); }
          ),
        ),
        searching?Center(child: CircularProgressIndicator(),):Container(),
        done&&posts.posts.isEmpty?Center(child: Text('Tidak ditemukan hasil.')):Container(),

      ],
    );
  }
}
