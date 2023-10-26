import 'package:flutter/material.dart';
import 'package:flutter_assignment1/core/strings/strings.dart';
import 'package:go_router/go_router.dart';

class DisplayLocationsScreen extends StatelessWidget {
  final List<String> locations;

  const DisplayLocationsScreen({
    super.key,
    required this.locations,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getBackButton(context),
                Expanded(child: getTitle()),
              ],
            ),
            getAddedLocations(context),
          ],
        ),
      ),
    );
  }

  Widget getBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: GestureDetector(
        child: const Icon(
          Icons.arrow_back_outlined,
          size: 32,
        ),
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
      disabledColor: Colors.white,
    );
  }

  Widget getTitle() {
    return const Text(
      Strings.lastTripsText,
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.center,
    );
  }
}
