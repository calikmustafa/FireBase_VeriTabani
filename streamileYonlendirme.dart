

import 'package:firebase_auth/firebase_auth.dart';

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
      home: YonlendirmeSsayfasi(),
      );
    
  }
}
class YonlendirmeSsayfasi extends StatefulWidget {
  @override
  _YonlendirmeSsayfasiState createState() => _YonlendirmeSsayfasiState();
}

class _YonlendirmeSsayfasiState extends State<YonlendirmeSsayfasi> {

anonimGirisYap()async{
 AuthResult authResult=  await FirebaseAuth.instance.signInAnonymously();//ananim olarak giriş yap anlamına geliyor
 //print(authResult.user.uid);//kullanıcığı kimliğini yazdırdık
 //print(authResult.user.email);
 //print(authResult.user.displayName);//kullanıcının görünen adı

}
cikisYap(){

  FirebaseAuth.instance.signOut();
}

  Widget girisSayfasi(){
   return Scaffold(
     body: Center(
       child: Container(
         height: 80.0,
         width: 120.0,
         color: Colors.grey,
         child: Center(child: InkWell(onTap: ()=>anonimGirisYap(),child: Text("Giriş Yap"))),
       ),
     ),
   ); 
  }

Widget anaSayfa(){
   return Scaffold(
     body: Center(
       child: InkWell(onTap: ()=>cikisYap(),child: Text("çıkış yap")),
     ),
   ); 

  }
  

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder:(context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){//bağlantı kuruluna kadar bekle işareti çıkması için yaptık

          return Center(child: CircularProgressIndicator());
        }

        if(snapshot.hasData){//eğer veri varsa kullanıcyı anasayfaya yolla dedik
        print(snapshot.data.uid);
          return anaSayfa();
          
      }
      else{
        return girisSayfasi();
      
      }
      }
      );
      
      
      
  }
}