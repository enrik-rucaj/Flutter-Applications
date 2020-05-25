import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AssetImage cross = AssetImage("images/croce.png");
  AssetImage circle = AssetImage("images/cerchio.png");
  AssetImage edit = AssetImage("images/edit.png");

  bool isCross = true;
  int winCross = 0;
  int winCircle = 0;
  String message;
  List<String> gameState;

  @override
  void initState() {
    super.initState();
    setState(() {
      this.gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
      ];
      this.message = "";
    });
  }

  playGame(int index) {
    if (this.gameState[index] == "empty") {
      setState(() {
        if (this.isCross) {
          this.gameState[index] = "cross";
        } else {
          this.gameState[index] = "circle";
        }
        this.isCross = !this.isCross;
        this.checkWin();
      });
    }
  }

  resetGame() {
    setState(() {
      this.gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
      ];
    });
  }

  AssetImage getImage(String value) {
    switch (value) {
      case ('empty'):
        return edit;
        break;
      case ('cross'):
        return cross;
        break;
      case ('circle'):
        return circle;
        break;
    }
  }

  Delay() {
    setState(() {
      this.resetGame();
    });
    Future.delayed(const Duration(milliseconds: 1600), (){
      this.message = "";
    });
  }

  checkWin() {
    if ((gameState[0] != 'empty') &&
        (gameState[0] == gameState[1]) &&
        (gameState[1] == gameState[2])) {
      setState(() {
        this.message = '${this.gameState[0]} wins';
        if (this.gameState[0] == "circle")
          this.winCircle += 1;
        else
          this.winCross += 1;
        this.Delay();
      });
    } else if ((gameState[3] != 'empty') &&
        (gameState[3] == gameState[4]) &&
        (gameState[4] == gameState[5])) {
      setState(() {
        this.message = '${this.gameState[3]} wins';
        if (this.gameState[3] == "circle")
          this.winCircle += 1;
        else
          this.winCross += 1;
        this.Delay();
      });
    } else if ((gameState[6] != 'empty') &&
        (gameState[6] == gameState[7]) &&
        (gameState[7] == gameState[8])) {
      setState(() {
        this.message = '${this.gameState[6]} wins';
        if (this.gameState[6] == "circle")
          this.winCircle += 1;
        else
          this.winCross += 1;
        this.Delay();
      });
    } else if ((gameState[0] != 'empty') &&
        (gameState[0] == gameState[3]) &&
        (gameState[3] == gameState[6])) {
      setState(() {
        this.message = '${this.gameState[0]} wins';
        if (this.gameState[0] == "circle")
          this.winCircle += 1;
        else
          this.winCross += 1;
        this.Delay();
      });
    } else if ((gameState[1] != 'empty') &&
        (gameState[1] == gameState[4]) &&
        (gameState[4] == gameState[7])) {
      setState(() {
        this.message = '${this.gameState[1]} wins';
        if (this.gameState[1] == "circle")
          this.winCircle += 1;
        else
          this.winCross += 1;
        this.Delay();
      });
    } else if ((gameState[2] != 'empty') &&
        (gameState[2] == gameState[5]) &&
        (gameState[5] == gameState[8])) {
      setState(() {
        this.message = '${this.gameState[2]} wins';
        if (this.gameState[2] == "circle")
          this.winCircle += 1;
        else
          this.winCross += 1;
        this.Delay();
      });
    } else if ((gameState[0] != 'empty') &&
        (gameState[0] == gameState[4]) &&
        (gameState[4] == gameState[8])) {
      setState(() {
        this.message = '${this.gameState[0]} wins';
        if (this.gameState[0] == "circle")
          this.winCircle += 1;
        else
          this.winCross += 1;
        this.Delay();
      });
    } else if ((gameState[2] != 'empty') &&
        (gameState[2] == gameState[4]) &&
        (gameState[4] == gameState[6])) {
      setState(() {
        this.message = '${this.gameState[2]} wins';
        if (this.gameState[2] == "circle")
          this.winCircle += 1;
        else
          this.winCross += 1;
        this.Delay();
      });
    } else if (!gameState.contains('empty')) {
      setState(() {
        this.message = 'Game Draw';
        this.Delay();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tic Tac Toe",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF192A56),
      ),
      body: Container(
        color: Colors.blueGrey[300],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(50),
              child: Text("Vincite x: $winCross \nVincite o: $winCircle",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.lightGreen[900]),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(20.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0),
                itemCount: this.gameState.length,
                itemBuilder: (context, i) => SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: MaterialButton(
                    onPressed: () {
                      this.playGame(i);
                    },
                    child: Image(
                      image: this.getImage(this.gameState[i]),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(50.0),
              child: Text(
                this.message,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh, size: 50,),
        backgroundColor: Colors.lightGreen[900],
        onPressed: (){
          setState(() {
            this.winCircle = 0;
            this.winCross = 0;
            this.message = "";
          });
          resetGame();
        }),
    );
  }
}
