import 'dart:io';
import 'dart:convert';

class JSONStorage {
  final String filename;
  final String fileDir;
  File _file;

  JSONStorage(this.filename, this.fileDir) {
    this._file = File('${this.fileDir}/${this.filename}.json');
    if (!this._file.existsSync()) {
      this._file.createSync();
      this._file.writeAsStringSync(json.encode({'content': this.filename}));
    }
  }

  Map getContent() => jsonDecode(this._file.readAsStringSync());

  void appendMap(Map<String, dynamic> content) {
    Map<String, dynamic> jsonFileContent =
        json.decode(this._file.readAsStringSync());
    jsonFileContent.addAll(content);
    this._file.writeAsStringSync(json.encode(jsonFileContent));
  }
}
