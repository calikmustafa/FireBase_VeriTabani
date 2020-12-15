

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

 void kullanicilariGetir()async{
  
    var snapshot=await Firestore.instance.collection("kullanıcılar").getDocuments();//firebasedeki veritabanına ulaşmak için yazdık kullanıcılar veritabanındaki belgeleri getir demek
    //snapshot demek veritabanındakini herşeyin kopyasının fotoğrafını çektik demek
    
    snapshot.documents.forEach((doc){//listenin her bir elemanı bu fonksiyona gönderilecek
      print(doc.data);// isim elemanları teker teker yazdırıcaz
    });
  }
  void kimlikIleKullaniciGetir()async{
  
    var doc=await Firestore.instance.collection("kullanıcılar").document("FKbmBctVoYSb1exhYj6p").get();//tek bir dökümanı ulaşmak istediğimizi söyledik kimlik ıd mizi yazdık
    print(doc.data);
    if(doc.exists){//böyle bir döküman var ise yazdır
      print(doc.data);
    }
    else{
      print("böyle bir döküman bulunmuyor");
    }
    
  }
  void kullanicilariSirala()async{
  
    var snapshot=await db.collection("kullanıcılar").orderBy("yaş").getDocuments();//kullanıcıların yaşlarını küçükten büyüğe doğru sıraladık
    
    snapshot.documents.forEach((doc){
      print(doc.data);
    });
  }
  void kullanicisorgula()async{
  
    var snapshot=await db.collection("kullanıcılar").where("yaş",isEqualTo: 25).getDocuments();//yaşı 25 olan kullanıcıyı getir dedik
    
    snapshot.documents.forEach((doc){
      print(doc.data);
    });
  }
   void kullanicicoklusorgu()async{
  
    QuerySnapshot snapshot=await db.collection("kullanıcılar").where("soyad",isEqualTo:"Kurt").where("yaş",isGreaterThan: 35).limit(1).getDocuments();//birden fazla sorgu yapmak için hem yaiı 35 olan hemde soy adı kurt olanı getir dedik
    //biden fazla sonuç olmasın bir tane olsun diyorsak limit 1 yapıcaz
    //var yerine asıl niteliğini yazabiliriz(querysnapshot)
    //doc parametresinide asıl niteliğini yazabiliriz(documentsnapshot)
    //birden fazla sorgu yaptığımız için internet sitesinden dizin eklememiz gerekiyor.
    snapshot.documents.forEach((DocumentSnapshot doc){
      print(doc.data);
    });
  }
  @override
  void initState() {
    
    super.initState();
    kullaniciOlustur();

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
      body: Center(),
    );
  }
}
