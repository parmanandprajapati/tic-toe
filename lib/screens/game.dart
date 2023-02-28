import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_toe/constants/colors.dart';
import 'dart:async';



class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  //google_fonts plugin
  int attempts =0;
  bool oTurn = true;
  List<String> displayXO = ['','','','','','','','','',];
  List<int> matchedIndexs=[];
  String resultDeclartion='';
  int oScore=0;
  int xScore=0;
  int filledBoxes = 0;
  bool winnerfound= false;
  Timer? timer;
  static const maxSeconds=30;
  int seconds =maxSeconds;

  static var customFontWhite = GoogleFonts.coiny(
    textStyle: TextStyle(
      color:Colors.white,
      letterSpacing: 3,
      fontSize: 28
    )
  );
  void startTimer(){
    timer=Timer.periodic(Duration(seconds:1), (_){
      setState(() {

        if(seconds >0){
          seconds--;
        }
        else{
          stopTrimer();
        }
      });
    });
  }
  void stopTrimer(){
    resetTimer();
    timer?.cancel();
  }
  void resetTimer()=>
    seconds=maxSeconds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //using from colors.dart file
      backgroundColor: MainColor.primaryColor,
      body:Padding(
        padding: const EdgeInsets.all(45),
        child: Column(
          children: [
            Expanded(
              flex:1,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children :[
                    Column (
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Player 0',style:customFontWhite,),
                        Text(oScore.toString(),style:customFontWhite)
                      ],
                    ),

                    Column (
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Player X',style:customFontWhite,),
                        Text(xScore.toString(),style:customFontWhite)
                      ],
                    ),
                  ]
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child:SafeArea(
                child: GridView.builder(gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    itemBuilder: (BuildContext context ,int index)
                {
                  return GestureDetector(
                    onTap: (){
                      _tapped(index);

                    },
                    child: Container(decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border:Border.all(
                        width: 5,
                        color: MainColor.primaryColor,
                      ),
                      color:matchedIndexs.contains(index)? MainColor.accentColor : MainColor.secondaryColor,
                    ),
                      child:Center(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(displayXO[index],

                              style: GoogleFonts.coiny(textStyle:
                          TextStyle(
                            fontSize: 64,
                            color:MainColor.primaryColor
                          ))),
                        ),
                      )
                    ),
                  );
                },
                ),
              ),

            ),

            Expanded(
              flex: 2,
              child: Center(
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(resultDeclartion,style:
                    customFontWhite,),
                    SizedBox(height: 10,),

                    Widget_buildTimer(),
                  ],
                )
              ),
            ),
          ],
        ),
      )
    );
  }
  void _tapped(int index){
    final isRunning =timer==null ? false: timer!.isActive;
    if(isRunning){ setState(() {
      if(oTurn && displayXO[index]=='') {
        displayXO[index]='0';
        filledBoxes++;
      }
      else if (!oTurn && displayXO[index]==''){
        displayXO[index]='X';
        filledBoxes++;
      }
      // else{
      //   displayXO[index]='X';
      // }
      oTurn = !oTurn;
      _checkWinner();
    });}

  }
  void _checkWinner(){
    if( displayXO[0]==displayXO[1]
        && displayXO[0]==displayXO[2]
    && displayXO[0] !=''){
      setState(() {
        resultDeclartion ='Player '+ displayXO[0]+ ' wins';
        matchedIndexs.addAll([0,1,2]);
        stopTrimer();
        _updateScore(displayXO[0]);
      });
    }  if( displayXO[3]==displayXO[4]
        && displayXO[3]==displayXO[5]
    && displayXO[3] !=''){
      setState(() {
        resultDeclartion ='Player '+ displayXO[3]+ ' wins';
        matchedIndexs.addAll([3,4,5]);
        stopTrimer();
        _updateScore(displayXO[3]);
      });
    }  if( displayXO[6]==displayXO[7]
        && displayXO[6]==displayXO[8]
    && displayXO[6] !=''){
      setState(() {
        resultDeclartion ='Player '+ displayXO[6]+ ' wins';
        matchedIndexs.addAll([6,7,8]);
        stopTrimer();
        _updateScore(displayXO[6]);
      });
      //column
    }  if( displayXO[0]==displayXO[3]
        && displayXO[0]==displayXO[6]
    && displayXO[0] !=''){
      setState(() {
        resultDeclartion ='Player '+ displayXO[0]+ ' wins';
        matchedIndexs.addAll([0,3,6]);
        stopTrimer();
        _updateScore(displayXO[0]);
      });
    }  if( displayXO[1]==displayXO[4]
        && displayXO[1]==displayXO[7]
    && displayXO[1] !=''){
      setState(() {
        resultDeclartion ='Player '+ displayXO[1]+ ' wins';
        matchedIndexs.addAll([1,4,7]);
        stopTrimer();
        _updateScore(displayXO[1]);
      });
    }  if( displayXO[2]==displayXO[5]
        && displayXO[2]==displayXO[8]
    && displayXO[2] !=''){
      setState(() {
        resultDeclartion ='Player '+ displayXO[2]+ ' wins';
        matchedIndexs.addAll([2,5,8]);
        stopTrimer();
        _updateScore(displayXO[2]);
      });
    }
    // digonal
    if( displayXO[0]==displayXO[4]
        && displayXO[0]==displayXO[8]
    && displayXO[0] !=''){
      setState(() {
        resultDeclartion ='Player '+ displayXO[0]+ ' wins';
        matchedIndexs.addAll([0,4,8]);
        stopTrimer();
        _updateScore(displayXO[0]);
      });
    }if( displayXO[2]==displayXO[4]
        && displayXO[2]==displayXO[6]
    && displayXO[2] !=''){
      setState(() {
        resultDeclartion ='Player '+ displayXO[2]+ ' wins';
        matchedIndexs.addAll([2,4,6]);
        stopTrimer();
        _updateScore(displayXO[2]);
      });
    }
  if (!winnerfound && filledBoxes==9){
    setState(() {
      resultDeclartion='Nobody Wins';
    });
  }
  }
  void _updateScore(String winner){
    if (winner == '0'){
      oScore++;
    }
    else if (winner=='X'){
      xScore++;
    }
    winnerfound=true;
  }
  void _clearBoard(){
    setState(() {
      for(int i =0;i<9;i++){
        displayXO[i]='';

      }
      resultDeclartion ='';

    });
    filledBoxes=0;
  }
  Widget_buildTimer(){
    final isRunning =timer==null ? false: timer!.isActive;
    return isRunning ? SizedBox(
      width:100,
      height: 100,
      child:Stack(
        fit:StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: 1-seconds/maxSeconds,
            valueColor: AlwaysStoppedAnimation(Colors.white),
            strokeWidth: 8,
            backgroundColor: MainColor.accentColor,
          ),
          Center(
            child: Text('$seconds',style:TextStyle(
              fontWeight: FontWeight.bold,color: Colors.white,
              fontSize: 50,
            )),
          )
        ],
      )
    ):
    ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: EdgeInsets.symmetric(
                horizontal: 32,vertical:16)

        ),
        onPressed: (){
          startTimer();
          _clearBoard();
          attempts++;
        },
        child: Text(
          attempts==0? 'start':
            'Play Again!',
            style: TextStyle(fontSize: 20,color:Colors.black)
        ));
  }
}
