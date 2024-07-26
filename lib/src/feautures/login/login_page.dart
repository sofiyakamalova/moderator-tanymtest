import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_button.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_text_field.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_title.dart';
import 'package:tanymtest_moderator_app/src/core/constants/app_colors.dart';
import 'package:tanymtest_moderator_app/src/feautures/login/provider/auth_provider.dart';
import 'package:tanymtest_moderator_app/src/feautures/navigation/bottom_nav_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  IconData iconPassword = Icons.remove_red_eye_rounded;
  bool obscurePassword = true;
  Color suffixColor = AppColors.dark_grey_color;

  void signIn() async {
    final authService = Provider.of<AuthProvider>(context, listen: false);
    try {
      await authService.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const BottomNavBar()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background_color,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.primary_color,
              size: 32,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: AppColors.background_color,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/sign_in.png',
                  width: 303,
                ),
                const CommonTitle(
                  text: 'Войдите с помощью корпоративной электронной почты',
                  size: 19,
                ),
                const SizedBox(height: 25),
                CommonTextField(
                  txtInpAct: TextInputAction.next,
                  controller: emailController,
                  hintText: 'Электронная почта',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),
                CommonTextField(
                  txtInpAct: TextInputAction.done,
                  controller: passwordController,
                  hintText: 'Пароль',
                  obscureText: obscurePassword,
                  keyboardType: TextInputType.visiblePassword,
                  suffixColor: suffixColor,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                        if (obscurePassword) {
                          iconPassword = Icons.remove_red_eye_rounded;
                          suffixColor = AppColors.dark_grey_color;
                        } else {
                          iconPassword = Icons.remove_red_eye_rounded;
                          suffixColor = AppColors.primary_color;
                        }
                      });
                    },
                    icon: Icon(iconPassword),
                  ),
                ),
                const SizedBox(height: 25),
                CommonButton(
                  itMustbe: true,
                  onTap: () async {
                    signIn();
                  },
                  text: 'Войти',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
