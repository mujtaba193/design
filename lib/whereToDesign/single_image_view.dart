import 'package:flutter/material.dart';

class SingleImageView extends StatefulWidget {
  String singleImage;
  SingleImageView({super.key, required this.singleImage});

  @override
  State<SingleImageView> createState() => _SingleImageViewState();
}

class _SingleImageViewState extends State<SingleImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Image.network(
          widget.singleImage,
          fit: BoxFit.cover,
          //alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}
