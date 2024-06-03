
// import 'package:flutter/gestures.dart';
// import 'package:BYM/utils/Device.dart';
// // import 'package:BYM/sqflite.dart';
// import 'package:path/path.dart';

// class BYDBHealper{
//   final int _version = 4;//版本号
//   final String _databaseName = 'BENY.db';//数据库名称
//   static const String devicesTable = 'Devices';//表名

//   static const String deviceId = 'deviceId';//primary key
//   static const String remark = 'remark';
//   static const String account = 'account';
//   static const String currentChooseGun = 'currentChooseGun';
//   static const String pileversion = 'pileversion';
//   static const String connectType = 'connectType';
//   static const String deviceType = 'deviceType';
//   static const String homewifissid = 'homewifissid';
//   static const String pass = 'pass';
//   static const String software = 'software';
//   static const String hardware = 'hardware';
//   static const String binData = 'binData'; // 固件



//   static BYDBHealper? _instance;
//   static BYDBHealper getInstance() => _instance ??= BYDBHealper();

//   static Database? _database;
//   Future<Database> get getDatabase async => _database ??= await _initSQl();


//   ///初始化数据库
//   Future<Database> _initSQl() async{
//     var dbPath = await getDatabasesPath();
//     var path = join(dbPath,_databaseName);
//     return await openDatabase(path,version: _version,onCreate: _onCreate);
//   }




//   ///创建表
//   Future _onCreate(Database db,int version) async{
//     String createSQL =
//       '''
//       CREATE TABLE $devicesTable(
//       $deviceId integer PRIMARY KEY autoincrement,        
//       $remark TEXT,
//       $account TEXT,
//       $currentChooseGun TEXT,
//       $pileversion TEXT,
//       $connectType TEXT,
//       $deviceType TEXT
//       $homewifissid TEXT,
//       $pass TEXT,
//       $software  TEXT,
//       $hardware  TEXT,
//       $binData TEXT
//       )
//       ''';

//     await db.execute(createSQL);
//   }





  
//   ///查询所有数据
//   Future<List<Device>> queryAll() async {
//     Database db = await BYDBHealper.getInstance().getDatabase;
//     var result = await db.query(BYDBHealper.devicesTable);
//     if (result.isNotEmpty) {
//       return result.map((e) => Device.fromJson(e)).toList();
//     } else {
//       return [];
//     }
//   }



//   Future<bool> insert(Device bean) async{
//     Database db = await BYDBHealper.getInstance().getDatabase;
//     int reuslt =  await db.insert(BYDBHealper.devicesTable, bean.toJson());
//     if(reuslt == 0){
//       return false;
//     }else{
//       return true;
//     }

//   }



//   Future<void> updateDevice(Device device) async {
//     Database db = await BYDBHealper.getInstance().getDatabase;
    
//     await db.update(
//       BYDBHealper.devicesTable,
//       device.toJson(),
//       where: "${BYDBHealper.account} = ?",
//       whereArgs: [device.account],
//     );
//   }


//   ///删除数据
//   Future<int> delete(String account) async{
//     Database db = await BYDBHealper.getInstance().getDatabase;
//     return await db.delete(BYDBHealper.devicesTable,where:'${BYDBHealper.account} = ?',whereArgs:[account]);
//   }







// }