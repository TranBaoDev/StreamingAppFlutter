import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_streaming_app/screens/home_screen.dart';
import 'package:flutter_streaming_app/screens/login_screen.dart';
import 'package:flutter_streaming_app/services/auth/auth_methods.dart';
import 'package:flutter_streaming_app/utils/colors.dart';
import 'package:flutter_streaming_app/widgets/custom_button.dart';
import 'package:flutter_streaming_app/widgets/custom_textfield.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signUp';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final AuthMethods _authMethods = AuthMethods();

  void signUpUser() async {
    bool res = await _authMethods.signUpUser(
      context,
      _emailController.text,
      _usernameController.text,
      _passwordController.text,
    );
    if(res){
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }

  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(''),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'Create account',
                      style: GoogleFonts.sora(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    "Let's start tour live now!",
                    style: GoogleFonts.sora(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: secondTextColor,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  MyTextField(
                    hintText: 'example@gmail',
                    obscureText: false,
                    controller: _emailController,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  //Password Text field
                  MyTextField(
                    hintText: 'Enter your username',
                    obscureText: false,
                    controller: _usernameController,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  //Password Text field
                  MyTextField(
                    hintText: 'Enter your password',
                    obscureText: true,
                    controller: _passwordController,
                  ),
                  Row(
                    textDirection: TextDirection.ltr,
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                        activeColor: Colors.white70,
                        checkColor: Colors.black,
                        side: MaterialStateBorderSide.resolveWith(
                            (states) => BorderSide(
                                  width: 1.0,
                                  color: Colors.black,
                                )),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isChecked = isChecked != null ? !isChecked! : true;
                          });
                        },
                        child: Text(
                          'I agree to the terms and conditions',
                          style: GoogleFonts.rubik(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
                    child: CustomButton(onTap: signUpUser, text: "Sign up"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: GoogleFonts.rubik(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: secondTextColor,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Log in',
                              style: const TextStyle(
                                color: primaryTextColor,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Handle the "Sign Up" action here
                                  Navigator.of(context)
                                      .pushNamed(LoginScreen.routeName);
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
