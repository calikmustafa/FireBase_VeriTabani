import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireworks/anaSayfa.dart';
import 'package:fireworks/girisSayfasi.dart';
import 'package:fireworks/main.dart';
import 'package:fireworks/models/kullanici.dart';
import 'package:fireworks/services/benimAuthServisim.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class YonlendirmeSsayfasi extends StatefulWidget {
  @override
  _YonlendirmeSsayfasiState createState() => _YonlendirmeSsayfasiState();
}

class _YonlendirmeSsayfasiState extends State<YonlendirmeSsayfasi> {


  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder(
      stream: Provider.of<BenimAuthServisim>(context,listen: false).durumTakipcisi,
      builder:(context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){//bağlantı kuruluna kadar bekle işareti çıkması için yaptık

          return Center(child: CircularProgressIndicator());
        }

        if(snapshot.hasData){//eğer veri varsa kullanıcyı anasayfaya yolla dedik
        Kullanici aktifKullanici=snapshot.data;
        print(aktifKullanici.id);
          return AnaSayfa();
          
      }
      else{
        return GirisSayfasi();
      
      }
      }
      );
      
      
      
  }
}