import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireworks/models/kullanici.dart';
import 'package:fireworks/services/benimAuthServisim.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
anonimGirisYap(BuildContext context)async{
  var _benimAuthServisim=Provider.of<BenimAuthServisim>(context,listen: false);
 Kullanici kullanici=  await _benimAuthServisim.anonimGiris();//ananim olarak giriş yap anlamına geliyor
 //return kullanici.id;
 

}
class GirisSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
       child: Container(
         height: 80.0,
         width: 120.0,
         color: Colors.grey,
         child: Center(child: InkWell(onTap: ()=>anonimGirisYap(context),child: Text("Giriş Yap"))),
       ),
     ),
   ); 
  }
}