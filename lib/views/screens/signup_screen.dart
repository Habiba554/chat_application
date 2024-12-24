import 'package:chat_app/constants/app_colors.dart';
import 'package:chat_app/constants/app_strings.dart';
import 'package:chat_app/constants/app_style.dart';
import 'package:chat_app/services/user_authentication.dart';
import 'package:chat_app/views/widgets/custom_button.dart';
import 'package:chat_app/views/widgets/custom_textfield.dart';
import 'package:chat_app/views/widgets/have_account.dart';
import 'package:chat_app/views/widgets/snack_bar.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserAuthentication userAuthentication = UserAuthentication();
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Text(
                    AppStrings.signup,
                    style: AppStyle.poppins600style35
                        .copyWith(color: AppColors.whiteColor),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  CustomFormTextField(
                    controller: emailController,
                    hint: AppStrings.emailAddress,
                    prefix: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter your Email';
                      } else if (!value.endsWith('@gmail.com')) {
                        return 'Email format should be (Ex. user@gmail.com)';
                      }
                      return null;
                    },
                  ),
                  CustomFormTextField(
                    prefix: Icons.phone,
                    controller: phoneNumber,
                    hint: AppStrings.phoneNumber,
                    startNumber: '+20 ',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number is required.';
                      }
                      if (!RegExp(r'^[1][0-9]{9}$').hasMatch(value)) {
                        return 'Enter a valid 10-digit Egyptian phone number (e.g., 10XXXXXXXX).';
                      }
                      return null;
                    },
                  ),
                  CustomFormTextField(
                    controller: passwordController,
                    hint: AppStrings.password,
                    suffix: Icons.visibility_off,
                    prefix: Icons.lock,
                    isObscureText: true,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter your Password';
                      } else if (value.length < 8) {
                        return "Password should be from 8 to 20 characters";
                      }
                      return null;
                    },
                  ),
                  CustomFormTextField(
                    controller: confirmPasswordController,
                    hint: AppStrings.confirmPassword,
                    suffix: Icons.visibility_off,
                    prefix: Icons.lock,
                    isObscureText: true,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Confirm  Password';
                      } else if (confirmPasswordController.text !=
                          passwordController.text) {
                        return "Your password does not match";
                      }
                      return null;
                    },
                  ),
                  CustomElevatedButton(
                    text: AppStrings.signup,
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        userAuthentication.registerUser(context,
                            emailController.text, passwordController.text,phoneNumber.text);
                      } else {
                        showSnackBars(msg: 'There was an error', context);
                      }
                    },
                    backgroundColor: AppColors.whiteColor,
                    textColor: AppColors.primaryColor,
                  ),
                  const HaveAnAccount()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
