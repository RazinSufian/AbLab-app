import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/singin_controller.dart';
import '../../controller/singup_controller.dart';
import '../../res/image_assets.dart';
import '../../utils/components/round_text_bar.dart';  // Include the correct utility imports
import '../../utils/components/custom_rounded_btn.dart';

class AuthPage extends StatefulWidget {
  @override
  AuthPageState createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  List<bool> _isSelected = [true, false];
  SignUpController signUpController = Get.put(SignUpController());
  SignInController signInController = Get.put(SignInController());

  String? _passwordError;
  String? _confirmPasswordError;
  String? _signInError;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Glad to see you!',
                      style: TextStyle(
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.001),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.02), // Add left padding for Login text
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: screenWidth * 0.07,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // Row with text and image
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Add space between text and image
                children: [
                  // Leave the left side empty for spacing
                  Spacer(),

                  // Image aligned to the right
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: screenHeight * 0.1,
                      width: screenWidth * 0.2,
                      color: Colors.white,
                      child: Image.asset(ImageAssets.logo,
                        width: 150,  // Set width if needed
                        height: 150,),
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.09),
              Center(
                child: Column(
                  children: [
                    _buildTabBar(),
                    SizedBox(height: screenHeight * 0.03),
                    _isSelected[0] ? _buildSignInForm() : _buildSignUpForm(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        color: Color(0xFFE8E5F9),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Container(
        padding: EdgeInsets.all(5.0),
        height: 40.0,
        child: Row(
          children: <Widget>[
            _buildTabItem("Sign In", 0),
            _buildTabItem("Sign Up", 1),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(String text, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isSelected = [index == 0, index == 1];
            if (index == 0) {
              signInController.emailTextController = '';
              signInController.passwordTextController = '';
              _signInError = null;
            } else {
              signUpController.emailTextController = '';
              signUpController.passwordTextController = '';
              signUpController.confirmPasswordTextController = '';
              _passwordError = null;
              _confirmPasswordError = null;
            }
          });
        },
        child: Container(
          padding: EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            color: _isSelected[index] ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _isSelected[index] ? Color(0xFF636363) : Color(0xFF808080),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInForm() {
    return Column(
      children: [
        RoundInputField(
          name: 'Email Address',
          onChanged: (value) => signInController.emailTextController = value,
        ),
        RoundInputField(
          name: 'Password',
          isPassword: true,
          onChanged: (value) => signInController.passwordTextController = value,
        ),
        if (_signInError != null)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              _signInError!,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        CustomButton(
          text: 'Sign In',
          onPressed: () {
            // Add your sign in logic here
          },
        ),
      ],
    );
  }

  Widget _buildSignUpForm() {
    return Column(
      children: [
        RoundInputField(
          name: 'Email Address',
          onChanged: (value) => signUpController.emailTextController = value,
        ),
        RoundInputField(
          name: 'Password',
          isPassword: true,
          onChanged: (value) => signUpController.passwordTextController = value,
        ),
        RoundInputField(
          name: 'Confirm Password',
          isPassword: true,
          onChanged: (value) => signUpController.confirmPasswordTextController = value,
        ),
        if (_passwordError != null || _confirmPasswordError != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              _passwordError ?? _confirmPasswordError!,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        CustomButton(
          text: 'Sign Up',
          onPressed: () {
            // Add your sign up logic here
          },
        ),
      ],
    );
  }
}

