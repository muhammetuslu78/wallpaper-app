class WallpaperModel {
  final String? photographer;
  final String? photographerUrl;
  final String? photographerID;
  final SrcModel? srcModel;

  WallpaperModel(
      {this.photographer,
      this.photographerUrl,
      this.photographerID,
      this.srcModel});

  factory WallpaperModel.fromMap(Map<String, dynamic> jsonData) {
    return WallpaperModel(
        photographer: jsonData['photographer'],
        photographerUrl: jsonData['photographerUrl'],
        photographerID: jsonData['photographerID'],
        srcModel: SrcModel.fromMap(jsonData['srcModel']));
  }
}

class SrcModel {
  final String? original;
  final String? small;
  final String? portrait;

  SrcModel({this.original, this.small, this.portrait});

  factory SrcModel.fromMap(Map<String, dynamic> jsonData) {
    return SrcModel(
        original: jsonData['original'],
        small: jsonData['jsonData'],
        portrait: jsonData['jsonData']);
  }
}
