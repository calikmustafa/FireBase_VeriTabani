

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
bool isAuth=false;
anonimGirisYap()async{
 AuthResult authResult=  await FirebaseAuth.instance.signInAnonymously();//ananim olarak giriş yap anlamına geliyor
 print(authResult.user.uid);//kullanıcığı kimliğini yazdırdık
 print(authResult.user.email);
 print(authResult.user.displayName);//kullanıcının görünen adı

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
  void initState() {
    
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged.listen((kullanici) {
      if(kullanici!=null){
        print("kullanıcı giriş yapmış durumda.Şimdi giriş yapmış yada uygulamayı yeni açmış olabilir");
        setState(() {
          isAuth=true;
        });
      }else{
        print("kullanıcı giriş yapmamış.Yeni çıkış yapmış yada uygulamayı yeni açmış olabilir");
        setState(() {
          isAuth=false;
        });
      }
     });//telsizden yeni bir yayın yapıldığında kullanıcı fonksiyonu çalışıcak
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? anaSayfa() :girisSayfasi();//eğer isauth değeri false ise girşş yap ekranı gelsin değil ise anasayfaya yönlendirsin
  }
}