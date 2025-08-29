// import 'artist_model.dart';
//
// class MusicObClass<P extends Object?> {
//   int? id;
//   String? name;
//   String? photo;
//   String? createdAt;
//   String? updatedAt;
//   int? year;
//   ArtistData? artist;
//
//
//   MusicObClass(
//       {this.id, this.name, this.photo, this.createdAt, this.updatedAt, this.year, this.artist});
//
//   MusicObClass.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     photo = json['photo'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     year = json['year'];
//     json['artist'] != null ? new ArtistData.fromJson(json['artist']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['photo'] = this.photo;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['year'] = this.year;
//     if (this.artist != null) {
//       data['artist'] = this.artist!.toJson();
//     }
//     return data;
//   }
// }