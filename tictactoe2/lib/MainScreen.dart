import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe2/MainMenu.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<List<String>> myBoard = [
    ['', '', ''],
    ['', '', ''],
    ['', '', '']
  ];

  List<List<int>> boardCoord = [
    [0, 0],
    [0, 1],
    [0, 2],
    [1, 0],
    [1, 1],
    [1, 2],
    [2, 0],
    [2, 1],
    [2, 2]
  ];

  bool oTurn = false;
  int rowBoard = -1;
  int colBoard = -1;
  List<String> displayBoxContext = ['', '', '', '', '', '', '', '', ''];

  int oScore = 0;
  int xScore = 0;
  int tileLeft = 9;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 90,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Player X",
                style: GoogleFonts.fredokaOne(
                  color: Colors.red,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 40.0,
                width: 80.0,
                decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      xScore.toString(),
                      style: GoogleFonts.fredokaOne(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    Text(
                      "-",
                      style: GoogleFonts.fredokaOne(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    Text(
                      oScore.toString(),
                      style: GoogleFonts.fredokaOne(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Player O",
                style: GoogleFonts.fredokaOne(
                  color: Colors.blue,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          //Between the board and Scores
          SizedBox(
            height: 80,
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: GridView.builder(
                  //Creating a grid with 9 containers
                  itemCount: 9,
                  //CrossAxis == number of objects per axis. Here we want 3x3 so 3 items each axis
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  //The actual Container object each
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        if (index == 0 || index == 1 || index == 2) {
                          rowBoard = 0;
                        } else if (index == 3 || index == 4 || index == 5) {
                          rowBoard = 1;
                        } else if (index == 6 || index == 7 || index == 8) {
                          rowBoard = 2;
                        }
                        _tapped(index);
                      },
                      child: Container(
                        //Adding the line between each container box
                        decoration: BoxDecoration(
                            //border: Border.all(color: Colors.grey[700])),
                            border: buildBorder(index)),
                        //The box contents is displayed by the displayBoxContent returned Object
                        child: Center(
                            child: PlayerColor(myBoard, boardCoord, index)),
                      ),
                    );
                  }),
            ),
          ),

          //Container(),
        ],
      ),
    );
  }

  void _displayWinner(String winner) {
    showDialog(
        barrierDismissible:
            false, //You can't click anywahere else to get rid of the alert. (Set as false)
        context: context,
        builder: (BuildContext context) {
          if (winner == 'D') {
            return AlertDialog(
              title: Text(
                "It was a draw!!!",
                style: GoogleFonts.fredokaOne(
                  color: Colors.black,
                  textStyle: Theme.of(context).textTheme.headline1,
                  fontSize: 50,
                  fontWeight: FontWeight.w700,
                ),
              ),
              actions: <Widget>[
                Container(
                  child: FlatButton(
                    color: Colors.lightBlue,
                    onPressed: () {
                      final player = AudioCache();
                      player.play('mainmenu.mp3');

                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Main Menu",
                      style: GoogleFonts.fredokaOne(
                        color: Colors.white,
                        textStyle: Theme.of(context).textTheme.headline1,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: FlatButton(
                      color: Colors.red,
                      child: Text(
                        "Play Again!",
                        style: GoogleFonts.fredokaOne(
                          color: Colors.white,
                          textStyle: Theme.of(context).textTheme.headline1,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onPressed: () {
                        final player = AudioCache();
                        player.play('playagain.mp3');

                        _clearBoard();
                        Navigator.of(context).pop(); // Get rid of the alert box
                      }),
                )
              ],
            );
          } else {
            return AlertDialog(
              title: Text(
                "'" + winner + "' player won the game!!!",
                style: GoogleFonts.fredokaOne(
                  color: Colors.black,
                  textStyle: Theme.of(context).textTheme.headline1,
                  fontSize: 50,
                  fontWeight: FontWeight.w700,
                ),
              ),
              actions: <Widget>[
                Container(
                  child: FlatButton(
                    color: Colors.lightBlue,
                    onPressed: () {
                      final player = AudioCache();
                      player.play('mainmenu.mp3');
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Main Menu",
                      style: GoogleFonts.fredokaOne(
                        color: Colors.white,
                        textStyle: Theme.of(context).textTheme.headline1,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: FlatButton(
                      color: Colors.red,
                      child: Text(
                        "Play Again!",
                        style: GoogleFonts.fredokaOne(
                          color: Colors.white,
                          textStyle: Theme.of(context).textTheme.headline1,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onPressed: () {
                        final player = AudioCache();
                        player.play('playagain.mp3');

                        _clearBoard();
                        Navigator.of(context)
                            .pop(); // Pop/Get rid of the aleart box
                      }),
                )
              ],
            );
          }
        });
  }

  void _clearBoard() {
    setState(() {
      int size = 3;
      for (int r = 0; r < size; r++) {
        for (int c = 0; c < size; c++) {
          myBoard[r][c] = '';
        }
      }
      oTurn = false;
      tileLeft = 9;
    });
  }

  void _checkWin(int index, int x, int y) {
    String winner = "";

    int xCol = 0, xRow = 0, xDiag = 0, xRdiag = 0;
    int yCol = 0, yRow = 0, yDiag = 0, yRdiag = 0;

    for (int i = 0; i < 3; i++) {
      if (myBoard[x][i] == 'X') {
        xCol += 1;
      } else if (myBoard[x][i] == 'O') {
        yCol += 1;
      }

      if (myBoard[i][y] == 'X') {
        xRow += 1;
      } else if (myBoard[i][y] == 'O') {
        yRow += 1;
      }

      if (myBoard[i][i] == 'X') {
        xDiag += 1;
      } else if (myBoard[i][i] == 'O') {
        yDiag += 1;
      }

      if (myBoard[i][2 - i] == 'X') {
        xRdiag += 1;
      } else if (myBoard[i][2 - i] == 'O') {
        yRdiag += 1;
      }
    }

    //X wins
    if (xRow == 3 || xCol == 3 || xDiag == 3 || xRdiag == 3) {
      winner = 'X';
      xScore += 1;
      _displayWinner(winner);
    }

    //Y wins
    if (yRow == 3 || yCol == 3 || yDiag == 3 || yRdiag == 3) {
      winner = 'O';
      oScore += 1;
      _displayWinner(winner);
    }

    //Draw
    else if (tileLeft == 0 && winner == '') {
      winner = 'D';
      _displayWinner(winner);
    }
  }

  void _tapped(int index) {
    //SetState in flutter: whenever setState() is called, it will re run the HomePageState. (To display/update the current state)
    setState(() {
      int x = boardCoord[index][0];
      int y = boardCoord[index][1];
      if (oTurn && myBoard[x][y] == '') {
        final player = AudioCache();
        player.play('ySound.mp3');

        myBoard[x][y] = 'O';
        tileLeft -= 1;
        //displayBoxContext[index] = 'O';
      } else if (!oTurn && myBoard[x][y] == '') {
        final player = AudioCache();
        player.play('xSound.mp3');

        myBoard[x][y] = 'X';
        tileLeft -= 1;
        //displayBoxContext[index] = 'X';
      }
      oTurn = !oTurn;
      _checkWin(index, x, y);
    });
  }

  Border buildBorder(index) {
    double w = 0.20;
    Color c = Colors.lightBlue[200];
    BorderSide bs = BorderSide(width: w, color: c);

    switch (index) {
      case 0:
        return Border(
          right: bs,
          bottom: bs,
        );
      case 1:
        return Border(
          left: bs,
          bottom: bs,
          right: bs,
        );
      case 2:
        return Border(
          left: bs,
          bottom: bs,
        );
      case 3:
        return Border(
          top: bs,
          right: bs,
          bottom: bs,
        );
      case 4:
        return Border(
          left: bs,
          top: bs,
          right: bs,
          bottom: bs,
        );
      case 5:
        return Border(
          top: bs,
          left: bs,
          bottom: bs,
        );
      case 6:
        return Border(
          right: bs,
          top: bs,
        );
      case 7:
        return Border(left: bs, right: bs, top: bs);
      case 8:
        return Border(
          left: bs,
          top: bs,
        );
    }
  }
}

class PlayerColor extends StatelessWidget {
  final List<List<String>> myBoard;
  final List<List<int>> boardCoord;
  final index;

  const PlayerColor(
    this.myBoard,
    this.boardCoord,
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    Color c;
    if (myBoard[boardCoord[index][0]][boardCoord[index][1]] == 'X') {
      c = Colors.red;
    } else {
      c = Colors.blue;
    }
    return Text(
      myBoard[boardCoord[index][0]][boardCoord[index][1]],
      //displayBoxContext[index],
      //index.toString(),
      style: GoogleFonts.fredokaOne(
        color: c,
        textStyle: Theme.of(context).textTheme.headline1,
        fontSize: 100,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
