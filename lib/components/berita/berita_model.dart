import 'dart:convert';

class DetailKategoriModel {
  String? id;
  String? name;
  String? description;

  DetailKategoriModel({
    this.id,
    this.name,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "description": description,
    };
  }

  factory DetailKategoriModel.fromMap(Map<String, dynamic> map) {
    return DetailKategoriModel(
      id: map[" id"],
      name: map[" name"],
      description: map[" description"],
    );
  }

  String toJson() => json.encode(toMap());
}

class SpesifikKategoriModel {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;

  SpesifikKategoriModel({
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "author": author,
      "title": title,
      "description": description,
      "url": url,
      "urlToImage": urlToImage,
      "publishedAt": publishedAt,
    };
  }

  factory SpesifikKategoriModel.fromMap(Map<String, dynamic> map) {
    return SpesifikKategoriModel(
      author: map[" author"],
      title: map[" title"],
      description: map[" description"],
      url: map[" url"],
      urlToImage: map[" urlToImage"],
      publishedAt: map[" publishedAt"],
    );
  }

  String toJson() => json.encode(toMap());
}
