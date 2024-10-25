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
      if (_auth.currentUser == null) {
        throw ("no user Found");
      }
      String userId = _auth.currentUser!.uid;
      //filter data according to user id
      return _firebaseFirestore
          .collection("datamodel")
          .where("userId", isEqualTo: userId)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return DataMoedel.fromMap(doc.data());
        }).toList();
      });
    } catch (err) {
      print(err.toString());
      return Stream.value([]);
    }
  }
}
