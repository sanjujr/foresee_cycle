import 'package:flutter/material.dart';
import 'package:foresee_cycles/pages/home/appbar.dart';

Container chatWidget(BuildContext context) {
  return Container(
    child: Column(
      children: [
        customAppBar(context, "Chat"),
      ],
    ),
  );
}