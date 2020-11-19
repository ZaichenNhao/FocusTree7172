import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class TimerTest1 extends StatefulWidget{
  createState() => TimerTest1State();
}

class TimerTest1State extends State<TimerTest1> {

  double percent = 0;
  static int min = 25;
  int sec = min*60;
  String buttonState = "Start Studying";

  Timer timer;
  
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Study Timer",
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.lightGreen,
            fontSize: 25
          ),
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        actions: [
          IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
            timer.cancel();
            Navigator.pushReplacementNamed(context, '/study2');
          }, 
          color: Colors.lightGreen,)
        ],
      ),
      body:Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 25),
              child: Text(
                "Pomodoro Technique",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    color: Colors.green[400],
                    fontSize: 30
                )
              )
            ),
            Expanded(
              child: CircularPercentIndicator(
                circularStrokeCap: CircularStrokeCap.round,
                percent: percent,
                animation: true,
                animateFromLastPercent: true,
                radius: 250.0,
                lineWidth: 20.0,
                progressColor: Colors.green[300],
                center: Text(
                  "$min min left",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    color: Colors.green[400],
                    fontSize: 25
                  )
                )
              )
            ),
            SizedBox(height: 35.0),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green[200],
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0))
                ),
                child: Padding(
                  padding: EdgeInsets.only(top:50.0, left:20.0, right:20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "Study Time",
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: 25
                                    )
                                  ),
                                  SizedBox(height: 20.0),
                                  Text(
                                    "25min",
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: 25
                                    )
                                  )
                                ],
                              )
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "Break Time",
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: 25
                                    )
                                  ),
                                  SizedBox(height: 20.0),
                                  Text(
                                    "5min",
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: 25
                                    )
                                  )
                                ],
                              )
                            )
                          ],
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 28.0),
                        child: RaisedButton(
                          onPressed: _StartTimer,
                          color: Colors.blueGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0)
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Text(
                              buttonState,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 20
                              )
                            )
                          )
                        )
                      )
                    ],
                  ),
                )
              ),
            )
          ],
        )
      )
    );
  }

  _StartTimer(){

    int time = min*60;
    double secPercent = (time/100);

    if(buttonState=="Start Studying"){
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          buttonState="Cancel Session";
          if(time > 0){
            time--;
            if(time % 60 == 0) {
              min--;
            } 
            if(time % secPercent == 0){
              if(percent<1){
                percent += 0.01;
              }
              else{
                percent = 1;
              }
            }
          }
          else{
            percent = 0;
            min = 25;
            timer.cancel();
          }
        });
      });
    }
    else if(buttonState=="Cancel Session"){
      timer.cancel();
      setState(() {
        buttonState="Start Studying";
        percent = 0;
        min = 25;
      });
    }
  }
}