import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_app_bar.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_button.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_text.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_text_field.dart';
import 'package:tanymtest_moderator_app/src/core/constants/app_colors.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/provider/group_provider.dart';

class AddGroupPage extends StatelessWidget {
  AddGroupPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController curatorController = TextEditingController();

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
          title: 'Добавить класс',
        ),
        backgroundColor: AppColors.background_color,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CommonText(
                text: 'Название класса',
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
                text: 'Куратор класса',
                color: AppColors.dark_grey_color,
              ),
              const SizedBox(height: 5),
              CommonTextField(
                keyboardType: TextInputType.text,
                controller: curatorController,
                hintText: '',
                obscureText: false,
                height: 50,
              ),
              const SizedBox(height: 20),
              CommonButton(
                itMustbe: true,
                onTap: () async {
                  if (nameController.text.isEmpty ||
                      curatorController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Пожалуйста, заполните все поля')),
                    );
                    return;
                  }

                  try {
                    await groupProvider.addGroup(
                      nameController.text,
                      curatorController.text,
                    );
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Ошибка при добавлении группы: $e')),
                    );
                  }
                },
                text: 'Добавить',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
