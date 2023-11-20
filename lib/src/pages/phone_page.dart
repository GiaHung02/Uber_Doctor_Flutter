import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Phone extends StatefulWidget {
  const Phone({super.key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  bool appNotifications = true;
  DateTime beginDate = DateTime.now();
  DateTime endDate = DateTime.now();

  void toggleAppNotifications(bool value) {
    setState(() {
      appNotifications = value;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: beginDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null && picked != beginDate) {
      setState(() {
        beginDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          value: appNotifications,
          onChanged: toggleAppNotifications,
          title: Text('App Notifications'),
        ),
        ListTile(
          title: Text('Begin date: ${'${beginDate.toLocal()}'.split(' ')[0]}'),
          trailing: ElevatedButton(
            onPressed: () => _selectDate(context),
            child: const Text('Change date'),
          ),
        ),
        ListTile(title: Text('End date: ${'${beginDate.toLocal()}'.split(' ')[0]}')),
        SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: endDate,
            onDateTimeChanged: (DateTime picked) {
              setState(() {
                endDate = picked;
              });
            },
          ),
        )
      ],
    );
  }
}
