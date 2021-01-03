import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class UpdateValueButton extends StatelessWidget {
  final IconData icon;
  final Function perform;

  UpdateValueButton({this.icon, this.perform});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: perform,
      child: Container(
        height: 30,
        width: 40,
        margin: icon == Icons.remove
            ? EdgeInsets.only(right: 10)
            : EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1.0, color: Colors.green),
        ),
        child: Center(
          child: Icon(icon, color: Colors.amber),
        ),
      ),
    );
  }
}
