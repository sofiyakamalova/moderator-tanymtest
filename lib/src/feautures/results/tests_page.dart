import 'package:flutter/material.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_app_bar.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_custom_btn.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_text.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_title.dart';
import 'package:tanymtest_moderator_app/src/core/constants/app_colors.dart';
import 'package:tanymtest_moderator_app/src/feautures/results/screens/results_of_groups.dart';

class TestsPage extends StatelessWidget {
  const TestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CommonAppBar(
          title: 'Тесты',
        ),
        backgroundColor: AppColors.background_color,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 150,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: AppColors.white_color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                  child: Image.asset(
                    'assets/images/test_cover.png',
                    height: double.infinity,
                    fit: BoxFit.cover,
                    width: 120,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const CommonTitle(
                        text: 'Личный опросник ИСН',
                        size: 20,
                      ),
                      const CommonText(
                        text: '74 вопроса',
                        size: 16,
                        text_align: TextAlign.start,
                      ),
                      const CommonText(
                        text: '06.04.2024 - срок сдачи',
                        size: 16,
                        text_align: TextAlign.start,
                      ),
                      CommonCustomBtn(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResultsOfGroups()));
                        },
                        hor: 20,
                        vert: 6,
                        text: 'Посмотреть результаты',
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
