import 'package:flutter/material.dart';

class Extra extends StatefulWidget {
  static const String routeName = "extra";
  final String imageUrl = 'http://localhost:5000/api/uploads/1712854725639.jpg';

  @override
  _ExtraState createState() => _ExtraState();
}

class _ExtraState extends State<Extra> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
          widget.imageUrl,
          width: 200,
          height: 600,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return Text('Failed to load image');
          },
        ),
      ),
    );
  }
}
