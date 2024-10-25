import 'package:cloud_firestore/cloud_firestore.dart';

class DataMoedel {
  final String userId;
  final String convasationData;
  
  final DateTime convasationDate;
final String imageUrl;
  DataMoedel(
   {
    required this.userId,
    required this.convasationData,
    required this.convasationDate,
    required this.imageUrl
  });

  factory DataMoedel.fromMap(Map<String, dynamic> map) {
    return DataMoedel(
      userId: map['userId'],
      convasationData: map['convasationData'],
      convasationDate: (map['convasationDate'] as Timestamp).toDate(),
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'convasationData': convasationData,
      'convasationDate': convasationDate,
      'imageUrl': imageUrl,
    };
  }
}
