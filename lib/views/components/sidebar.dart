import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key, required this.onpressed});
  final VoidCallback onpressed;


  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: backgroundClrLight,
        padding: EdgeInsets.symmetric(vertical: 50),
        child: Column(
          spacing: 30,
          children: [
            // SizedBox(
            //   height: 20,
            // ),
            IconButton(
              onPressed: () {}, 
              icon: Icon(Icons.menu, color: Colors.white)
            ),
            IconButton(
              onPressed: () {}, 
              icon: Icon(Icons.history, color: Colors.white)
            ),
            Spacer(),
            IconButton(
              onPressed: widget.onpressed, 
              icon: Icon(Icons.add, color: Colors.white)
            ),

          ],
        ),
      )
    );
  }
}