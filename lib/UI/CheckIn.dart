import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckIn extends StatefulWidget {
  @override
  CheckInState createState() => new CheckInState();
}

class CheckInState extends State<CheckIn> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: Center(
          child: RaisedButton(
            onPressed: (){},
            padding: EdgeInsets.all(30.0),
            child: Text("上班"),
            color: Colors.red,
            textColor: Colors.white,
            splashColor: Colors.black,
            highlightColor: Colors.green,
          ),
        )),
        Expanded(
            child: Center(
          child: RaisedButton(
            onPressed: (){},
            padding: EdgeInsets.all(30.0),
            child: Text("下班"),
            color: Colors.red,
            textColor: Colors.white,
            splashColor: Colors.black,
            highlightColor: Colors.green,
          ),
        )),
        Container(
          height: 150,
//          color: Colors.red,
          child: Column(
            children: <Widget>[
              Expanded(child: Center(child: Text("上班时间：未打卡"),)),
              Expanded(child: Center(child: Text("下班时间：未打卡"),)),
            ],
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(CheckIn oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
