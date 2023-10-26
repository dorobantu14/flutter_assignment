import 'package:flutter/material.dart';
import 'package:flutter_assignment1/core/strings/strings.dart';
import 'package:flutter_assignment1/core/widgets/app_button.dart';
import 'package:flutter_assignment1/core/widgets/input_text_field.dart';

class LastTripsLocations extends StatefulWidget {
  const LastTripsLocations({super.key});

  @override
  State<LastTripsLocations> createState() => _LastTripsLocationsState();
}

class _LastTripsLocationsState extends State<LastTripsLocations> {
  var locationController = TextEditingController();
  var lastTripsLocation = [];

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
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              getTitle(),
              getDescription(),
              AppTextField(
                controller: locationController,
                hintText: Strings.locationText,
                prefixIcon: const Icon(Icons.location_on_outlined),
                onEditCompleted: () {
                  setState(() {
                    lastTripsLocation.add(locationController.text);
                    locationController.clear();
                  });
                },
              ),
              getAddedLocations(),
              const Spacer(),
              AppButton(
                buttonEnabled: lastTripsLocation.isNotEmpty,
                color: Colors.lightBlue.withOpacity(0.3),
                text: 'Continue',
              ),
              const Spacer()
            ],
          ),
        ),
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
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
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
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget getTitle() {
    return const Padding(
      padding: EdgeInsets.only(top: 48),
      child: Text(
        Strings.travelHistoryText,
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
