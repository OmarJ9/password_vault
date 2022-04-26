import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/pass_model.dart';

class FirestoreSerivice {
  static final _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final collectionReference = _firestore
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .collection('passwords');

  Future<void> addPass(PassModel passModel) async {
    bool doeswebsiteexists = await doesWebsiteAlreadyExist(passModel.website);
    if (!doeswebsiteexists) {
      await collectionReference.add(passModel.tojson());
    } else {
      throw 'Website Already Exist';
    }
  }

  Stream<List<PassModel>> getPasswords() {
    return collectionReference.snapshots().map((querysnapshot) => querysnapshot
        .docs
        .map((doc) => PassModel.fromJson(doc.data(), doc.id))
        .toList());
  }

  Stream<List<PassModel>> getPasswordsByCategory(String query) {
    return collectionReference
        .where(
          'category',
          isEqualTo: query,
        )
        .snapshots()
        .map((querysnapshot) => querysnapshot.docs
            .map((doc) => PassModel.fromJson(doc.data(), doc.id))
            .toList());
  }

  Stream<List<PassModel>> searchByName(String query) {
    return collectionReference
        .where(
          'website',
          isGreaterThanOrEqualTo: query,
        )
        .where('website', isLessThanOrEqualTo: '$query\uf7ff')
        .snapshots()
        .map((querysnapshot) => querysnapshot.docs
            .map((doc) => PassModel.fromJson(doc.data(), doc.id))
            .toList());
  }

  Future<void> deletePass(String id) async {
    await collectionReference.doc(id).delete();
  }

  Future<bool> doesWebsiteAlreadyExist(String website) async {
    final QuerySnapshot result = await collectionReference
        .where('website', isEqualTo: website)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents.length == 1;
  }
}
