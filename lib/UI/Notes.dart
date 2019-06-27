import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:worknote/Model/WorkNoteModel.dart';

class Notes extends StatefulWidget {
  @override
  NotesState createState() => new NotesState();
}

class NotesState extends State<Notes> with AutomaticKeepAliveClientMixin {
  var items = List<Map>();

  var todoProvider = TodoProvider();
  var allTime = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 100,child: Text(allTime),),
        Expanded(
            child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text(
                      "${items[index][columnYear]}年${items[index][columnMonth]}月${items[index][columnDay]}日",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                        "上班：${items[index][columnGotoTime]}  下班：${items[index][columnOffTime]}  时长：${items[index][columnWorkHours]}")
                  ],
                ));
          },
        ))
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    todoProvider.open().then((version) {
      todoProvider
          .getMonthData(
              DateTime.now().year.toString(), DateTime.now().month.toString())
          .then((data) {
//            print(data.length);
        setState(() {
          items = data;
          addAllTime();
        });
      });
    });
  }

  void addAllTime(){
    allTime = "";
    if(items.length > 0){
      items.forEach((data){
        if (allTime == ""){
          allTime = data[columnWorkHours];
        }else{
          allTime = timeAddResult(allTime, data[columnWorkHours]);
        }
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(Notes oldWidget) {
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
