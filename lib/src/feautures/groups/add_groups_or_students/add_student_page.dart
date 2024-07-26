import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_app_bar.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_button.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_text.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_text_field.dart';
import 'package:tanymtest_moderator_app/src/core/constants/app_colors.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/provider/group_provider.dart';

class AddStudentPage extends StatelessWidget {
  final String groupId;
  AddStudentPage({super.key, required this.groupId});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final groupProvider = Provider.of<GroupProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(
          background_color: AppColors.background_color,
          onTap: () {
            Navigator.pop(context);
          },
          text_color: AppColors.primary_color,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.primary_color,
          ),
          title: 'Добавить студента',
        ),
        backgroundColor: AppColors.background_color,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonText(
                  text: 'Имя студента',
                  color: AppColors.dark_grey_color,
                ),
                const SizedBox(height: 5),
                CommonTextField(
                  keyboardType: TextInputType.text,
                  controller: nameController,
                  hintText: '',
                  obscureText: false,
                  height: 50,
                ),
                const SizedBox(height: 20),
                const CommonText(
                  text: 'Email студента',
                  color: AppColors.dark_grey_color,
                ),
                const SizedBox(height: 5),
                CommonTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  hintText: '',
                  obscureText: false,
                  height: 50,
                ),
                const SizedBox(height: 20),
                const CommonText(
                  text: 'Телефон студента',
                  color: AppColors.dark_grey_color,
                ),
                const SizedBox(height: 5),
                CommonTextField(
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  hintText: '',
                  obscureText: false,
                  height: 50,
                ),
                const SizedBox(height: 20),
                const CommonText(
                  text: 'Пол студента',
                  color: AppColors.dark_grey_color,
                ),
                const SizedBox(height: 5),
                CommonTextField(
                  keyboardType: TextInputType.text,
                  controller: genderController,
                  hintText: '',
                  obscureText: false,
                  height: 50,
                ),
                const SizedBox(height: 20),
                const CommonText(
                  text: 'Пароль',
                  color: AppColors.dark_grey_color,
                ),
                const SizedBox(height: 5),
                CommonTextField(
                  keyboardType: TextInputType.text,
                  controller: passwordController,
                  hintText: '',
                  obscureText: false,
                  height: 50,
                ),
                const SizedBox(height: 20),
                CommonButton(
                  itMustbe: true,
                  onTap: () async {
                    if (nameController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        phoneController.text.isEmpty ||
                        genderController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Пожалуйста, заполните все поля')),
                      );
                      return;
                    }

                    try {
                      await groupProvider.registerStudent(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        gender: genderController.text,
                        password: passwordController.text,
                        schoolId: groupProvider.schoolId,
                        groupId: groupId,
                      );
                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('Ошибка при добавлении студента: $e')),
                      );
                    }
                  },
                  text: 'Добавить',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
