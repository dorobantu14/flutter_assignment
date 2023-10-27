import 'package:flutter/material.dart';
import 'package:flutter_assignment1/core/colors/app_colors.dart';
import 'package:flutter_assignment1/core/strings/strings.dart';
import 'package:flutter_assignment1/input_screen/presentation/input_screen.dart';
import 'package:flutter_assignment1/main_screen/domain/bloc/persons_bloc.dart';
import 'package:flutter_assignment1/main_screen/presentation/persons_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var currentPageIndex = 0;
  var personIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PersonsBloc>(create: (_) => PersonsBloc()),
      ],
      child: BlocBuilder<PersonsBloc, PersonsState>(
        builder: (context, state) {
          final List<Widget> tabs = [
            PersonsList(
              onTap: onPersonTapped,
            ),
            if (state.persons.isNotEmpty)
              InputScreen(
                personName: state.persons[personIndex].name,
              ),
          ];
          return Scaffold(
            appBar: getAppBar(context),
            bottomNavigationBar: NavigationBar(
              onDestinationSelected: (index) {
                if (index == 0) {
                  setState(() {
                    currentPageIndex = 0;
                  });
                }
              },
              indicatorColor: AppColors.blue,
              selectedIndex: currentPageIndex,
              destinations: getTabs(),
            ),
            body: tabs[currentPageIndex],
          );
        },
      ),
    );
  }

  List<Widget> getTabs() {
    return const <Widget>[
      NavigationDestination(
        icon: Icon(Icons.person),
        label: Strings.personsText,
      ),
      NavigationDestination(
        icon: Icon(Icons.message),
        label: Strings.inputText,
      ),
    ];
  }

  AppBar getAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      actions: [getLogoutButton(context)],
    );
  }

  void onPersonTapped(int index) {
    setState(() {
      currentPageIndex = 1;
      personIndex = index;
    });
  }

  Widget getLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        child: const Icon(
          Icons.logout,
          color: AppColors.blue,
          size: 32,
        ),
        onTap: () async {
          await SharedPreferences.getInstance().then(
            (value) {
              value.setBool(Strings.isLoggedInText, false);
              context.go(Strings.loginPath);
            },
          );
        },
      ),
    );
  }
}
