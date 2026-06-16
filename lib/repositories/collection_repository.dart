import 'package:artexplorer/models/artwork.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CollectionRepository {
  Future<List<Artwork>> loadCollection(String uid) async {
    final collection = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('savedArtworks')
        .get();
    return collection.docs.map((doc) => Artwork.fromMap(doc.data())).toList();
  }

  Future<void> saveArtwork(String uid, Artwork artwork) async {
    final map = {...artwork.toMap(), 'savedAt': FieldValue.serverTimestamp()};
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('savedArtworks')
        .doc('${artwork.id!}')
        .set(map);
  }

  Future<void> removeArtwork(String uid, int id) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('savedArtworks')
        .doc('$id')
        .delete();
  }
}
