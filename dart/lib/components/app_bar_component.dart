import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget {
  final bool subtitleOn;
  final void Function() onPressed;
  AppBarComponent({super.key, this.subtitleOn = true, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      backgroundColor: const Color(0xff456189),
      centerTitle: true,
      title: SafeArea(
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Chuva',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.favorite,
                  color: Color(0xffb642f5),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Flutter',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            if (subtitleOn)
              const Text(
                'Programação',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
