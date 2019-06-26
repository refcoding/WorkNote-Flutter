import 'package:sqflite/sqflite.dart';

final String tableName = 'WorkNote';
final String columnId = '_id';
final String columnYear = 'year';
final String columnMonth = 'month';
final String columnDay = 'day';
final String columnGotoTime = 'go_to_time';
final String columnOffTime = 'off_time';
final String columnWorkHours = 'work_hours';
final String columnMark = 'mark';

final String fileName = "test1.db";

class WorkNote {
  int id;
  String _year="", _month="", _day="", _goToTime="", _offTime="", _mark="";

  String get year => _year;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnYear: _year,
      columnMonth: _month,
      columnDay: _day,
      columnGotoTime: _goToTime,
      columnOffTime: _offTime,
      columnMark: _mark
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  WorkNote();

  WorkNote.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    _year = map[columnYear];
    _month = map[columnMonth];
    _day = map[columnDay];
    _goToTime = map[columnGotoTime];
    _offTime = map[columnOffTime];
    _mark = map[columnMark];
  }

  get month => _month;

  get day => _day;

  get goToTime => _goToTime;

  get offTime => _offTime;

  get mark => _mark;
}

class TodoProvider {
  Database db;

  Future<int> open() async {
    try{
      if(db.isOpen != null && db.isOpen){
        return await db.getVersion();
      }
    }catch(e){

    }

    db = await openDatabase(fileName, version: 6,
        onCreate: (Database db, int version) async {
      print("onCreate");
      await db.execute('''
          create table $tableName (
            $columnId integer primary key autoincrement,
            $columnYear text not null,
            $columnMonth text not null,
            $columnDay text not null,
            $columnGotoTime text,
            $columnOffTime text,
            $columnMark text,
            $columnWorkHours text)
          ''');
    }, onDowngrade: (Database db, int oldVersion, int newVersion) async {
      print("onDowngrade");
    }, onUpgrade: (Database db, int oldVersion, int newVersion) {
      print("onUpgrade");
    });

    print(db.path);
    db.getVersion().then((version) {
      print(version);
    });

    return await db.getVersion();
  }

  Future<WorkNote> insert(WorkNote workNote) async {
    workNote.id = await db.insert(tableName, workNote.toMap());
    return workNote;
  }

  Future<WorkNote> getWorkNote(int id) async {
    List<Map> maps =
        await db.query(tableName, where: '$columnId = ?', whereArgs: [id]);
    if (maps.length > 0) {
      return WorkNote.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(WorkNote workNote) async {
    return await db.update(tableName, workNote.toMap(),
        where: '$columnId = ?', whereArgs: [workNote.id]);
  }

  Future<List<Map>> getMonthData(String year, String month) async{
    return await db.query(tableName,where: '$columnYear = ? and $columnMonth = ?',whereArgs: [year,month]);
  }

  Future<WorkNote> getToday() async {
    List<Map> maps = await db.query(tableName,
        where: '$columnYear = ? and $columnMonth = ? and $columnDay = ?',
        whereArgs: [
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day
        ]);

    if (maps.length > 0) {
      return WorkNote.fromMap(maps.first);
    }
    return null;
  }

  Future<int> gotoWork() async {
    List<Map> maps = await db.query(tableName,
        where: '$columnYear = ? and $columnMonth = ? and $columnDay = ?',
        whereArgs: [
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day
        ]);
    if (maps.length == 0) {
      return await db.insert(tableName, <String, dynamic>{
        columnYear: DateTime.now().year,
        columnMonth: DateTime.now().month,
        columnDay: DateTime.now().day,
        columnGotoTime: "${DateTime.now().hour}:${DateTime.now().minute}",
      });
    } else {
      return await db.update(
          tableName,
          <String, dynamic>{
            columnGotoTime: "${DateTime.now().hour}:${DateTime.now().minute}",
          },
          where: '$columnId = ?',
          whereArgs: [maps.first[columnId]]
      );
    }
  }

  Future<int> offWork() async {
    List<Map> maps = await db.query(tableName,
        where: '$columnYear = ? and $columnMonth = ? and $columnDay = ?',
        whereArgs: [
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day
        ]);
    if (maps.length == 0) {
      return -1;
      //必须先上班
//      return await db.insert(tableName, <String, dynamic>{
//        columnYear: DateTime.now().year,
//        columnMonth: DateTime.now().month,
//        columnDay: DateTime.now().day,
//        columnOffTime: "${DateTime.now().hour}:${DateTime.now().minute}",
//      });
    } else {
      if(maps.first[columnGotoTime] == null){
        //必须先上班
        return -1;
      }
      var offTime = "${DateTime.now().hour}:${DateTime.now().minute}";
      return await db.update(
          tableName,
          <String, dynamic>{
            columnOffTime: offTime,
            columnWorkHours: timeCutResult(maps.first[columnGotoTime], offTime)
          },
          where: '$columnId = ?',
          whereArgs: [maps.first[columnId]]
      );
    }
  }

  Future close() async => db.close();

}

String timeCutResult(String v1, String v2){
  try{
    var time1 = v1.split(":");
    var time2 = v2.split(":");
    int hours1 = int.parse(time1[0]);
    int hours2 = int.parse(time2[0]);

    int min1 = int.parse(time1[1]);
    int min2 = int.parse(time2[1]);

    if(min2 < min1){
      return "${hours2-hours1-1}小时${min2-min1+60}分";
    }else{
      return "${hours2-hours1}小时${min2-min1}分";
    }

  }catch(e){
    print(e);
  }

  return "";
}

String timeAddResult(String v1, String v2){

  return "";
}