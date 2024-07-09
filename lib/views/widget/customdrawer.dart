import 'package:car_pool/views/screens/login_screen.dart';
import 'package:car_pool/views/screens/test_page.dart';
import 'package:car_pool/utils/app_sizedbox.dart';
import 'package:car_pool/utils/constant/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(),
            child: Row(
              children: [
                CircleAvatar(),
                CustomSizedBoxWidth(0.04),
                CustomText(text: 'Sithara Thomas', fontSize: 0.05)
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.speed),
            title: const Text('Ride History'),
            onTap: () {
              Get.to(const MapPage());
            },
          ),
          const ListTile(
              leading: Icon(Icons.trending_up_sharp), title: Text('Trips')),
          const ListTile(
              leading: Icon(Icons.picture_in_picture_alt), title: Text('Whiz')),
          const ListTile(leading: Icon(Icons.payment), title: Text('Payments')),
          const ListTile(
              leading: Icon(Icons.settings), title: Text('Settings')),
          const ListTile(leading: Icon(Icons.person), title: Text('Profile')),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text('Sign Out'),
            onTap: () {
              Get.off(const LoginScreen());
            },
          ),
        ],
      ),
    );
  }
}
