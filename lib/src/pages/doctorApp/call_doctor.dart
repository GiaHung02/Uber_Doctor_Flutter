// Flutter imports:
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:faker/faker.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:uber_doctor_flutter/constants.dart';
import 'package:uber_doctor_flutter/login_service.dart';
import 'package:uber_doctor_flutter/src/api/api_service.dart';
import 'package:uber_doctor_flutter/src/model/booking.dart';
import 'package:uber_doctor_flutter/src/pages/booking/appointment_page.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:http/http.dart' as http;

class CallPageDoctor extends StatefulWidget {
  const CallPageDoctor({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CallPageState();
}

class CallPageState extends State<CallPageDoctor> {
  final TextEditingController singleInviteeUserIDTextCtrl =
      TextEditingController();
  final TextEditingController groupInviteeUserIDsTextCtrl =
      TextEditingController();
  List<Booking> _schedules = [];

  

  @override
  void initState() {
    super.initState();
    // Gọi hàm để lấy dữ liệu từ API và cập nhật danh sách bookings
    fetchBookings();
  }

  FilterStatus statusBooking = FilterStatus.upcoming;
  Alignment _alignment = Alignment.centerLeft;

  void fetchBookings() async {
    final url = Uri.parse('$domain/api/v1/booking/list');

    try {
      final response = await http.get(url);
      // print(response.body);
      if (response.statusCode == 200) {
        // Chuyển đổi JSON thành danh sách Booking và cập nhật state
        setState(() {
          _schedules = List<Booking>.from(jsonDecode(response.body)['data']
              .map((booking) => Booking.fromJson(booking)));
        });
      } else {
        // Xử lý khi có lỗi từ API
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Xử lý khi có lỗi kết nối
      print('Error: $e');
    }
    //  print('schedule: $schedules');
    print('booking length from api: ${_schedules.length}');
  }

  void reloadBookings() async {
    fetchBookings();
    setState(() {
      // Update state để rebuild trang
    });
  }

  @override
  Widget build(BuildContext context) {
    // List<dynamic> filterSchedules = _schedules.where((var schedule) {
    //   FilterStatus scheduleStatus;
    //   switch (schedule.statusBooking) {
    //     case 'upcoming':
    //       scheduleStatus = FilterStatus.upcoming;
    //       break;
    //     case 'complete':
    //       scheduleStatus = FilterStatus.complete;
    //       break;
    //     case 'cancel':
    //       scheduleStatus = FilterStatus.cancel;
    //       break;
    //     default:
    //       scheduleStatus = FilterStatus
    //           .upcoming; // Xác định trạng thái mặc định nếu không khớp
    //   }
    //   return scheduleStatus == statusBooking;
    // }).toList();

    // print('fillerschedule: ${filterSchedules.length}');
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Stack(
            children: [
              Positioned(
                top: 20,
                right: 10,
                child: logoutButton(),
              ),
              Positioned(
                top: 50,
                left: 10,
                child: Text('Your Phone Number: ${currentUser.id}'),
              ),
              userListView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget logoutButton() {
    return Ink(
      width: 35,
      height: 35,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.redAccent,
      ),
      child: IconButton(
        icon: const Icon(Icons.exit_to_app_sharp),
        iconSize: 20,
        color: Colors.white,
        onPressed: () {
          logout().then((value) {
            onUserLogout();

            Navigator.pushNamed(
              context,
              PageRouteNames.login,
            );
          });
        },
      ),
    );
  }

  Widget userListView() {
    final RandomGenerator random = RandomGenerator();
    final Faker faker = Faker();

    // final TextEditingController singleInviteeUserIDTextCtrl =
    //     TextEditingController(text: '123456');

    
    return Center(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _schedules.length,
        itemBuilder: (context, index) {
          final booking = _schedules[index];
          final doctorFullName = booking.doctors?.fullName ?? 'Unknown Doctor';
          final patientsName = booking.patients?.fullName?? 'Unknown Patients';
            // print('>>>>>>>>>>>>>>>>>>>>>''_schedule id: ${_schedule.doc}');
          // Booking(booking: bookings[index]);
          // print('>>>>>>>>>>>>>>>>>>>>>''_schedule id: ${_schedule.id}');
          // print('>>>>>>>>>>>>>>>>>>>>>''Doctor full name: ${_schedule.doctors!.fullName}');

          late TextEditingController inviteeUsersIDTextCtrl;
          late List<Widget> userInfo;
          // late List<Widget> booking;
          if (0 == index) {
            inviteeUsersIDTextCtrl = singleInviteeUserIDTextCtrl;
            userInfo = [
              const Text('invitee name ('),
              inviteeIDFormField(
                textCtrl: inviteeUsersIDTextCtrl,
                formatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9,]')),
                ],
                labelText: "invitee ID",
                hintText: "plz enter invitee ID",
              ),
              const Text(')'),
            ];
          } else if (1 == index) {
            inviteeUsersIDTextCtrl = groupInviteeUserIDsTextCtrl;
            userInfo = [
              const Text('group name ('),
              inviteeIDFormField(
                textCtrl: inviteeUsersIDTextCtrl,
                formatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9,]')),
                ],
                labelText: "invitees ID",
                hintText: "separate IDs by ','",
              ),
              const Text(')'),
            ];
          } else {
            inviteeUsersIDTextCtrl = TextEditingController();

            userInfo = [
              // Text(
              //   '${faker.person.firstName()}(${random.fromPattern([
              //         '######'
              //       ])})',
              //   style: textStyle,
              // )

              Text(
                '${booking.patients!.fullName}(${random.fromPattern([
                      '######'
                      
                    ])})',
                style: textStyle,
                
              )
              
            ];
          }

          return Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 20),
                  ...userInfo,
                  Expanded(child: Container()),
                  sendCallButton(
                    isVideoCall: false,
                    inviteeUsersIDTextCtrl: inviteeUsersIDTextCtrl,
                    onCallFinished: onSendCallInvitationFinished,
                  ),
                  sendCallButton(
                    isVideoCall: true,
                    inviteeUsersIDTextCtrl: inviteeUsersIDTextCtrl,
                    onCallFinished: onSendCallInvitationFinished,
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Divider(height: 1.0, color: Colors.grey),
              ),
            ],
          );
        },
      ),
    );
  }

  void onSendCallInvitationFinished(
    String code,
    String message,
    List<String> errorInvitees,
  ) {
    if (errorInvitees.isNotEmpty) {
      String userIDs = "";
      for (int index = 0; index < errorInvitees.length; index++) {
        if (index >= 5) {
          userIDs += '... ';
          break;
        }

        var userID = errorInvitees.elementAt(index);
        userIDs += userID + ' ';
      }
      if (userIDs.isNotEmpty) {
        userIDs = userIDs.substring(0, userIDs.length - 1);
      }

      var message = 'User doesn\'t exist or is offline: $userIDs';
      if (code.isNotEmpty) {
        message += ', code: $code, message:$message';
      }
      showToast(
        message,
        position: StyledToastPosition.top,
        context: context,
      );
    } else if (code.isNotEmpty) {
      showToast(
        'code: $code, message:$message',
        position: StyledToastPosition.top,
        context: context,
      );
    }
  }
}

Widget inviteeIDFormField({
  required TextEditingController textCtrl,
  List<TextInputFormatter>? formatters,
  String hintText = '',
  String labelText = '',
}) {
  const textStyle = TextStyle(fontSize: 12.0);
  return Expanded(
    flex: 100,
    child: SizedBox(
      height: 30,
      child: TextFormField(
        style: textStyle,
        controller: textCtrl,
        inputFormatters: formatters,
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          hintStyle: textStyle,
          labelText: labelText,
          labelStyle: textStyle,
          border: const OutlineInputBorder(),
        ),
      ),
    ),
  );
}

Widget sendCallButton({
  required bool isVideoCall,
  required TextEditingController inviteeUsersIDTextCtrl,
  void Function(String code, String message, List<String>)? onCallFinished,
}) {
  return ValueListenableBuilder<TextEditingValue>(
    valueListenable: inviteeUsersIDTextCtrl,
    builder: (context, inviteeUserID, _) {
      var invitees = getInvitesFromTextCtrl(inviteeUsersIDTextCtrl.text.trim());

      return ZegoSendCallInvitationButton(
        isVideoCall: isVideoCall,
        invitees: invitees,
        resourceID: "zego_data",
        iconSize: const Size(40, 40),
        buttonSize: const Size(50, 50),
        onPressed: onCallFinished,
      );
    },
  );
}

List<ZegoUIKitUser> getInvitesFromTextCtrl(String textCtrlText) {
  List<ZegoUIKitUser> invitees = [];

  var inviteeIDs = textCtrlText.trim().replaceAll('，', '');
  inviteeIDs.split(",").forEach((inviteeUserID) {
    if (inviteeUserID.isEmpty) {
      return;
    }

    invitees.add(ZegoUIKitUser(
      id: inviteeUserID,
      name: 'user_$inviteeUserID',
    ));
  });

  return invitees;
}
