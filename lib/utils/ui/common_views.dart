import 'package:flutter/material.dart';

class CommonViews {
  static final CommonViews _shared = CommonViews._private();

  factory CommonViews() => _shared;

  CommonViews._private();

  Widget commonButton(
      {required VoidCallback onPressed,
      required double height,
      required String title}) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(31),
      ),
      height: height,
      color: Colors.green,
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  Widget createTextFormField(
      {required TextEditingController controller,
      required FocusNode focusNode,
      required String label,
      required TextInputType keyboardType,
      TextInputAction? inputAction,
      ValueChanged<String>? onSubmitted,
      required Widget suffixIcon,
      String? errorText,
      FormFieldValidator<String>? validator,
      bool isObscure = false}) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: inputAction ?? TextInputAction.next,
      obscureText: isObscure,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onFieldSubmitted: onSubmitted,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: label,
        errorText: errorText,
        errorStyle: const TextStyle(height: 0.3,),
        labelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: _getBorder(Colors.black),
        focusedErrorBorder: _getBorder(Colors.red),
        border: _getBorder(Colors.black),
        focusedBorder: _getBorder(Colors.green),
        errorBorder: _getBorder(Colors.red),
      ),
    );
  }

  OutlineInputBorder _getBorder(Color borderColor) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: BorderSide(color: borderColor));
  }

  bool validPassword(String value) {
    String pattern =
        r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,}$";
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);
  }
}
