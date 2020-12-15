

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

 
  @override
  void initState() {
    
    super.initState();
    

  }
  Future<List<Kullanici>> kullanicilariGetir()async{
    QuerySnapshot snapshot=await db.collection("kullanıcılar").getDocuments();
   List<Kullanici> kullanicilar= snapshot.documents.map((doc) => Kullanici.dokumandanUret(doc)).toList();//map metodu listenin elemanlarını teker teker fonksiyona gönderir bu fonksiyondan yeni bir liste oluşturmuş oluyorduk
//mapdan gelen elemanları dokumumandanuret fonksiyonuna gönderdik
return kullanicilar;
  }
  void kullaniciOlustur()async{
    var doc=await Firestore.instance.collection("kullanıcılar").document("FKbmBctVoYSb1exhYj6p").get();//veritabanından gelen verilerle kullanıcı_1 adlı methoda gönderddik ve yazdırdık
    Kullanici kullanici_1=Kullanici.dokumandanUret(doc);
    print(kullanici_1.id);
    print(kullanici_1.isim);
    print(kullanici_1.soyad);
    print(kullanici_1.eposta);
    print(kullanici_1.avatar);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder<List<Kullanici>>(
        future: kullanicilariGetir(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context,pozisyon){
              return ListTile(
                title: Text(snapshot.data[pozisyon].isim),
                subtitle:Text(snapshot.data[pozisyon].eposta),
                leading: Image.network("https://cdn.pixabay.com/photo/2015/04/25/20/20/lady-739664_1280.jpg"),
              );
            });
        }
        )
    );
  }
}
