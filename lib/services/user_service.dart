import '../models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  UserService();

  // collection reference
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  Future<User> getUser(String id) async {
    DocumentSnapshot doc = await usersCollection.document(id).get();

    if (doc.exists == false) {
      return null;
    }

    return User.fromFirestore(doc);
  }

  List<User> _getUsersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) => User.fromFirestore(doc)).toList();
  }

  User _getUserFromDocumentSnapshot(DocumentSnapshot snapshot) {
    return User.fromFirestore(snapshot);
  }

  Future<List<User>> get users {
    return usersCollection.getDocuments().then((QuerySnapshot qs) {
      return qs.documents.map(_getUserFromDocumentSnapshot).toList();
    });
  }

  Future<User> addUser(User user) async {
    Map<String, dynamic> jsonMap = user.toJson();

    try {
      DocumentReference docRef = await usersCollection.add(jsonMap);
      print("Document written with ID: ${docRef.documentID}");

      return User.fromFirestore(await docRef.get());
    } catch (e) {
      print("Error adding document: $e");
      throw e;
    }
  }

  Future<User> setOrAddUser(User user) async {
    Map<String, dynamic> jsonMap = user.toJson();

    try {
      DocumentReference docRef = usersCollection.document(user.id);
      await docRef.setData(jsonMap, merge: true);
      print("Document updated with ID: ${docRef.documentID}");

      return User.fromFirestore(await docRef.get());
    } catch (e) {
      print("Error adding document: $e");
      throw e;
    }
  }

  Stream<User> getUserStream(String id) {
    if (id == null) {
      return null;
    }

    DocumentReference docRef = usersCollection.document(id);

    if (docRef == null) {
      return null;
    }

    return docRef.snapshots().map((doc) {
      if (!doc.exists) {
        return null;
      }

      return User.fromFirestore(doc);
    });
  }
}
