import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_app_bar.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_button.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_text.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_text_field.dart';
import 'package:tanymtest_moderator_app/src/core/constants/app_colors.dart';
import 'package:tanymtest_moderator_app/src/feautures/login/provider/auth_provider.dart';
import 'package:tanymtest_moderator_app/src/feautures/login/psychologist_model.dart';

import '../provider/group_provider.dart';

class AddStudentPage extends StatelessWidget {
  final String groupId;
  AddStudentPage({
    super.key,
    required this.groupId,
  });

  final TextEditingController nameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthProvider _authProvider = AuthProvider();
  @override
  Widget build(BuildContext context) {
    final groupProvider = Provider.of<GroupProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(
          title: 'Добавить студента',
          onTap: () {
            Navigator.pop(context);
          },
          background_color: AppColors.background_color,
          text_color: AppColors.primary_color,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.primary_color,
          ),
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
                  txtInpAct: TextInputAction.next,
                ),
                const SizedBox(height: 15),
                const CommonText(
                  text: 'Почта',
                  color: AppColors.dark_grey_color,
                ),
                const SizedBox(height: 5),
                CommonTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  hintText: '',
                  obscureText: false,
                  height: 50,
                  txtInpAct: TextInputAction.next,
                ),
                const SizedBox(height: 15),
                const CommonText(
                  text: 'Номер телефона',
                  color: AppColors.dark_grey_color,
                ),
                const SizedBox(height: 5),
                CommonTextField(
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  hintText: '',
                  obscureText: false,
                  height: 50,
                  txtInpAct: TextInputAction.next,
                ),
                const SizedBox(height: 15),
                const CommonText(
                  text: 'Пароль',
                  color: AppColors.dark_grey_color,
                ),
                const SizedBox(height: 5),
                CommonTextField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  hintText: '',
                  obscureText: false,
                  height: 50,
                  txtInpAct: TextInputAction.next,
                ),
                const SizedBox(height: 15),
                const CommonText(
                  text: 'Пол',
                  color: AppColors.dark_grey_color,
                ),
                const SizedBox(height: 5),
                CommonTextField(
                  keyboardType: TextInputType.text,
                  controller: genderController,
                  hintText: '',
                  obscureText: false,
                  height: 50,
                  txtInpAct: TextInputAction.next,
                ),
                const SizedBox(height: 15),
                CommonButton(
                  itMustbe: true,
                  onTap: () async {
                    final PsychologistModel? user =
                        await _authProvider.getUserData();

                    await groupProvider.registerStudent(
                      email: emailController.text,
                      password: passwordController.text,
                      name: nameController.text,
                      phone: phoneController.text,
                      schoolId: user!.school_id,
                      groupId: groupId,
                      gender: genderController.text,
                    );
                    Navigator.pop(context);
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
