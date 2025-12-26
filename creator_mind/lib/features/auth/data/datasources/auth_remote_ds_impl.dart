import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creator_mind/features/auth/data/datasources/auth_remote_ds.dart';
import 'package:creator_mind/features/auth/data/models/user_model.dart';
import 'package:creator_mind/features/auth/domain/usecases/register_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';


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
  Future<UserModel> register(RegisterParams data)async {
    final response =await FirebaseAuth.instance.createUserWithEmailAndPassword(email: data.email, password: data.password);

    final safeData = {
      "id": response.user?.uid,
      "first_name": data.firstName,
      "last_name": data.lastName,
      "class": data.className,
      "gender": data.gender,
      "email": data.email,
      "number": data.phone,
    };
    if(response.user?.uid!=null){
      await FirebaseFirestore.instance.collection("creator_minds_users").doc("${response.user?.uid}").set(safeData);
      return UserModel(id: response.user!.uid, name: response.user!.displayName??'', email: data.email);
    }else{
      throw Exception("Failed to register");
    }
  }
}