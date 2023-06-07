import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_testing/user_req.dart';

class FirebaseService {
  static const String userCollection = 'USER';
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static Future<bool> addUserDetail(UserReq userReq) async {
    await firebaseFirestore.collection(userCollection).add(userReq.toMap());
    return true;
  }

  static getUsers() {
    return firebaseFirestore.collection(userCollection).snapshots();
  }
}
