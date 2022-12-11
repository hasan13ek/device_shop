import 'package:device_shop/data/models/user_model.dart';
import 'package:device_shop/utils/my_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileViewModel {
  final FirebaseAuth _firebaseAuth;

  ProfileViewModel({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  UserModel? userModel;

  fetchProfileData() {
    userModel = UserModel(
        age: 0,
        userId: _firebaseAuth.currentUser!.uid,
        fullName: _firebaseAuth.currentUser!.displayName ?? "",
        email: _firebaseAuth.currentUser!.email ?? "",
        createdAt: DateTime.now().toString());
  }

  setUserName(String userName)async{
    try{
      _firebaseAuth.currentUser!.updateDisplayName(userName);
    } on FirebaseAuthException catch(error){
      MyUtils.getMyToast(message: error.message.toString());
    }
  }
}
