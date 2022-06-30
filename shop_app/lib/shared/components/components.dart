import 'package:flutter/material.dart';

Widget defaultTextFormFiled({
  required context,
  required IconData prefix,
  required dynamic label,
  TextInputType keyboardType = TextInputType.text,
  TextEditingController? controller,
  String? initialValue,
  IconData? suffix,
  bool isPassword = false,
  bool enabled = true,
  suffixPressed,
  onSubmit,
  onChange,
  onTap,
  validate,
}) {
  return TextFormField(
    onTap: onTap,
    onChanged: onChange,
    onFieldSubmitted: onSubmit,
    controller: controller,
    keyboardType: keyboardType,
    obscureText: isPassword,
    textAlign: TextAlign.start,
    enabled: enabled,
    validator: validate,
    textCapitalization: TextCapitalization.words,
    textAlignVertical: TextAlignVertical.center,
    style: Theme.of(context).textTheme.bodyText1,
    initialValue: initialValue,
    decoration: InputDecoration(
      border: const UnderlineInputBorder(),
      hintText: label,
      prefixIcon: Icon(prefix),
      suffix: IconButton(
        onPressed: suffixPressed,
        icon: Icon(suffix),
      ),
    ),
  );
}

Widget defaultButton({
  required String text,
  required VoidCallback ontap,
  double? width = double.infinity,
}) {
  return Container(
    height: 40,
    width: width,
    decoration: const BoxDecoration(
      color: Colors.red,
    ),
    child: ElevatedButton(
      onPressed: ontap,
      child: Text(
        '$text',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
      ),
    ),
  );
}

enum ToastStates { SUCCESS, ERROR, WARNING }
Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

// void showToast({
//   required String message,
//   required ToastStates state,
// }) {
//   Fluttertoast.showToast(
//     msg: message,
//     toastLength: Toast.LENGTH_LONG,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 5,
//     backgroundColor: chooseToastColor(state),
//     textColor: white,
//     fontSize: 16,
//   );
// }
