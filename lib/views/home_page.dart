import 'package:deal_app_test/views/cart_screen.dart';
import 'package:deal_app_test/views/notification_screen.dart';
import 'package:deal_app_test/views/settings_screen.dart';
import 'package:flutter/material.dart';

import '../modal/authentication/google_signin_page.dart';
import 'home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentSelectedIndex = 0;
  static List<Widget> _pages = <Widget>[
    HomeScreen(),
    NotificationScreen(),
    CartScreen(),
    SettingsScreen()
  ];
  void _onTabTapped(int index) {
    setState(() {
      _currentSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              Text(
                "DEAL",
                style: TextStyle(
                    color: Color(0xFFC50000),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: ' Poppins-SemiBold'),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "NINJA",
                style: TextStyle(
                    color: Color(0xBD5E0000),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: ' Poppins-SemiBold'),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Image(
                image: AssetImage('asset/images/search.png'),
                width: 20,
                height: 35,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Image(
                image: AssetImage('asset/images/marker.png'),
                width: 20,
                height: 35,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Image(
                image: AssetImage('asset/images/shopping-cart.png'),
                width: 20,
                height: 35,
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("name!",
                    style: TextStyle(
                      fontFamily: 'Poppins-Regular',
                      fontSize: 16,
                    )),
                accountEmail: Text("email!",
                    style: TextStyle(
                      fontFamily: 'Poppins-Regular',
                      fontSize: 16,
                    )),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                    " imageUrl!",
                  ),
                ),
              ),
              ListTile(
                  title: Text("name!",
                      style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontSize: 16,
                      )),
                  leading: Icon(Icons.account_circle_rounded)),
              Container(
                width: 270, // Adjust the width as needed
                child: Divider(
                  height: 1, // You can also adjust the height if needed
                  color: Colors.black45, // Customize the color as desired
                ),
              ),
              ListTile(
                  onTap: () {},
                  title: Text("email!",
                      style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontSize: 16,
                      )),
                  leading: Icon(Icons.email_outlined)),
              Container(
                width: 270, // Adjust the width as needed
                child: Divider(
                  height: 1, // You can also adjust the height if needed
                  color: Colors.black45, // Customize the color as desired
                ),
              ),
              ListTile(
                  onTap: () {},
                  title: Text("Settings",
                      style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontSize: 16,
                      )),
                  leading: Icon(Icons.settings)),
              Container(
                width: 270, // Adjust the width as needed
                child: Divider(
                  height: 1, // You can also adjust the height if needed
                  color: Colors.black45, // Customize the color as desired
                ),
              ),
              ListTile(
                  onTap: () {
                    // signOutGoogle();
                    // Navigator.of(context)
                    //     .pushNamedAndRemoveUntil('/loginpage', (route) => false);
                  },
                  title: Text("Logout"),
                  leading: Icon(Icons.logout_rounded))
            ],
          ),
        ),
        body: Container(
          height: size.height,
          width: size.width,
          color: Colors.white,
          child: _pages[_currentSelectedIndex],
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            selectedItemColor: Colors.red,
            selectedLabelStyle: TextStyle(fontFamily: 'Poppins-Regular'),
            unselectedItemColor: Colors.black,
            currentIndex: _currentSelectedIndex,
            onTap: _onTabTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Image(
                    width: 20,
                    height: 20,
                    image: AssetImage('asset/images/deal.png')),
                label: "Deals",
              ),
              BottomNavigationBarItem(
                icon: Image(
                    width: 20,
                    height: 20,
                    image: AssetImage('asset/images/bell.png')),
                label: "Notifications",
              ),
              BottomNavigationBarItem(
                icon: Image(
                    width: 20,
                    height: 20,
                    image: AssetImage('asset/images/shopping-cart.png')),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Image(
                    width: 20,
                    height: 20,
                    image: AssetImage('asset/images/settings.png')),
                label: "Cart",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
