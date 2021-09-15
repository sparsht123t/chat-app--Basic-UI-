import 'package:chat_app1/services/auth.dart';
import 'package:chat_app1/views/chatrooms.dart';
import 'package:chat_app1/widget/widget.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  // Toggleview will be checked first,
  final Function toggleView;
  SignUp(this.toggleView);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  TextEditingController usernameEditingController = new TextEditingController();
  AuthService authService = new AuthService();

  singUp() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await authService
          .signUpWithEmailAndPassword(
              emailEditingController.text, passwordEditingController.text)
          .then((result) {
        if (result != null) {
          // Map<String,String> userDataMap = {
          //   "userName" : usernameEditingController.text,
          //   "userEmail" : emailEditingController.text
          // };

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Container(
          child: Column(
            children: [
              Spacer(),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      style: simpleTextStyle(),
                      controller: usernameEditingController,
                      validator: (val) {
                        return val!.isEmpty || val.length < 3
                            ? "Enter Username 3+ characters"
                            : null;
                      },
                      decoration: textFieldInputDecoration("username"),
                    ),
                    TextFormField(
                      controller: emailEditingController,
                      style: simpleTextStyle(),
                      validator: (val) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val!)
                            ? null
                            : "Enter correct email";
                      },
                      decoration: textFieldInputDecoration("email"),
                    ),
                    TextFormField(
                      obscureText: true,
                      style: simpleTextStyle(),
                      decoration: textFieldInputDecoration("password"),
                      controller: passwordEditingController,
                      validator: (val) {
                        return val!.length < 6
                            ? "Enter Password 6+ characters"
                            : null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  singUp();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xff007EF4),
                          const Color(0xff2A75BC)
                        ],
                      )),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Sign Up",
                    style: biggerTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Sign Up with Google",
                  style: TextStyle(
                    fontSize: 17,
                    //  color: CustomTheme.textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: simpleTextStyle(),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.toggleView();
                    },
                    child: Text(
                      "SignIn now",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
