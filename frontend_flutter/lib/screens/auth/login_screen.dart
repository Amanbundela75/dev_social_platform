import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();

    return Scaffold(
      appBar: AppBar(title: Text("DevConnect - Login")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: _isLoading
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: "Email"),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: "Password"),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        setState(() => _isLoading = true);
                        await authService.signInWithEmail(
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                        );
                        // AuthWrapper baaki kaam kar dega
                        if (mounted) {
                          setState(() => _isLoading = false);
                        }
                      },
                      child: Text("Login"),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        // Sign Up logic. Aap ek alag screen bana sakte hain.
                        // Abhi ke liye, hum sign up bhi try kar lete hain
                        setState(() => _isLoading = true);
                        await authService.signUpWithEmail(
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                        );
                        if (mounted) {
                          setState(() => _isLoading = false);
                        }
                      },
                      child: Text("Sign Up"),
                    ),
                    SizedBox(height: 20),
                    Divider(),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        setState(() => _isLoading = true);
                        await authService.signInWithGoogle();
                        if (mounted) {
                          setState(() => _isLoading = false);
                        }
                      },
                      child: Text("Sign In with Google"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
