import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // State management ke liye

// Hum yeh files abhi banayenge
import 'api/auth_service.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home/home_screen.dart';

void main() async {
  // Firebase ko initialize karne ke liye yeh lines zaroori hain
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Aapke firebase_options.dart file se options yahan aayenge
    // Jab aap FlutterFire CLI use karenge toh yeh file automatically ban jayegi
    // options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // AuthService ko poore app mein available karwa rahe hain
    return Provider<AuthService>(
      create: (_) => AuthService(FirebaseAuth.instance),
      child: MaterialApp(
        title: 'DevConnect',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home:
            AuthWrapper(), // Yeh decide karega ki Login screen dikhana hai ya Home
      ),
    );
  }
}

// AuthWrapper check karta hai ki user logged in hai ya nahi
class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();

    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          // Agar user null hai, toh LoginScreen dikhao
          // Warna HomeScreen dikhao
          return user == null ? LoginScreen() : HomeScreen();
        }
        // Jab tak check ho raha hai, loading dikhao
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
