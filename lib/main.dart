import 'package:flutter/material.dart';
import 'download_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ダウンロードフォルダ一覧',
      theme: ThemeData.dark(),
      home: DownloadListScreen(),
    );
  }
}
