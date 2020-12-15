

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
      body: FutureBuilder(//gecikmeli işlemi bekledikten sonra işlemi yapıyor yemek siparişi gibi düşün hemen maasyı hazırla yemekler geldiğinde yemekleri masaya servis et
        builder: (context,snapshot){
          if(!snapshot.hasData){//data var mı demek
            return CircularProgressIndicator();//bu widget ekranda yüklenir işareti koyuyor.
          }

          Kullanici kullanici=Kullanici.dokumandanUret(snapshot.data);
          return ListTile(
            title: Text(kullanici.isim+ " " +kullanici.soyad),
            subtitle: Text(kullanici.eposta),
            leading: Image.network(kullanici.avatar,width: 50.0,height: 50.0,fit:BoxFit.cover,),

          );
        },
        future: db.collection("kullanıcılar").document("FKbmBctVoYSb1exhYj6p").get(),//tamamlamasını beklemek istediğimiz kodu giricez
        
        
        
        )
    );
  }
}
