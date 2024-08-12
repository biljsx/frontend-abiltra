import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_todoapp/widgets/common_text_field.dart';
import 'package:flutter_todoapp/providers/providers.dart';
import 'package:flutter_todoapp/utils/helpers.dart';

class SelectDateTime extends ConsumerWidget {
  final FormFieldSetter<DateTime>? onDateSaved;
  final FormFieldSetter<TimeOfDay>? onTimeSaved;
  final FormFieldValidator<DateTime>? dateValidator;
  final FormFieldValidator<TimeOfDay>? timeValidator;

  const SelectDateTime({
    Key? key,
    this.onDateSaved,
    this.onTimeSaved,
    this.dateValidator,
    this.timeValidator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Row(
      children: [
        Expanded(
          child: FormField<DateTime>(
            onSaved: onDateSaved,
            validator: dateValidator,
            builder: (FormFieldState<DateTime> state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextField(
                    title: 'Date',
                    hintText: state.value != null ? DateFormat.yMMMd().format(state.value!) : 'Select Date',
                    readOnly: true,
                    suffixIcon: IconButton(
                      onPressed: () => _selectDate(context, ref, state),
                      icon: const FaIcon(FontAwesomeIcons.calendar),
                    ),
                  ),
                  if (state.hasError)
                    Text(
                      state.errorText!,
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              );
            },
          ),
        ),
        const Gap(10),
        Expanded(
          child: FormField<TimeOfDay>(
            onSaved: onTimeSaved,
            validator: timeValidator,
            builder: (FormFieldState<TimeOfDay> state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextField(
                    title: 'Time',
                    hintText: state.value != null ? Helpers.timeToString(state.value!) : 'Select Time',
                    readOnly: true,
                    suffixIcon: IconButton(
                      onPressed: () => _selectTime(context, ref, state),
                      icon: const FaIcon(FontAwesomeIcons.clock),
                    ),
                  ),
                  if (state.hasError)
                    Text(
                      state.errorText!,
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  void _selectTime(BuildContext context, WidgetRef ref, FormFieldState<TimeOfDay> state) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      ref.read(timeProvider.notifier).state = pickedTime;
      state.didChange(pickedTime);
    }
  }

  void _selectDate(BuildContext context, WidgetRef ref, FormFieldState<DateTime> state) async {
    final initialDate = ref.read(dateProvider);

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      ref.read(dateProvider.notifier).state = pickedDate;
      state.didChange(pickedDate);
    }
  }
}
