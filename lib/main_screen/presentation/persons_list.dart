import 'package:flutter/material.dart';
import 'package:flutter_assignment1/core/colors/app_colors.dart';
import 'package:flutter_assignment1/core/strings/strings.dart';
import 'package:flutter_assignment1/core/text_styles/text_styles.dart';
import 'package:flutter_assignment1/main_screen/domain/bloc/persons_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonsList extends StatefulWidget {
  final void Function(int) onTap;

  const PersonsList({
    super.key,
    required this.onTap,
  });

  @override
  State<PersonsList> createState() => _PersonsListState();
}

class _PersonsListState extends State<PersonsList> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<PersonsBloc>();

    if (bloc.state.persons.isEmpty) {
      bloc.add(const PersonsEvent.getPersons());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonsBloc, PersonsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              getTitle(),
              getSubtitle(),
              getPersonsList(state),
            ],
          ),
        );
      },
    );
  }

  Widget getPersonsList(PersonsState state) {
    return Expanded(
      child: ListView.builder(
        itemCount: state.persons.length,
        itemBuilder: (context, index) => buildPersonItem(index, state),
      ),
    );
  }

  Widget buildPersonItem(int index, PersonsState state) {
    return GestureDetector(
      onTap: () {
        widget.onTap(index);
      },
      child: Row(
        children: [
          getPersonIcon(),
          getPersonName(state, index),
        ],
      ),
    );
  }

  Widget getPersonName(PersonsState state, int index) {
    return Text(
      state.persons[index].name,
      style: TextStyles.blackButtonTextStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget getPersonIcon() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Icon(
        Icons.account_circle_outlined,
        color: AppColors.blue,
        size: 32,
      ),
    );
  }

  Widget getTitle() {
    return const Text(
      Strings.availablePersonsText,
      style: TextStyles.boldSubtitleTextStyle,
    );
  }

  Widget getSubtitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        Strings.pleaseTapPersonText,
        style: TextStyles.boldGreyTextStyle.copyWith(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }
}
