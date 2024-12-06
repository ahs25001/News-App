import 'package:equatable/equatable.dart';

class SourceModel extends Equatable{
  SourceModel({
      this.status, 
      this.sources,});

  SourceModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['sources'] != null) {
      sources = [];
      json['sources'].forEach((v) {
        sources?.add(Sources.fromJson(v));
      });
    }
  }
  String? status;
  List<Sources>? sources;

  @override
  // TODO: implement props
  List<Object?> get props => [sources];
}

class Sources extends Equatable{
  Sources({
      this.id, 
      this.name, 
      this.description, 
      this.url, 
      this.category, 
      this.language, 
      this.country,});

  Sources.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    url = json['url'];
    category = json['category'];
    language = json['language'];
    country = json['country'];
  }
  String? id;
  String? name;
  String? description;
  String? url;
  String? category;
  String? language;
  String? country;

  @override
  // TODO: implement props
  List<Object?> get props => [id];


}