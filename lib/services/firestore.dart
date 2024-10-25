import 'package:ai_saas_application/model/data_moedel.dart';
import 'package:ai_saas_application/services/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final StorageServices _storageServices = StorageServices();
  Future<void> saveConvasationData(
      {required convasationData,
      required convasationDate,
      required imageFile}) async {
    try {
      if (_auth.currentUser == null) {
        await _auth.signInAnonymously();
      }
      String userId = _auth.currentUser!.uid;
      String imageUrl = await _storageServices.uploadImage(
          imageFile: imageFile, userId: userId);
      DataMoedel newModel = DataMoedel(
          userId: userId,
          convasationData: convasationData,
          convasationDate: convasationDate,
          imageUrl: imageUrl);
//store data
      await _firebaseFirestore.collection("datamodel").add(newModel.toMap());
    } catch (err) {
      print("data storing error$err");
      Exception("something went wrong");
    }
  }

  //get history data
  Stream<List<DataMoedel>> getConvasationData() {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        print("no user found");
        throw ("no user Found");
      }

      //filter data according to user id
     Stream<List<DataMoedel>> dataStream = _firebaseFirestore
          .collection("datamodel")
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return DataMoedel.fromMap(doc.data());
        }).toList();
      });
      print("data print ${dataStream}");

      return dataStream;
    } catch (err) {
      print("data getting error :$err");
      return Stream.value([]);
    }
  }
}
