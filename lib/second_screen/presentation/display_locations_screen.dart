import 'package:flutter/material.dart';
import 'package:flutter_assignment1/core/colors/app_colors.dart';
import 'package:flutter_assignment1/core/strings/strings.dart';
import 'package:flutter_assignment1/core/text_styles/text_styles.dart';
import 'package:flutter_assignment1/core/widgets/back_button.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayLocationsScreen extends StatelessWidget {
  final List<String> locations;

  const DisplayLocationsScreen({
    super.key,
    required this.locations,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: getBackButton(context),
        backgroundColor: AppColors.white,
        elevation: 0,
        actions: [getLogoutButton(context)],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                getTitle(),
                getAddedLocations(context),
              ],
            ),
          ],
        ),
      ),
    );
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
            (value) => value.setBool('isLoggedIn', false),
          );
          context.go('/login');
        },
      ),
    );
  }

  Widget getBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: AppBackButton(
        onTap: () {
          context.pop();
        },
      ),
    );
  }

  Widget getAddedLocations(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Wrap(
        spacing: 12,
        alignment: WrapAlignment.center,
        children: locations
            .map(
              (locationName) => buildLocationChip(locationName, context),
            )
            .toList(),
      ),
    );
  }

  Widget buildLocationChip(String locationName, BuildContext context) {
    return InputChip(
      label: Text(
        locationName,
        style: TextStyles.blackButtonTextStyle,
      ),
      avatar: const Icon(Icons.location_on_outlined),
      backgroundColor: Colors.white,
      side: BorderSide(color: Theme.of(context).colorScheme.primary),
      shadowColor: Colors.black,
      elevation: 3,
      disabledColor: Colors.white,
    );
  }

  Widget getTitle() {
    return const Text(
      Strings.lastTripsText,
      style: TextStyles.boldSubtitleTextStyle,
      textAlign: TextAlign.center,
    );
  }
}
