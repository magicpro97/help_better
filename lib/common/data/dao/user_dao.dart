import 'dart:async';

import 'package:better_help/common/data/models/user.dart';
import 'package:better_help/common/data/tranformer/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class UserDao {
    static const String USERS = 'users';
    static final _store = Firestore.instance.collection(USERS);
    
    static Future<void> addUser(User user) async =>
        await _store.document(user.id).setData(user.toJson());
    
    static Future<void> updateUser({
        @required User user,
    }) async {
        final userJson = user.toJson();
        userJson['updated'] = Timestamp.now();
        await _store.document(user.id).updateData(userJson);
    }
    
    static Future<User> findById(String id) async {
        final doc = await _store.document(id).get();
        if (doc.exists) return User.fromJson(doc.data);
        return null;
    }
    
    static Future<List<User>> getOthersUser({
        @required String currentUserId,
    }) async {
        final docs = await _store.getDocuments();
        final List<User> users = [];
        docs.documents.forEach((doc) {
            final user = User.fromJson(doc.data);
            if (user.id != currentUserId) users.add(user);
        });
        return users;
    }
    
    static Future<List<User>> getHasKnowUser({
        @required String currentUserId,
    }) async {
        final currentUser = await findById(currentUserId);
        final users = <User>[];
        if (currentUser.friendIds == null || currentUser.friendIds.isEmpty) {
            return users;
        }
        for (final id in currentUser.friendIds) {
            users.add(await findById(id));
        }
        return users;
    }
    
    static Stream<List<User>> userListStream() =>
        _store.snapshots().transform(toListUser);
    
    static Stream<User> userStream(String id) =>
        _store.document(id).snapshots().transform(toUser);
}
