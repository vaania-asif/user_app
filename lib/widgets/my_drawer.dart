import 'package:flutter/material.dart';
import 'package:user_app/global/global.dart';
import 'package:user_app/splashScreen/splash_screen.dart';


class MyDrawer extends StatefulWidget {

  String? name;
  String? email;

  MyDrawer({this.name, this.email,});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 165,
            color : Colors.grey,
            child: DrawerHeader(
              decoration: const BoxDecoration(color: Colors.black),
              child: Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 40,
                      color: Colors.grey,
                  ),

                  const SizedBox(width: 16,),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.name.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        widget.email.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              )

            ),
          ),

          const SizedBox(height: 12.0,),

          //drawer body
          GestureDetector(
            onTap: (){

            },
            child: const ListTile(
              leading: Icon(Icons.history,
              color: Colors.white54,),
              title: Text(
                "History",
                style: TextStyle(
                  color: Colors.white54
                ),
            ),
            ),
          ),

          GestureDetector(
            onTap: (){

            },
            child: const ListTile(
              leading: Icon(Icons.person,
                color: Colors.white54,),
              title: Text(
                "Visit Profile",
                style: TextStyle(
                    color: Colors.white54
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){

            },
            child: const ListTile(
              leading: Icon(Icons.info,
                color: Colors.white54,),
              title: Text(
                "About Us",
                style: TextStyle(
                    color: Colors.white54
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              firebaseAuth.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (c)=> MySplashScreen()));

            },
            child: const ListTile(
              leading: Icon(Icons.logout_rounded,
                color: Colors.white54,),
              title: Text(
                "Sign Out",
                style: TextStyle(
                    color: Colors.white54
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
