import 'package:flutter/material.dart';
import 'package:register_form/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> saveSignupDetails(
      String name, String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100))),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
                controller: emailController,
                decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100)))),
            SizedBox(
              height: 12,
            ),
            TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100)))),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () async {
                String name = nameController.text;
                String email = emailController.text;
                String password = passwordController.text;

                // Validate and save the signup details
                if (name.isNotEmpty &&
                    email.isNotEmpty &&
                    password.isNotEmpty) {
                  await saveSignupDetails(name, email, password);
                  // Remove the signup screen from the navigation stack
                  Navigator.pop(context);
                  // Navigate to the signin screen
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SigninScreen(),
                  ));
                } else {
                  // Handle validation errors
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please fill in all fields.'),
                  ));
                }
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signIn(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('email');
    String? savedPassword = prefs.getString('password');

    String enteredEmail = emailController.text;
    String enteredPassword = passwordController.text;

    // Validate the signin credentials
    if (enteredEmail == savedEmail && enteredPassword == savedPassword) {
      // Navigate to the home screen
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));
    } else {
      // Handle invalid credentials
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid email or password.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Signin')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: emailController,
                decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100)))),
            SizedBox(
              height: 12,
            ),
            TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100)))),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(
              // onPressed: () => signIn(context),
              onPressed: () {
                signIn(context);
              },
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
