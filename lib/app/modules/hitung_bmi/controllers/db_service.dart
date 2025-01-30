import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseService extends GetxService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  Future<String> fetchData() async {
    // DataSnapshot snapshot = await _database.child('your_node_path').once();
    // return snapshot.value.toString();
    print("tes");
    return "oke";
  }
}
