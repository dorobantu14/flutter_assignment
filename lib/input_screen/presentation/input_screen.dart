import 'package:flutter/material.dart';
import 'package:flutter_assignment1/core/colors/app_colors.dart';
import 'package:flutter_assignment1/core/strings/strings.dart';
import 'package:flutter_assignment1/core/text_styles/text_styles.dart';
import 'package:flutter_assignment1/core/widgets/app_button.dart';
import 'package:flutter_assignment1/core/widgets/input_text_field.dart';
import 'package:flutter_assignment1/main_screen/domain/bloc/persons_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class InputScreen extends StatefulWidget {
  final String personName;

  const InputScreen({
    super.key,
    required this.personName,
  });

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  var locationController = TextEditingController();
  List<String> lastTripsLocation = [];

  @override
  void initState() {
    super.initState();
    locationController.addListener(refreshCallback);
    final state = context.read<PersonsBloc>().state;
    final personIndex = state.persons.indexWhere(
      (person) => person.name == widget.personName,
    );
    if (state.persons[personIndex].lastTripsLocations != null) {
      lastTripsLocation = state.persons[personIndex].lastTripsLocations!;
    }
  }

  void refreshCallback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonsBloc, PersonsState>(
      listener: (context, state) {
        final personIndex = state.persons.indexWhere(
          (person) => person.name == widget.personName,
        );
        if (state.status == PersonsStatus.success) {
          context.go(
            Strings.secondScreenPath,
            extra: state.persons[personIndex].lastTripsLocations,
          );
        }
      },
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
          context.read<PersonsBloc>().add(
                PersonsEvent.addPersonInput(
                  personName: widget.personName,
                  input: lastTripsLocation,
                ),
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
