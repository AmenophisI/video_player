import 'package:flutter/material.dart';
import 'dart:io';
import 'file_utils.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:typed_data';

class DownloadListScreen extends StatefulWidget {
  @override
  _DownloadListScreenState createState() => _DownloadListScreenState();
}

class _DownloadListScreenState extends State<DownloadListScreen> {
  List<FileSystemEntity> _files = [];

  @override
  void initState() {
    super.initState();
    _loadFiles();
  }

  Future<void> _loadFiles() async {
    List<FileSystemEntity> files = await getDownloadFiles();
    setState(() {
      _files = files;
    });
  }

  Future<Uint8List?> _generateThumbnail(String videoPath) async {
    final uit8List = await VideoThumbnail.thumbnailData(
        video: videoPath,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 100,
        quality: 100);
    return uit8List;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Downloadフォルダのファイル'),
      ),
      body: ListView.builder(
        itemCount: _files.length,
        itemBuilder: (context, index) {
          FileSystemEntity file = _files[index];
          return FutureBuilder(
              future: _generateThumbnail(file.path),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListTile(
                    leading: CircularProgressIndicator(),
                    title: Text(file.path.split('/').last),
                  );
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return ListTile(
                    leading: Icon(Icons.error),
                    title: Text(file.path.split('/').last),
                  );
                } else {
                  return ListTile(
                    leading: snapshot.data != null
                        ? Image.memory(snapshot.data!)
                        : Icon(Icons.video_file),
                    title: Text(file.path.split('/').last),
                  );
                }
              });
        },
      ),
    );
  }
}
