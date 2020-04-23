import 'package:firebase_auth/firebase_auth.dart';
import 'package:prcolony/models/User.dart';

class AuthService {

  final FirebaseAuth auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user)
  {
    return user !=null? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return auth.onAuthStateChanged.map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  signIn(AuthCredential authCreds) {
    auth.signInWithCredential(authCreds);
  }

  Future signInWithOTP(smsCode, verId) async{
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    await auth.signInWithCredential(authCreds).then((AuthResult result){
      
    });
  }

 


}
