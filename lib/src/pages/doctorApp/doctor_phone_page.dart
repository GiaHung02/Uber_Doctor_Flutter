// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uber_doctor_flutter/constants.dart';
import 'package:uber_doctor_flutter/login_service.dart';
// import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

// Project imports:


void mainInit() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final cacheUserID = prefs.get(cacheUserIDKey) as String? ?? '';
  
  if (cacheUserID.isNotEmpty) {
    currentUser.id = cacheUserID;

    currentUser.name = 'user_$cacheUserID';
  }

  /// 1/5: define a navigator key
  final navigatorKey = GlobalKey<NavigatorState>();

  /// 2/5: set navigator key to ZegoUIKitPrebuiltCallInvitationService
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );

    runApp(Call(navigatorKey: navigatorKey));
  });
}

class Call extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const Call({
    required this.navigatorKey,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CallState();
}

class CallState extends State<Call> {
  @override
  void initState() {
    super.initState();

    if (currentUser.id.isNotEmpty) {
      onUserLogin();
    }

    mainInit();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      initialRoute:
          currentUser.id.isEmpty ? PageRouteNames.login : PageRouteNames.home,
      color: Colors.red,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFEFEFEF)),

      /// 3/5: register the navigator key to MaterialApp
      navigatorKey: widget.navigatorKey,
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: [
            child!,

            /// support minimizing
            ZegoUIKitPrebuiltCallMiniOverlayPage(
              contextQuery: () {
                return widget.navigatorKey.currentState!.context;
              },
            ),
          ],
        );
      },
    );
  }
}
