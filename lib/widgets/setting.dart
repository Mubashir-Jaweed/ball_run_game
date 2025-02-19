import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
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
                  color: Colors.white,
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
                  color: Colors.white,
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
                  color: Colors.white,
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
            ],
          )
        ],
      ),
    );
  }
}
