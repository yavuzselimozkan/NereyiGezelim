import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final void Function(int)? onTapFunc;
  const MyBottomNavigationBar({super.key,this.onTapFunc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20,left: 20,right: 20),
      decoration: BoxDecoration(
          color: const Color(0xFF17203A).withOpacity(0.8),
          borderRadius: const BorderRadius.all(Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF17203A).withOpacity(0.3),
            offset: const Offset(0,20),
            blurRadius: 15
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: GNav(
          padding: const EdgeInsets.all(16),
          activeColor: Colors.blueAccent.shade100,
          tabBackgroundColor: Colors.white24,
          gap: 8,
          tabs: const [
            GButton(icon: Iconsax.home,text: "Ana Sayfa",),
            GButton(icon: Iconsax.map,text: "Rotasyon",),
            GButton(icon: Iconsax.message_question,text: "Belli Değil",),
          ],
          onTabChange: (value) => onTapFunc!(value),
        ),
      ),
    );

    /*CurvedNavigationBar(
      height: screenHeight * 0.075,
      backgroundColor: Colors.transparent,
      color: CupertinoColors.activeBlue.elevatedColor,
      animationDuration: const Duration(milliseconds: 300),
      items:const [
        Icon(Icons.home,color: Colors.white),
        Icon(Icons.map_outlined,color: Colors.white),
        Icon(Icons.question_mark,color: Colors.white)
      ],
      onTap: (value) => onTapFunc!(value),
    );*/
  }
}
