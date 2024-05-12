import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_app_bar.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_text.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_title.dart';
import 'package:tanymtest_moderator_app/src/core/constants/app_colors.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/add_groups_or_students/add_group_page.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/provider/group_provider.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/students_list_page.dart';
import 'package:tanymtest_moderator_app/src/feautures/login/provider/auth_provider.dart';
import 'package:tanymtest_moderator_app/src/feautures/login/psychologist_model.dart';
import 'package:tanymtest_moderator_app/src/feautures/onboarding/onboarding_page.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  final AuthProvider _authProvider = AuthProvider();

  @override
  void initState() {
    super.initState();
    initGroupLoading();
  }

  Future<void> initGroupLoading() async {
    try {
      String school_id = await Provider.of<AuthProvider>(context, listen: false)
          .fetchSchoolId();
      await Provider.of<GroupProvider>(context, listen: false)
          .getGroups(school_id);
    } catch (e) {
      print("Ошибка при загрузке групп: $e");
    }
  }

  //sign out function
  void signOut() {
    final authService = Provider.of<AuthProvider>(context, listen: false);
    if (!mounted) return;
    authService.signOut().then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingPage()),
      );
    }).catchError((error) {
      print('Error signing out: $error');
    });
  }

  void _showDialog(BuildContext context, String groupId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: AppColors.white_color,
          alignment: Alignment.center,
          contentPadding: const EdgeInsets.all(0),
          content: TextButton(
            onPressed: () async {
              String school_id =
                  await Provider.of<AuthProvider>(context, listen: false)
                      .fetchSchoolId();
              await Provider.of<GroupProvider>(context, listen: false)
                  .deleteGroup(school_id, groupId);
              //initGroupLoading();
              Navigator.pop(context);
            },
            child: const CommonText(
              text: 'Удалить группу',
              fontWeight: FontWeight.w500,
              color: AppColors.primary_color,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<PsychologistModel?>(
          future: _authProvider.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child:
                    CircularProgressIndicator(color: AppColors.primary_color),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('User not found'));
            } else {
              PsychologistModel? user = snapshot.data;
              if (user == null) {
                return const Center(child: Text('User not found'));
              } else {
                return Scaffold(
                  appBar: CommonAppBar(
                    title: 'Классы',
                    icon: const Icon(Icons.logout_outlined),
                    onTap: signOut,
                  ),
                  backgroundColor: AppColors.background_color,
                  body: RefreshIndicator(
                    onRefresh: initGroupLoading,
                    color: AppColors.primary_color,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 5.0),
                            decoration: BoxDecoration(
                              color: AppColors.light_primary_color,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CommonText(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary_color,
                                  text: user.name,
                                  size: 19,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    size: 21,
                                    Icons.settings,
                                    color: AppColors.grey_color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Consumer<GroupProvider>(
                            builder: (context, groupProvider, child) {
                              return GridView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20.0,
                                  mainAxisSpacing: 20.0,
                                  mainAxisExtent: 90,
                                ),
                                itemCount: groupProvider.groups.length,
                                itemBuilder: (context, index) {
                                  var group = groupProvider.groups[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              StudentsListPage(group: group),
                                        ),
                                      );
                                    },
                                    onLongPress: () {
                                      _showDialog(context, group.group_id);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(15.0),
                                      decoration: BoxDecoration(
                                        color: AppColors.white_color,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CommonTitle(
                                            text: group.group_name,
                                            text_align: TextAlign.start,
                                            maxLines: 1,
                                          ),
                                          CommonText(
                                            text:
                                                '${group.students.length} студента',
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: AppColors.primary_color,
                    shape: const CircleBorder(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddGroupPage(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.add,
                      color: AppColors.white_color,
                    ),
                  ),
                );
              }
            }
          }),
    );
  }
}
