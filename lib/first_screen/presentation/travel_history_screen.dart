import 'package:flutter/material.dart';
import 'package:flutter_assignment1/core/colors/app_colors.dart';
import 'package:flutter_assignment1/core/strings/strings.dart';
import 'package:flutter_assignment1/core/text_styles/text_styles.dart';
import 'package:flutter_assignment1/core/widgets/app_button.dart';
import 'package:flutter_assignment1/core/widgets/input_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LastTripsLocations extends StatefulWidget {
  const LastTripsLocations({super.key});

  @override
  State<LastTripsLocations> createState() => _LastTripsLocationsState();
}

class _LastTripsLocationsState extends State<LastTripsLocations> {
  var locationController = TextEditingController();
  List<String> lastTripsLocation = [];

  @override
  void initState() {
    super.initState();
    locationController.addListener(refreshCallback);
  }

  void refreshCallback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        actions: [getLogoutButton(context)],
      ),
      body: SafeArea(
        bottom: false,
        minimum: const EdgeInsets.only(top: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                getTitle(),
                getDescription(),
                getLocationField(),
                getAddedLocations(),
                getContinueButton(),
              ],
            ),
          ),
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

  Widget getLocationField() {
    return AppTextField(
      controller: locationController,
      hintText: Strings.locationText,
      prefixIcon: const Icon(Icons.location_on_outlined),
      onEditCompleted: () {
        setState(() {
          lastTripsLocation.add(locationController.text);
          locationController.clear();
        });
      },
    );
  }

  Widget getContinueButton() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1, bottom: 24),
      child: AppButton(
        buttonEnabled: lastTripsLocation.isNotEmpty,
        color: AppColors.blue,
        text: Strings.continueText,
        onPressed: () {
          context.go(
            Strings.secondScreenPath,
            extra: lastTripsLocation,
          );
        },
      ),
    );
  }

  Widget getAddedLocations() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Wrap(
        spacing: 12,
        alignment: WrapAlignment.center,
        children: lastTripsLocation
            .map(
              (locationName) => buildLocationChip(locationName),
            )
            .toList(),
      ),
    );
  }

  Widget buildLocationChip(locationName) {
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
      onDeleted: () {
        setState(() {
          lastTripsLocation.remove(locationName);
        });
      },
    );
  }

  Widget getDescription() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Text(
        Strings.shareLocationsText,
        style: TextStyles.boldGreyTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget getTitle() {
    return const Padding(
      padding: EdgeInsets.only(top: 48),
      child: Text(
        Strings.travelHistoryText,
        style: TextStyles.boldSubtitleTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
