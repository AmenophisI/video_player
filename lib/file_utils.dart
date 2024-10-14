import 'dart:io';
const List<String> videoExtensions = ['mp4', 'mkv', 'avi', 'mov', 'wmv', 'flv', 'webm'];

Future<List<FileSystemEntity>> getDownloadFiles() async {
  Directory? downloadDir;

  if (Platform.isAndroid) {
    downloadDir = Directory('/storage/emulated/0/Download');
  }

  if (downloadDir != null && await downloadDir.exists()) {
    List<FileSystemEntity> allFiles = downloadDir.listSync();
    List<FileSystemEntity> videoFiles = allFiles.where((file) {
      if (file is File) {
        String extension = file.path.split('.').last.toLowerCase();
        return videoExtensions.contains(extension);
      }
      return false;
    }).toList();

    return videoFiles;
  }

  return [];
}