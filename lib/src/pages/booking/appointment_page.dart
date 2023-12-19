import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uber_doctor_flutter/src/model/AuthProvider.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

enum FilterStatus { pending, upcoming, complete, cancel }

class _AppointmentPageState extends State<AppointmentPage> {
  FilterStatus status = FilterStatus.upcoming;
  Alignment _alignment = Alignment.centerLeft;
  List<dynamic> schedules = [
    {
      "doctor_name": "Minh Hoang",
      "doctor_profile": "assets/images/harry.jpg",
      "categoty": "Khoa Tim",
      "status": FilterStatus.upcoming
    },
    {
      "doctor_name": "Thien Kim",
      "doctor_profile": "assets/images/hitler.jpg",
      "categoty": "Khoa Tim",
      "status": FilterStatus.complete
    },
    {
      "doctor_name": "Minh Hoang",
      "doctor_profile": "assets/images/nazi.jpg",
      "categoty": "Răng",
      "status": FilterStatus.complete
    },
    {
      "doctor_name": "Minh Hoang",
      "doctor_profile": "assets/images/santa.jpg",
      "categoty": "Khoa Mat",
      "status": FilterStatus.cancel
    }
  ];
  @override
  Widget build(BuildContext context) {
    List<dynamic> filterSchedules = schedules.where((var schedule) {
      switch (schedule['status']) {
        case 'pending':
          schedule['status'] = FilterStatus.upcoming;
          break;
        case 'complete':
          schedule['status'] = FilterStatus.complete;
          break;
        case 'cancel':
          schedule['status'] = FilterStatus.cancel;
          break;
      }
      return schedule['status'] == status;
    }).toList();
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Appointment Schedule',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // this is  the filter tabs
                        for (FilterStatus filterStatus in FilterStatus.values)
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (filterStatus == FilterStatus.upcoming) {
                                  status = FilterStatus.upcoming;
                                  _alignment = Alignment.centerLeft;
                                } else if (filterStatus ==
                                    FilterStatus.complete) {
                                  status = FilterStatus.complete;
                                  _alignment = Alignment.center;
                                } else if (filterStatus ==
                                    FilterStatus.cancel) {
                                  status = FilterStatus.cancel;
                                  _alignment = Alignment.centerRight;
                                }
                              });
                            },
                            child: Center(child: Text(filterStatus.name)),
                          ))
                      ]),
                ),
                AnimatedAlign(
                  alignment: _alignment,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                        child: Text(
                      status.name,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: filterSchedules.length,
                    itemBuilder: ((context, index) {
                      var _schedule = filterSchedules[index];
                      bool isLastElement = filterSchedules.length + 1 == index;
                      return Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: !isLastElement
                              ? const EdgeInsets.only(bottom: 20)
                              : EdgeInsets.zero,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: AssetImage(
                                          _schedule['doctor_profile']),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _schedule['doctor_name'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(_schedule['categoty'],
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                ScheduleCard(),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: OutlinedButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 1, 78, 141)),
                                      ),
                                    )),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                        child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          backgroundColor:
                                              Color.fromARGB(255, 1, 78, 141)),
                                      onPressed: () {
                                        Provider.of<MyAuthProvider>(context,
                                                listen: false)
                                            .logout();
                                      },
                                      child: Text(
                                        'Reschedule',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ))
                                  ],
                                )
                              ],
                            ),
                          ));
                    }))),
          ]),
    ));
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const <Widget>[
          Icon(
            Icons.calendar_today,
            color: Color.fromARGB(255, 1, 78, 141),
            size: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'Monday, 28/12/2023',
            style: TextStyle(color: Color.fromARGB(255, 1, 78, 141)),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.access_alarm,
            color: Color.fromARGB(255, 41, 133, 209),
            size: 17,
          ),
          // SizedBox(
          //   width: 2,
          // ),
          Flexible(
              child: Text(
            '02:00 PM',
            style: TextStyle(
              color: Color.fromARGB(255, 1, 78, 141),
            ),
          ))
        ],
      ),
    );
  }
}
