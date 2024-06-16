import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_app_bar.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_text.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_title.dart';
import 'package:tanymtest_moderator_app/src/core/constants/app_colors.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/add_groups_or_students/add_group_page.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/model/group_model.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/provider/group_provider.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/students_list_page.dart';
import 'package:tanymtest_moderator_app/src/feautures/login/provider/auth_provider.dart';
import 'package:tanymtest_moderator_app/src/feautures/onboarding/onboarding_page.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  late Stream<List<GroupModel>> _groupStream;

  @override
  void initState() {
    _initializeStreams();
    super.initState();
  }
  // void _initializeStreams() async {
  //   final ResultProvider _resultProvider = ResultProvider();
  //   _resultStream = _resultProvider.getResults();
  //   setState(() {});
  // }

  void _initializeStreams() async {
    // final PsychologistModel? user = await _authProvider.getUserData();
    final GroupProvider _groupProvider = GroupProvider();
    _groupStream = _groupProvider.getGroups('jihc08');
    setState(() {});
  }

  Future<void> _showDialog(BuildContext context, String groupId) async {
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
              await Provider.of<GroupProvider>(context, listen: false)
                  .deleteGroup('jihc08', groupId);
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CommonAppBar(
          title: 'Группы',
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<List<GroupModel>>(
            stream: _groupStream,
            builder: (context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 20.0,
                        mainAxisExtent: 90,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        GroupModel group = snapshot.data![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StudentsListPage(
                                  group: group,
                                ),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CommonTitle(
                                  text: group.group_name,
                                  text_align: TextAlign.start,
                                  maxLines: 1,
                                ),
                                CommonText(
                                  text:
                                      '${group.students.length.toString()} студент',
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Container();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary_color,
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddGroupPage()),
            );
          },
          child: const Icon(
            Icons.add,
            color: AppColors.white_color,
          ),
        ),
      ),
    );
  }
}
