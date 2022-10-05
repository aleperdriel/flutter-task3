import 'package:flutter/material.dart';

class NewTile extends StatelessWidget {
  const NewTile(
      {super.key,
      required this.text,
      required this.onTap,
      required this.type,
      this.controller});

  final String text;
  final Function onTap;
  final TextEditingController? controller;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: SizedBox(
          width: double.maxFinite,
          child: TextButton(
            onPressed: () {
              onTap(text);
            },
            child: Text(text,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                )),
          ),
        ),
      ),
    );
  }
}