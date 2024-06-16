import 'package:flutter/material.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_app_bar.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_text.dart';
import 'package:tanymtest_moderator_app/src/core/common/common_text_field.dart';
import 'package:tanymtest_moderator_app/src/core/constants/app_colors.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/model/group_model.dart';
import 'package:tanymtest_moderator_app/src/feautures/groups/provider/group_provider.dart';
import 'package:tanymtest_moderator_app/src/feautures/results/screens/results_of_students.dart';

class ResultsOfGroups extends StatefulWidget {
  const ResultsOfGroups({super.key});

  @override
  State<ResultsOfGroups> createState() => _ResultsOfGroupsState();
}

class _ResultsOfGroupsState extends State<ResultsOfGroups> {
  late Stream<List<GroupModel>> _groupStream;
  // final AuthProvider _authProvider = AuthProvider();
  @override
  void initState() {
    // TODO: implement initState
    _initializeStreams();
    super.initState();
  }

  void _initializeStreams() async {
    // final PsychologistModel? user = await _authProvider.getUserData();
    final GroupProvider _groupProvider = GroupProvider();
    _groupStream = _groupProvider.getGroups('jihc08');
    setState(() {});
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(
          onTap: () {
            Navigator.pop(context);
          },
          title: 'Результаты всех групп',
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.white_color,
          ),
        ),
        backgroundColor: AppColors.background_color,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CommonTextField(
                      icon: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                      keyboardType: TextInputType.text,
                      controller: searchController,
                      hintText: 'Поиск',
                      obscureText: false,
                    ),
                  ),
                  Container(
                    height: 55,
                    width: 55,
                    margin: const EdgeInsets.only(left: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: AppColors.light_grey_color,
                        width: 1.0,
                      ),
                      color: AppColors.white_color,
                    ),
                    child: IconButton(
                      icon: const ImageIcon(
                        AssetImage('assets/icons/filter.png'),
                        size: 30,
                        color: AppColors.primary_color,
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: StreamBuilder<List<GroupModel>>(
                  stream: _groupStream,
                  builder: (context, AsyncSnapshot snapshot) {
                    return snapshot.hasData
                        ? ListView.separated(
                            separatorBuilder: (_, __) {
                              return const SizedBox(height: 20);
                            },
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              GroupModel group = snapshot.data![index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ResultsOfStudents(group: group),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 140,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    color: AppColors.white_color,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CommonText(
                                          text: group.group_name,
                                          color: AppColors.black_color,
                                          size: 26,
                                        ),
                                        SizedBox(
                                          width: double.maxFinite,
                                          child: LinearProgressIndicator(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            value: 10 / 74,
                                            backgroundColor: Colors.grey[300],
                                            valueColor:
                                                const AlwaysStoppedAnimation<
                                                    Color>(
                                              Colors.green,
                                            ),
                                            minHeight: 8,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const SizedBox(
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 7,
                                                    backgroundColor:
                                                        AppColors.primary_color,
                                                  ),
                                                  SizedBox(width: 5),
                                                  CommonText(text: '12'),
                                                  SizedBox(width: 10),
                                                  CircleAvatar(
                                                    radius: 7,
                                                    backgroundColor:
                                                        AppColors.yellow_color,
                                                  ),
                                                  SizedBox(width: 5),
                                                  CommonText(text: '6'),
                                                  SizedBox(width: 10),
                                                  CircleAvatar(
                                                    radius: 7,
                                                    backgroundColor:
                                                        AppColors.red_color,
                                                  ),
                                                  SizedBox(width: 5),
                                                  CommonText(text: '5'),
                                                ],
                                              ),
                                            ),
                                            CommonText(
                                              text:
                                                  'Пройдено ? из ${group.students.length}',
                                              color: AppColors.dark_grey_color,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
