import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creator_mind/features/auth/data/datasources/auth_remote_ds.dart';
import 'package:creator_mind/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/global/strings.dart';


class AuthRemoteDataSourceImpl  implements AuthRemoteDataSource {
  @override
  Future<UserModel> login(String email, String password)async {
    final response =await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    if(response.user?.uid!=null){
      return UserModel(id: response.user!.uid, name: response.user!.displayName??'', email: email);
    }else{
      throw Exception("Failed to login");
    }
  }

  @override
  Future<UserModel> register(Map<String, dynamic> data)async {
    final response =await FirebaseAuth.instance.createUserWithEmailAndPassword(email: data["email"], password: data["password"]);
    final safeData = Map<String, dynamic>.from(data)
      ..remove("password")
      ..addAll({"id":response.user?.uid});
    if(response.user?.uid!=null){
      await FirebaseFirestore.instance.collection("creator_minds_users").doc("${response.user?.uid}").set(safeData);
      return UserModel(id: response.user!.uid, name: response.user!.displayName??'', email: data["email"]);
    }else{
      throw Exception("Failed to register");
    }
  }
}