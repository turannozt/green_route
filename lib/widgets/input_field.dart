import 'package:flutter/material.dart';

import '../provider/theme_provider.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final TextInputType type;
  const MyInputField({
    super.key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStil.titleStyle,
          ),
          Container(
            height: 52,
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    controller: controller,

                    style: TextStil.normalText,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStil.subtitleStyle,
                      border: InputBorder.none, // Remove the border
                      focusedBorder: InputBorder.none, // Remove the underline
                      enabledBorder: InputBorder.none, // Remove the underline
                    ),
                    keyboardType: type, // Sayı girişi için
                  ),
                ),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
