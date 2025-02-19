import 'package:ball_run/controllers/home_controllers.dart';
import 'package:ball_run/my_game.dart';
import 'package:ball_run/widgets/setting.dart';
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
  HomeControllers homeController = HomeControllers();

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
            builder: (context, gameState currentState, child) {
              if (currentState == gameState.playing ||
                  currentState == gameState.gameOver ||
                  currentState == gameState.pause) {
                return Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: (currentState == gameState.gameOver ||
                            currentState == gameState.pause)
                        ? BoxDecoration(
                            color: Colors.black54,
                          )
                        : null,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    child: Column(
                      spacing: 300,
                      children: [
                        if (currentState != gameState.gameOver)
                        Row(
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
                            currentState == gameState.pause
                                ? IconButton(
                                    onPressed: () {
                                      _myGame.resumeGame();
                                    },
                                    icon: Icon(
                                      Icons.play_arrow_rounded,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  )
                                : IconButton(
                                        onPressed: () {
                                          _myGame.pauseGame();
                                        },
                                        icon: Icon(
                                          Icons.pause_rounded,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      )
                                    
                          ],
                        ),
                        if (currentState == gameState.pause)
                          Container(
                            child: Column(
                              spacing: 50,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _myGame.resumeGame();
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.white12,
                                      ),
                                      child: Icon(
                                        Icons.play_arrow_rounded,
                                        color: Colors.white,
                                        size: 150,
                                      )),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 20,
                                  children: [
                                    IconButton(
                                      onPressed: () {_myGame.menu();},
                                      icon: Icon(Icons.home),
                                      color: Colors.white,
                                      iconSize: 35,
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.volume_up_rounded),
                                      iconSize: 35,
                                      color: Colors.white,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),

                        if(currentState == gameState.gameOver)
                        Expanded(
                          child: Container(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white10,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: IconButton(
                                        onPressed: () {
                                          _myGame.menu();
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_rounded,
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
                                    color: Color.fromARGB(255, 255, 196, 0),
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
                            Column(
                              spacing: 50,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text('Score : ${_myGame.currentScore.value}',
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.white,
                                       shadows: [
                                      Shadow(
                                          offset: Offset(0, 0),
                                          blurRadius: 5,
                                          color: Colors.black),
                                    ],
                                    ),),
                                    if(_myGame.bestScore == _myGame.currentScore.value)
                                    Text('New Recored : ${_myGame.bestScore}',
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.amberAccent,
                                       shadows: [
                                      Shadow(
                                          offset: Offset(0, 0),
                                          blurRadius: 5,
                                          color: Colors.black),
                                    ],
                                    ),)else
                                    Text('Best Score : ${_myGame.bestScore}',
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.amberAccent,
                                       shadows: [
                                      Shadow(
                                          offset: Offset(0, 0),
                                          blurRadius: 5,
                                          color: Colors.black),
                                    ],
                                    ),)
                                  ],
                                ),
                                
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 15,
                                  children: [
                                    InkWell(
                                      onTap: () {_myGame.menu();},
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: Colors.white10
                                          ),
                                          padding: EdgeInsets.all(10),
                                          child: Icon(Icons.home,size: 35,color: Colors.white,),
                                      ),
                                    ),
                                    InkWell(
                                  onTap: () {
                                    _myGame.restartGame();
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.white12,
                                      ),
                                      child: Icon(
                                        Icons.refresh_rounded,
                                        color: Colors.white,
                                        size: 150,
                                      )),
                                ),
                                    InkWell(
                                      onTap: (){},
                                      child: 
                                       Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          color: Colors.white10
                                        ),
                                        padding: EdgeInsets.all(15),
                                         child: Image.asset(
                                          '/images/advideo.png',
                                          height: 25,
                                          width: 25,
                                                                               ),
                                       ),
                                    )
                                  ],
                                )
                              ],
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

                      ],
                    ),
                  ),
                );
              } else if (currentState == gameState.menu) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: InkWell(
                    onTap: () {
                      _myGame.startGame();
                    },
                    child: Container(
                      height: double.infinity,
                      padding:
                          EdgeInsets.all( 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white10,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: IconButton(
                                      onPressed: () {
                                       showDialog(context: context, builder: (context) {
                                         return Material(
                                          type: MaterialType.transparency,
                                          child: Setting(),
                                         );
                                       },);
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
                                  color: Color.fromARGB(255, 255, 196, 0),
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
