import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe2/MainScreen.dart';
import 'package:tictactoe2/SinglePlayerScreen.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final player = AudioCache();

    bool playSound = true;

    player.loop('theme.mp3');

    return Scaffold(
      body: Center(
        child: Container(
          //color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MenuLetter("TIC", Colors.blue),
              MenuLetter("TAC", Colors.red),
              MenuLetter("TOE", Colors.blue),
              Container(
                width: 120.0,
                decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
                child: FlatButton(
                  child: Text(
                    "Single Player",
                    style: GoogleFonts.fredokaOne(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () {
                    final player = AudioCache();

                    player.play('playagain.mp3');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => SinglePlayer()));
                  },
                ),
              ),
              Container(
                width: 120.0,
                decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
                child: FlatButton(
                  child: Text(
                    "Multiplayer",
                    style: GoogleFonts.fredokaOne(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () {
                    final player = AudioCache();

                    player.play('playagain.mp3');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => MainScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuLetter extends StatelessWidget {
  final String title;
  final Color textC;
  MenuLetter(
    this.title,
    this.textC,
  );

  @override
  Widget build(BuildContext context) {
    return Text(
      this.title,
      style: GoogleFonts.fredokaOne(
        color: textC,
        textStyle: Theme.of(context).textTheme.headline1,
        fontSize: 50,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
