import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/singin_controller.dart';
import '../../controller/singup_controller.dart';
import '../../res/app_colors.dart';
import '../../res/image_assets.dart';
import '../../routes/routes_name.dart'; // Make sure to import RoutesName
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spacer(),
                  // Image aligned to the right
                  Expanded(  // Wrap the Container with Expanded to give it more space
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        color: Colors.white,
                        child: Image.asset(
                          ImageAssets.logo_2,
                          width: screenWidth * 0.25,  // Use screenWidth to adjust the size dynamically
                          height: screenHeight * 0.10, // Use screenHeight to adjust the size dynamically
                          fit: BoxFit.contain,  // Adjust the fit property to change how the image fills the space
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.015),
              Center(
                child: Column(
                  children: [
                    _buildTabBar(),
                    SizedBox(height: screenHeight * 0.02),
                    _isSelected[0] ? _buildSignInForm(context) : _buildSignUpForm(),
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
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        color: AppColors.light_grayColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Container(
        padding: EdgeInsets.all(5.0),
        height: screenHeight * 0.05,
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

  Widget _buildSignInForm(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height; // Define screenHeight here
    return Column(
      children: [
        SizedBox(height: screenHeight * 0.034),
        RoundInputField(
          name: 'Email Address',
          onChanged: (value) => signInController.emailTextController = value,
        ),
        SizedBox(height: screenHeight * 0.015),
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
            // Navigate to the menu page
            Navigator.pushNamedAndRemoveUntil(context, RoutesName.menu, (route) => false);
          },
        ),
      ],
    );
  }

  Widget _buildSignUpForm() {
    var screenHeight = MediaQuery.of(context).size.height; // Define screenHeight here
    return Column(
      children: [
        SizedBox(height: screenHeight * 0.034),
        RoundInputField(
          name: 'Email Address',
          onChanged: (value) => signUpController.emailTextController = value,
        ),
        SizedBox(height: screenHeight * 0.015),
        RoundInputField(
          name: 'Password',
          isPassword: true,
          onChanged: (value) => signUpController.passwordTextController = value,
        ),
        SizedBox(height: screenHeight * 0.015),
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
            // Navigate to the menu page
            Navigator.pushReplacementNamed(context, RoutesName.menu);
          },
        ),
      ],
    );
  }
}
