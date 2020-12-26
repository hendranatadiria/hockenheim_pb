// To parse this JSON data, do
//
//     final singlePost = singlePostFromJson(jsonString);

import 'dart:convert';

SinglePost singlePostFromJson(String str) => SinglePost.fromJson(json.decode(str));
PostList PostsFromJson(String str) => PostList.fromJson(json.decode(str));
KategoriList KategoriesFromJson(String str) => KategoriList.fromJson(json.decode(str));
KategoriSingleList KategoriSingleListFromJson(String str) => KategoriSingleList.fromJson(json.decode(str));

String singlePostToJson(SinglePost data) => json.encode(data.toJson());

class PostList{
  PostList({
    this.posts
});
  
  List<Post> posts;
  
  factory PostList.fromJson(List<dynamic> json) => PostList(
    posts: List<Post>.from(json.map((x)=>Post.fromJson(x))));
}

class KategoriList{
  KategoriList({
    this.kategories
});

  List<Kategori> kategories;

  factory KategoriList.fromJson(List<dynamic> json) => KategoriList(
    kategories: List<Kategori>.from(json.map((x)=>Kategori.fromJson(x))));
}

class KategoriSingleList{
  KategoriSingleList({
    this.kategori,
    this.posts,
});

  Kategori kategori;
  List<Post> posts;

  factory KategoriSingleList.fromJson(Map<String, dynamic> json) => KategoriSingleList(
    kategori: Kategori.fromJson(json["kategori"]),
    posts: List<Post>.from(json['post'].map((x)=>Post.fromJson(x))));

}

class SinglePost {
  SinglePost({
    this.post,
    this.komentar,
  });

  Post post;
  List<Komentar> komentar;

  factory SinglePost.fromJson(Map<String, dynamic> json) => SinglePost(
    post: Post.fromJson(json["post"]),
    komentar: List<Komentar>.from(json["komentar"].map((x) => Komentar.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "post": post.toJson(),
    "komentar": List<dynamic>.from(komentar.map((x) => x.toJson())),
  };
}

class Komentar {
  Komentar({
    this.idkomentar,
    this.idpost,
    this.idpenulis,
    this.isi,
    this.createdAt,
    this.updatedAt,
    this.penulis,
  });

  int idkomentar;
  int idpost;
  int idpenulis;
  String isi;
  DateTime createdAt;
  DateTime updatedAt;
  Penulis penulis;

  factory Komentar.fromJson(Map<String, dynamic> json) => Komentar(
    idkomentar: json["idkomentar"],
    idpost: json["idpost"],
    idpenulis: json["idpenulis"],
    isi: json["isi"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    penulis: Penulis.fromJson(json["penulis"]),
  );

  Map<String, dynamic> toJson() => {
    "idkomentar": idkomentar,
    "idpost": idpost,
    "idpenulis": idpenulis,
    "isi": isi,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "penulis": penulis.toJson(),
  };
}

class Penulis {
  Penulis({
    this.idpenulis,
    this.nama,
    this.alamat,
    this.kota,
    this.noTelp,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  int idpenulis;
  String nama;
  dynamic alamat;
  dynamic kota;
  dynamic noTelp;
  String email;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Penulis.fromJson(Map<String, dynamic> json) => Penulis(
    idpenulis: json["idpenulis"],
    nama: json["nama"],
    alamat: json["alamat"],
    kota: json["kota"],
    noTelp: json["no_telp"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "idpenulis": idpenulis,
    "nama": nama,
    "alamat": alamat,
    "kota": kota,
    "no_telp": noTelp,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Post {
  Post({
    this.idpost,
    this.judul,
    this.idkategori,
    this.isipost,
    this.fileGambar,
    this.createdAt,
    this.updatedAt,
    this.idpenulis,
    this.kategori,
    this.penulis,
  });

  int idpost;
  String judul;
  int idkategori;
  String isipost;
  String fileGambar;
  DateTime createdAt;
  DateTime updatedAt;
  int idpenulis;
  Kategori kategori;
  Penulis penulis;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    idpost: json["idpost"],
    judul: json["judul"],
    idkategori: json["idkategori"],
    isipost: json["isipost"],
    fileGambar: json["file_gambar"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    idpenulis: json["idpenulis"],
    kategori: Kategori.fromJson(json["kategori"]),
    penulis: Penulis.fromJson(json["penulis"]),
  );

  Map<String, dynamic> toJson() => {
    "idpost": idpost,
    "judul": judul,
    "idkategori": idkategori,
    "isipost": isipost,
    "file_gambar": fileGambar,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "idpenulis": idpenulis,
    "kategori": kategori.toJson(),
    "penulis": penulis.toJson(),
  };
}

class Kategori {
  Kategori({
    this.idkategori,
    this.nama,
  });

  int idkategori;
  String nama;

  factory Kategori.fromJson(Map<String, dynamic> json) => Kategori(
    idkategori: json["idkategori"],
    nama: json["nama"],
  );

  Map<String, dynamic> toJson() => {
    "idkategori": idkategori,
    "nama": nama,
  };
}
