import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double translateX = 0.0;
  double translateY = 0.0;
  double myWidth = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Slide to Action"),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.00),
              color: Colors.blue[50]),
          width: MediaQuery.of(context).size.width - 100,
          height: 100,
          child: GestureDetector(
            onHorizontalDragUpdate: (event) async {
              if (event.primaryDelta! > 10) {
                _incTansXVal();
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                paymentSuccessful(),
                myWidth == 0.0
                    ? Expanded(
                        child: Center(
                          child: Text(
                            "Swipe to make payment",
                            style:
                                TextStyle(color: Colors.blue, fontSize: 20.00),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget paymentSuccessful() => Transform.translate(
        offset: Offset(translateX, translateY),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.linear,
          width: 100 + myWidth,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.00),
            color: Colors.blue,
          ),
          child: myWidth > 0.0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 30,
                    ),
                    Flexible(
                      child: Text(
                        " Payment successful ",
                        style: TextStyle(color: Colors.white, fontSize: 20.00),
                      ),
                    ),
                  ],
                )
              : Icon(
                  Icons.navigate_next,
                  color: Colors.white,
                  size: 50.00,
                ),
        ),
      );

  _incTansXVal() async {
    int canLoop = -1;
    for (var i = 0; canLoop == -1; i++)
      await Future.delayed(Duration(milliseconds: 1), () {
        setState(() {
          if (translateX + 1 <
              MediaQuery.of(context).size.width - (200 + myWidth)) {
            translateX += 1;
            myWidth = MediaQuery.of(context).size.width - (200 + myWidth);
          } else {
            setState(() {
              canLoop = 1;
            });
          }
        });
      });
  }
}
