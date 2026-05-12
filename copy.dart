import 'dart:io';

void copy(String arch, String name) {
  final libsDir = Directory(
    '${Directory.current.path}/buildscripts/prefix/$arch/lib',
  );
  final outputDir = Directory('${Directory.current.path}/output/$name');
  if (outputDir.existsSync()) {
    outputDir.deleteSync(recursive: true);
  }
  outputDir.createSync(recursive: true);
  for (final file in libsDir.listSync()) {
    if (file is File && file.path.endsWith('.so')) {
      final name = file.path.split('/').last;
      file.copySync('${outputDir.path}/$name');
    }
  }
}

void main(List<String> args) async {
  copy('arm64', 'arm64-v8a');
  copy('armv7l', 'armeabi-v7a');
  copy('x86_64', 'x86_64');
}
