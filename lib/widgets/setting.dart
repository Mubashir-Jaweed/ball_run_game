import 'package:ball_run/controllers/home_controllers.dart';
import 'package:ball_run/my_game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  final HomeControllers homeControllers;
  const Setting({super.key, required this.homeControllers});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  void deleteAccount() async {
    widget.homeControllers.deleteAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff222222),
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //top column
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(50)),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.home_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                'Setting',
                style: TextStyle(
                  fontSize: 40,
                  height: 0.9,
                  letterSpacing: 2,
                  color: Color.fromARGB(255, 255, 196, 0),
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  decorationStyle: TextDecorationStyle.double,
                  shadows: [
                    Shadow(
                        offset: Offset(0, 0),
                        blurRadius: 5,
                        color: Colors.white10),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Game music : ',
                    style: TextStyle(
                      fontSize: 32,
                      height: 0.9,
                      letterSpacing: 2,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.volume_up_rounded),
                    iconSize: 35,
                    color: Colors.white,
                  ),
                ],
              )
            ],
          ),
          // author column
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Produced by',
                style: TextStyle(
                  fontSize: 40,
                  height: 0.9,
                  letterSpacing: 2,
                  color: Color.fromARGB(255, 255, 196, 0),
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  decorationStyle: TextDecorationStyle.double,
                  shadows: [
                    Shadow(
                        offset: Offset(0, 0),
                        blurRadius: 5,
                        color: Colors.white10),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Mubashir Jaweed \n & team',
                style: TextStyle(
                  fontSize: 32,
                  height: 1,
                  letterSpacing: 2,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          //delete column
          Column(
            children: [
              Text(
                'Danger zone',
                style: TextStyle(
                  fontSize: 40,
                  height: 0.9,
                  letterSpacing: 2,
                  color: Color.fromARGB(255, 255, 196, 0),
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  decorationStyle: TextDecorationStyle.double,
                  shadows: [
                    Shadow(
                        offset: Offset(0, 0),
                        blurRadius: 5,
                        color: Colors.white10),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Delete account',
                style: TextStyle(
                  fontSize: 32,
                  height: 1,
                  letterSpacing: 2,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  deleteAccount();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red),
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 1,
          )
        ],
      ),
    );
  }
}
