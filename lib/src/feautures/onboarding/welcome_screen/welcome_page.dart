import 'package:flutter/material.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_button.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_text.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_title.dart';
import 'package:tanymtest_moderator_app/src/core/constants/app_colors.dart';
import 'package:tanymtest_moderator_app/src/feautures/login/login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white_color,
        appBar: AppBar(
          backgroundColor: AppColors.white_color,
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CommonTitle(
                text: 'TanymTest',
                size: 37,
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: CommonText(
                  text_align: TextAlign.justify,
                  maxLines: 5,
                  text:
                      'Добро пожаловать в TanymTest! Пройдите нашу психологическую проверку и узнайте больше о своей личности, эмоциях и сильных сторонах. Начните свой путь к самопознанию прямо сейчас!',
                  size: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.low_primary_color,
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomCenter,
                child: CommonButton(
                    itMustbe: true,
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    text: 'Давайте начнем!'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
