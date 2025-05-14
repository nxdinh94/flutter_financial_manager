import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart' show GoogleSignIn, GoogleSignInAccount;

const List<String> _scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];
class SignInWithGoogle{
  late GoogleSignIn googleSignIn;
  GoogleSignInAccount ? currentUser;
  late bool isAuthorized; // has granted permissions?
  SignInWithGoogle(){
    googleSignIn = GoogleSignIn(
      scopes: _scopes,
    );
    googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      bool isAuthorized = account != null;
      // However, on web...
      if (kIsWeb && account != null) {
        isAuthorized = await googleSignIn.canAccessScopes(_scopes);
      }
      currentUser = account;
      this.isAuthorized = isAuthorized;
      if (isAuthorized) {
        // unawaited(_handleGetContact(account!));
      }
    });
    googleSignIn.signInSilently();
  }
}