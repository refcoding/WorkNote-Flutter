import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:worknote/UI/CheckIn.dart';
import 'package:worknote/UI/Notes.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  int _currentPageIndex = 0;
  var _pageController = new PageController(initialPage: 0);
  void _pageChange(int index) {
    setState(() {
      if (_currentPageIndex != index) {
        _currentPageIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var bottomItems = List<BottomNavigationBarItem>();
    bottomItems.add(
        BottomNavigationBarItem(icon: Icon(Icons.check), title: Text("打卡")));
    bottomItems.add(BottomNavigationBarItem(
        icon: Icon(Icons.assessment), title: Text("记录")));
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('WorkNote'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {
            showCupertinoModalPopup(context: context, builder: (BuildContext context){
              return Container(
                height: 200,
                color: Colors.white,
              );
            });
          }),
        ],
      ),
      body: PageView.builder(
        onPageChanged: _pageChange,
        controller: _pageController,
        itemBuilder: (BuildContext context, int index) {
          return index == 0 ? CheckIn() : Notes();
        },
        itemCount: 2,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomItems,
        currentIndex: _currentPageIndex,
        onTap: (int index) {
          //_pageController.jumpToPage(index); 没有动画的页面切换
          _pageController.animateToPage(index,
              duration: new Duration(seconds: 2),
              curve: new ElasticOutCurve(0.8));
          _pageChange(index);
        },
      ),
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
  void didUpdateWidget(Home oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
