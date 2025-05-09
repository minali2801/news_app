import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/news_feed_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade200, Colors.green.shade100],
          ),
        ),
        child: Form(
          key: _formkey,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 50),
                    Text(
                      'Login',
                      style: GoogleFonts.lato(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Welcome User!!',
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 80),
                    buildTextFormField(
                      controller: _emailController,
                      lable: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: emailValidator,
                    ),
                    SizedBox(height: 20),
                    buildTextFormField(
                      controller: _passwordController,
                      lable: 'Password',
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.withOpacity(.8),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        elevation: 6,
                      ),
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('isLoggedin', true);
                            
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 1),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.grey,
                                content: Text('Congratulations \n You are logged in'),
                              ),
                            );
                            
                            Future.delayed(Duration(seconds: 2), () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => NewsFeedPage()),
                              );
                            });
                          });
                        }
                      },
                      child: Text('Login'),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
Widget buildTextFormField({
  required TextEditingController controller,
  required String lable,
  TextInputType? keyboardType,
  bool obscureText = false,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    keyboardType: keyboardType,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    decoration: InputDecoration(
      labelText: lable,
      labelStyle: TextStyle(color: Colors.blue.shade800, fontSize: 18),
      filled: true,
      fillColor: Colors.white.withOpacity(0.8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: Colors.blue.shade800),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    ),
    validator: validator,
  );
}

// Email validation function using regular expression
String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  if (!EmailValidator.validate(value)) {
    return 'Please enter a valid email address';
  }
  return null;
  //  String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  //   RegExp regex = RegExp(emailPattern);
  //   if (!regex.hasMatch(value)) {
  //     return 'Please enter a valid email address';
  //   }
  //   return null;
}     