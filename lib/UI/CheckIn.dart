import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:worknote/Model/WorkNoteModel.dart';

class CheckIn extends StatefulWidget {
  @override
  CheckInState createState() => new CheckInState();
}

class CheckInState extends State<CheckIn> with AutomaticKeepAliveClientMixin {
  WorkNote mWorkNote;
  var todoProvider = TodoProvider();


  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        Expanded(
            child: Center(
          child: RaisedButton(
            onPressed: () {
              todoProvider.open().then((version) {
                todoProvider.gotoWork().then((id) {
                  print(id);
                }, onError: (e) {
                  print("go to work error");
                });
              }, onError: (e) {
                print("open db error");
              });
            },
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
            onPressed: () {
              TodoProvider().open().then((version) {
                todoProvider.offWork().then((id) {
                  print(id);
                }, onError: (e) {
                  print("off work error");
                });
              }, onError: (e) {
                print("open db error");
              });
            },
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
              Expanded(
                  child: Center(
                child: Text("上班时间：${mWorkNote?.goToTime == null? "未签到":mWorkNote.goToTime}"),
              )),
              Expanded(
                  child: Center(
                child: Text("下班时间：${mWorkNote?.offTime == null? "未签到":mWorkNote.offTime}"),
              )),
              Expanded(
                  child: Center(
                child: Text("累计时长：${timeCutResult(mWorkNote?.goToTime, mWorkNote?.offTime)}"),
              )),
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
    ref();
  }

  void ref(){
    todoProvider.open().then((version) {
      todoProvider.getToday().then((workNote) {
        setState(() {
          mWorkNote = workNote;
        });
      }, onError: (e) {
        print("get today workNote error");
      });
    }, onError: (e) {
      print("open db error");
    });
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
