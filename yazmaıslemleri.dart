

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireworks/models/kullanici.dart';
import 'package:flutter/material.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Projem',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: AnaSayfa(),
      );
    
  }
}
class AnaSayfa extends StatefulWidget {
  
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {

  final db=Firestore.instance;//firestore yazmak yerine db yi kullanıcaz kod kirlilğini önlemek için

  kullaniciEkle(){
    db.collection("kullanıcılar").add({//kullanıcı eklemek için kullanıyoruz
      "isim":"Hakan",//map widgeti türünde yaptık
      "soyad":"Demir",
      "mail":"h.dmr@mailim.com"
    }).then((makbuz) => print(makbuz.documentID)).catchError((hata){print("kullanıcı eklenemedi: $hata");});//ekleme tamamlandıktan sonra
  }
  kimlikIleKullaniciEkle(){
    db.collection("kullanıcılar").document("abc").setData({//kullanıcı eklemek için kullanıyoruz
      "isim":"Hakan",//map widgeti türünde yaptık
      "soyad":"Demir",
      "mail":"h.dmr@mailim.com"
    }).then((_) => print("döküman girildi")).catchError((hata){print("kullanıcı eklenemedi: $hata");});//ekleme tamamlandıktan sonra
  } 
  kullaniciGuncelle(){
    db.collection("kullanıcılar").document("abc").updateData({//kullanıcı güncellemek için kullanıyoruz
      "isim":"Zeynep",//map widgeti türünde yaptık
      "soyad":"Tunç",
      "mail":"h.dmr@mailim.com"
    }).then((_) => print("döküman güncellendi")).catchError((hata){print("hata oluştu: $hata");});//ekleme tamamlandıktan sonra
  } 
  kullaniciSil(){//abc dökümanını sildik
    db.collection("kullanıcılar").document("abc").delete().then((_) => print("döküman silindi")).catchError((hata){print("hata oluştu: $hata");});//ekleme tamamlandıktan sonra
  }                                                  //hata verirse kullanıcı eklenemedi desin ve hatayı göstersin

 
  @override
  void initState() {
    
    super.initState();
    kullaniciSil();

  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder<QuerySnapshot>(
        stream: db.collection("kullanıcılar").snapshots() ,
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }
          List<Kullanici> kullanicilar= snapshot.data.documents.map((doc) => Kullanici.dokumandanUret(doc)).toList();
          return ListView.builder(
            itemCount:kullanicilar.length,
            itemBuilder: (context,pozisyon){
              return ListTile(
                title: Text(kullanicilar[pozisyon].isim),
                subtitle:Text(kullanicilar[pozisyon].eposta),
                leading: Image.network("https://cdn.pixabay.com/photo/2015/04/25/20/20/lady-739664_1280.jpg"),
              );
            });
        }
        )
    );
  }
}
