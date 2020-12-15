import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Kullanici{
final String id;
final String isim;
final String soyad;
final String avatar;
final String eposta;

  Kullanici({this.id, this.isim, this.soyad, this.avatar, this.eposta});
  factory Kullanici.dokumandanUret(DocumentSnapshot doc){//veritabanından  çektiğimiz verileri kullanıcı objesini kullanarak oluşturmuş oluyoruz
  //yapıcıya tek tek girmek yerine otomatik yollucak artık
    return  Kullanici(
      id: doc.documentID,
      isim: doc.data["isim"],
      soyad: doc.data["soyad"],
      eposta: doc.data["mail"],
      avatar: doc.data["avatar"]
    );
  }

  factory Kullanici.firebasedenUret(FirebaseUser kullanici){//veritabanından  çektiğimiz verileri kullanıcı objesini kullanarak oluşturmuş oluyoruz
  //yapıcıya tek tek girmek yerine otomatik yollucak artık
    return  Kullanici(
      id: kullanici.uid,
      isim: kullanici.displayName,
      
      eposta: kullanici.email,
      avatar: kullanici.photoUrl
    );
  }


}