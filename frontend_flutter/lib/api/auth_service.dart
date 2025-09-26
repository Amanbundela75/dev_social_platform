import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Android Emulator ke liye localhost 10.0.2.2 hota hai
  // Agar iOS simulator use kar rahe hain toh 'localhost' ya '127.0.0.1' chalega
  final String _djangoApiUrl = "http://10.0.2.2:8000/api/v1/auth/sync/";

  AuthService(this._firebaseAuth);

  // Auth state change ko sunne ke liye stream
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Helper function: Firebase user ko Django backend se sync karne ke liye
  Future<void> _syncUserWithBackend(User user) async {
    try {
      final response = await http.post(
        Uri.parse(_djangoApiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'firebase_uid': user.uid,
          'email': user.email,
          'display_name': user.displayName ?? '',
          'profile_picture_url': user.photoURL ?? '',
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("User synced with backend successfully.");
        // Yahan aap user profile ko app mein (e.g., SharedPreferences) save kar sakte hain
      } else {
        print("Backend sync failed: ${response.body}");
      }
    } catch (e) {
      print("Error syncing with backend: $e");
    }
  }

  // Google se Sign In
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // User ne sign-in cancel kar diya
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Backend se sync karein
        await _syncUserWithBackend(user);
      }
      return user;

    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }

  // Email/Password se Sign Up
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;

      if (user != null) {
        // Backend se sync karein
        await _syncUserWithBackend(user);
      }
      return user;
    } on FirebaseAuthException catch (e) {
      print("Email Sign-Up Error: ${e.message}");
      return null;
    }
  }

  // Email/Password se Sign In
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Yahan sync ki zaroorat nahi, kyunki signup par ho gaya tha
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("Email Sign-In Error: ${e.message}");
      return null;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}