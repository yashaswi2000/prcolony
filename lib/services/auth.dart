import 'package:firebase_auth/firebase_auth.dart';
import 'package:prcolony/models/User.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await auth.currentUser();
  assert(user.uid == currentUser.uid);

  return 'signInWithGoogle succeeded: $user';
  }

  Future signOutGoogle() async{
     
     try {
       await googleSignIn.signOut();
      return await auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }

  //print("User Sign Out");
  }



  User _userFromFirebaseUser(FirebaseUser user)
  {
    return user !=null? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return auth.onAuthStateChanged.map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

   Future signOut() async{
    try {
      return await auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
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
