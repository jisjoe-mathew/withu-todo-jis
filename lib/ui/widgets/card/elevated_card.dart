import 'package:flutter/material.dart';

class ElevatedCard extends StatelessWidget {
  const ElevatedCard({Key key, @required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(2.0, 4.0),
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 3.0),
          ]),
      child: child,
    );
  }
}
