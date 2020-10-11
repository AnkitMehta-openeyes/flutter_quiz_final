import 'package:flutter/material.dart';

class QuestionColor extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(
                width: 15,
                height: 15,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.purple,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),

                ),
              ),
              Text(" - Current Question",
                style: TextStyle(
                  fontSize: 13
                ),
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
                height: 15,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                ),
              ),
              Text(" - Answered",
                style: TextStyle(
                    fontSize: 13
                ),
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
                height: 15,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                ),
              ),
              Text(" - Skipped",
                style: TextStyle(
                    fontSize: 13
                ),
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
                height: 15,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                ),
              ),
              Text(" - Not Answered",
                style: TextStyle(
                    fontSize: 13
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}