import 'package:permission_handler/permission_handler.dart';

Future<void> requestStoragePermission() async {
  await Permission.manageExternalStorage.request();
}