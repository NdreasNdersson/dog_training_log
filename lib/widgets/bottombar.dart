import 'package:flutter/material.dart';


class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset.zero
              )
            ]
        ),
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipOval(
              child: Material(
                  child: IconButton(
                    icon: const Icon(Icons.home),
                    onPressed: () {},
                  )
              ),
            ),
            ClipOval(
              child: Material(
                  child: IconButton(
                    icon: const Icon(Icons.list),
                    onPressed: () {},
                  )
              ),
            ),
            ClipOval(
              child: Material(
                  child: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () {},
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}