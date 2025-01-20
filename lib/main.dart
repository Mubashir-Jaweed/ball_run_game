import 'package:ball_run/my_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Chewy'),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MyGame _myGame;

  @override
  void initState() {
    _myGame = MyGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(
            game: _myGame,
          ),
         ValueListenableBuilder<gameState>(
            valueListenable: _myGame.currentState,
            builder: (context, gameState state, child) {
              if (state == gameState.playing) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ValueListenableBuilder<int>(
                          valueListenable: _myGame.currentScore,
                          builder: (context, int value, child) {
                            return Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                value.toString(),
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            _myGame.pauseGame();
                          },
                          icon: Icon(
                            Icons.pause_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (state == gameState.menu) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: InkWell(
                    onTap: (){
                      _myGame.startGame();
                    },
                    child: Container(
                      height: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white10,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: IconButton(
                                      onPressed: () {
                                        
                                      },
                                      icon: Icon(
                                        Icons.settings_rounded,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white10,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Image.asset(
                                        '/images/noads.png',
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                'Bounce \n Worm',
                                style: TextStyle(
                                  fontSize: 60,
                                  height: 0.9,
                                  letterSpacing: 1,
                                  color:
                                      Color.fromARGB(255, 255, 196, 0),
                                  shadows: [
                                    Shadow(
                                        offset: Offset(0, 0),
                                        blurRadius: 5,
                                        color: Colors.black),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Tap to play',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          Text(
                            'Made with ❤️',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}





//  if (_myGame.currentState == gameState.playing)
//             Align(
//               alignment: Alignment.topCenter,
//               child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     ValueListenableBuilder(
//                       valueListenable: _myGame.currentScore,
//                       builder: (context, int value, child) {
//                         return Container(
//                           padding: EdgeInsets.only(left: 10),
//                           child: Text(
//                             value.toString(),
//                             style: TextStyle(
//                               fontSize: 30,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         _myGame.pauseGame();
//                       },
//                       icon: Icon(
//                         Icons.pause_rounded,
//                         color: Colors.white,
//                         size: 30,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           if (_myGame.currentState == gameState.menu)
//             Align(
//               alignment: Alignment.topCenter,
//               child: Container(
//                 height: double.infinity,
//                 padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       spacing: 50,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.white10,
//                                   borderRadius: BorderRadius.circular(50)),
//                               child: IconButton(
//                                 onPressed: () {
//                                   _myGame.pauseGame();
//                                 },
//                                 icon: Icon(
//                                   Icons.settings_rounded,
//                                   color: Colors.white,
//                                   size: 30,
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.white10,
//                                   borderRadius: BorderRadius.circular(50)),
//                               child: InkWell(
//                                 onTap: () {},
//                                 child: Image.asset(
//                                   '/images/noads.png',
//                                   height: 40,
//                                   width: 40,
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                         const Text(
//                           'Bounce \n Worm',
//                           style: TextStyle(
//                             fontSize: 60,
//                             height: 0.9,
//                             letterSpacing: 1,
//                             color: Color.fromARGB(255, 255, 196, 0),
//                             shadows: [
//                               Shadow(
//                                   offset: Offset(0, 0),
//                                   blurRadius: 5,
//                                   color: Colors.black),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     InkWell(
//                       onTap: (){
//                         _myGame.startGame();
//                       },
//                       child: Container(
//                         padding:
//                             EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                         decoration: BoxDecoration(
//                           color: Colors.white10,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Text(
//                           'Tap to play',
//                           style: TextStyle(
//                               fontSize: 30,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.white),
//                         ),
//                       ),
//                     ),
//                     Text(
//                       'Made with ❤️',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w100,
//                         fontSize: 12,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             )