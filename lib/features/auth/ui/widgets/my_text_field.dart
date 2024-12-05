import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final GlobalKey<FormState> fieldKey;
  IconData preIcon;
  String? Function(String) validator;
  String hintText;
  bool isPassword;
  TextEditingController controller;

  MyTextField(
      {super.key,
      required this.preIcon,
      required this.validator,
      required this.hintText,
      required this.isPassword,
      required this.fieldKey,
      required this.controller});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  final String emptyFieldMessage = "This field can't be empty...!";

  late bool isHidden;
  @override
  void initState() {
    super.initState();
    isHidden = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      margin: EdgeInsets.all(14),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xff282A28),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 8),
            child: Icon(
              widget.preIcon,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Form(
              key: widget.fieldKey,
              child: TextFormField(
                controller: widget.controller,
                style: TextStyle(color: Colors.white),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldMessage;
                  }
                  return widget.validator  (value);
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(color: Colors.white),
                    suffix: widget.isPassword
                        ? InkWell(
                            onTap: () {
                              isHidden = !isHidden;
                              setState(() {});
                            },
                            child: Icon(
                              isHidden
                                  ? (Icons.visibility_off)
                                  : (Icons.visibility),
                              color: Colors.white,
                            ),
                          )
                        : Text("")),
                obscureText: isHidden,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
