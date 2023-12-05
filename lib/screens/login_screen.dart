import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_streaming_app/screens/home_screen.dart';
import 'package:flutter_streaming_app/screens/signup_screen.dart';
import 'package:flutter_streaming_app/services/auth/auth_methods.dart';
import 'package:flutter_streaming_app/utils/colors.dart';
import 'package:flutter_streaming_app/widgets/custom_button.dart';
import 'package:flutter_streaming_app/widgets/custom_textfield.dart';
import 'package:flutter_streaming_app/widgets/loading_indicator.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/logIn';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthMethods _authMethods = AuthMethods();

  bool _isLoading = false;

  logInUser() async {
    setState(() {
      _isLoading = true;
    });
    bool res = await _authMethods.logInUser(
      context,
      _emailController.text,
      _passwordController.text,
    );
    setState(() {
      _isLoading = false;
    });
    if (res) {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
        title: Text(''),
        centerTitle: true,
      ),
      body: _isLoading
          ? const LoadingIndicator()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            'Welcome back',
                            style: GoogleFonts.sora(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "Hello again, You've been missed!",
                          style: GoogleFonts.sora(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: secondTextColor,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        //Email Text field
                        CustomTextField(
                          hintText: 'example@gmail',
                          obscureText: false,
                          controller: _emailController,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        //Password Text field
                        CustomTextField(
                          hintText: 'Enter your password',
                          obscureText: true,
                          controller: _passwordController,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                print('Navigate to forgot screen');
                              },
                              child: Text(
                                'Forgot password?',
                                style: GoogleFonts.rubik(
                                    fontSize: 16,
                                    color: primaryTextColor,
                                    decoration: TextDecoration.underline),
                              ),
                            )),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 25.0, bottom: 10.0),
                          child: CustomButton(
                            onTap: logInUser,
                            text: "Log in",
                            backgroundColor: backgroundColor,
                            textColor: textBtnColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: "Don’t Have An Account? ",
                                style: GoogleFonts.rubik(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: secondTextColor,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Sign Up',
                                    style: const TextStyle(
                                      color: primaryTextColor,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Handle the "Sign Up" action here
                                        Navigator.of(context)
                                            .pushNamed(SignUpScreen.routeName);
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
                        Row(
                          children: [
                            Expanded(
                                child: Divider(
                              color: Colors.black,
                            )),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                'OR',
                                style: GoogleFonts.rubik(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w200,
                                    color: secondTextColor),
                              ),
                            ),
                            Expanded(
                                child: Divider(
                              color: Colors.black,
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CustomOtherButton(
                          onTap: () {},
                          text: 'Login with Google',
                          imagePath: 'assets/icons/google-icon.png',
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        CustomOtherButton(
                          onTap: () {},
                          imagePath: 'assets/icons/apple-icon.png',
                          text: 'Login with Apple',
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
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
