import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/padding.dart';
import 'package:fe_financial_manager/generated/assets.dart';
import 'package:fe_financial_manager/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart' show GoogleSignIn, GoogleSignInAccount;
import 'dart:async';
import 'dart:convert' show json;

import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '753230989469-m7jncgt7isv15vthjd38jb5boh19sci7.apps.googleusercontent.com',
  // serverClientId: '395399957037-6f7ib9vn55go6s4vga0h21assb6u9fji.apps.googleusercontent.com',
  scopes: scopes,
);

class GoogleLogin extends StatefulWidget {
  const GoogleLogin({super.key});

  @override
  State<GoogleLogin> createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> {

  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false; // has granted permissions?
  String _contactText = '';

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
    // #docregion CanAccessScopes
      // In mobile, being authenticated means being authorized...
      bool isAuthorized = account != null;
      // However, on web...
      if (kIsWeb && account != null) {
        isAuthorized = await _googleSignIn.canAccessScopes(scopes);
      }
      // #enddocregion CanAccessScopes

      setState(() {
        _currentUser = account;
        _isAuthorized = isAuthorized;
      });

      // Now that we know that the user can access the required scopes, the app
      // can call the REST API.
      if (isAuthorized) {
        unawaited(_handleGetContact(account!));
      }
    });


    _googleSignIn.signInSilently();
  }
  // Calls the People API REST endpoint for the signed-in user to retrieve information.
  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
    json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
          (dynamic contact) => (contact as Map<Object?, dynamic>)['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final List<dynamic> names = contact['names'] as List<dynamic>;
      final Map<String, dynamic>? name = names.firstWhere(
            (dynamic name) =>
        (name as Map<Object?, dynamic>)['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? user = await _googleSignIn.signIn();
      if (user == null) return;

      final GoogleSignInAuthentication auth = await user.authentication;

      final String? idToken = auth.idToken;
      Map<String, dynamic> data = {
        'idToken': idToken,
      };
      await context.read<AuthViewModel>().loginWithGoogleApi(data, context);
    } catch (error) {
      print('Sign-in error: $error');
    }
  }

  Future<void> _handleAuthorizeScopes() async {
    final bool isAuthorized = await _googleSignIn.requestScopes(scopes);
    // #enddocregion RequestScopes
    setState(() {
      _isAuthorized = isAuthorized;
    });
    // #docregion RequestScopes
    if (isAuthorized) {
      unawaited(_handleGetContact(_currentUser!));
    }
    // #enddocregion RequestScopes
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();
  Widget _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
    // if (user != null) {
      // Người dùng đã đăng nhập thành công
      // return Column(
      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //   children: <Widget>[
      //     ListTile(
      //       leading: GoogleUserCircleAvatar(
      //         identity: user,
      //       ),
      //       title: Text(user.displayName ?? 'No name'),
      //       subtitle: Text(user.email),
      //     ),
          // const Text('Signed in successfully.'),
          // if (_isAuthorized) ...<Widget>[
          //   // Người dùng đã cấp phép các quyền yêu cầu
          //   Text(_contactText), // Hiển thị thông tin liên quan đến người dùng
          //   ElevatedButton(
          //     child: const Text('REFRESH'),
          //     onPressed: () => _handleGetContact(user),
          //   ),
          // ],
          // if (!_isAuthorized) ...<Widget>[
          //   // Người dùng chưa cấp phép đủ các quyền
          //   const Text('Additional permissions needed to read your contacts.'),
          //   ElevatedButton(
          //     onPressed: _handleAuthorizeScopes,
          //     child: const Text('REQUEST PERMISSIONS'),
          //   ),
          // ],
    //       ElevatedButton(
    //         onPressed: _handleSignOut,
    //         child: const Text('SIGN OUT'),
    //       ),
    //     ],
    //   );
    // } else {
    //   // Người dùng chưa đăng nhập
    //
    // }
    return LoginWithGoogle(
      handleLogin: _handleSignIn,
      handleSignOut: _handleSignOut,
    );
  }


  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}

class LoginWithGoogle extends StatelessWidget {
  const LoginWithGoogle({
    super.key, required this.handleLogin, required this.handleSignOut,
  });
  final Future<void> Function() handleLogin;
  final Future<void> Function() handleSignOut;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: handleLogin,
      onDoubleTap: handleSignOut,
      child: Container(
        padding: defaultHalfPadding,
        decoration: BoxDecoration(
          border: Border.all(color: emergencyColor),
          borderRadius: BorderRadius.circular(6)
        ),
        child: Row(
          children: [
            SvgPicture.asset(Assets.svgGoogle, width: 24),
            const SizedBox(width: 24),
            Text('Sign in with Google', style: Theme.of(context).textTheme.titleLarge,),
          ],
        ),
      ),
    );
  }
}
