import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

Color? defaultColor = Colors.orange[700];
const Color white = Colors.white;

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (Route<dynamic> route) => false,
  );
}

void pop(context) {
  Navigator.pop(context);
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

// Widget myDivider() => Container(
//       color: Colors.grey[300],
//       height: 1,
//       width: double.infinity,
//     );

class MyDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      height: 1,
      width: double.infinity,
    );
  }
}

String? token;

void signOut(context) {
  CacheHelper.removeData(token).then(
    (value) {
      if (value) navigateAndFinish(context, LoginScreen());
    },
  );
}

Future<void> internetConection(context) async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('good');
      // showTopSnackBar(
      //   context,
      //   CustomSnackBar.success(
      //     backgroundColor: Colors.green,
      //     message: 'Good Internt',
      //     icon: Icon(null),
      //   ),
      // );
    }
  } on SocketException catch (_) {
    showTopSnackBar(
      context,
      CustomSnackBar.success(
        backgroundColor: Colors.red,
        message: 'Please Check Your Internet',
        icon: Icon(null),
      ),
    );
  }
}

//  Future<bool> isOnline = hasNetwork();
//  Future<bool> hasNetwork() async {
//   try {
//     final result = await InternetAddress.lookup('example.com');
//     return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
//   } on SocketException catch (_) {
//     return false;
//   }
// }
