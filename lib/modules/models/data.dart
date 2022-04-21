import 'dart:convert';

//class resposanvel pela tratativa dos atributos vindo dos personagens
class DataPerson {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String origin;
  final String originUrl;
  final String location;
  final String locationUrl;
  final String image;
  final List episode;
  final String url;
  final String created;

  DataPerson(
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.originUrl,
    this.location,
    this.locationUrl,
    this.image,
    this.episode,
    this.url,
    this.created,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'origin': origin,
      'originUrl': originUrl,
      'location': location,
      'locationUrl': locationUrl,
      'image': image,
      'episode': episode,
      'url': url,
      'created': created,
    };
  }

  factory DataPerson.fromMap(Map<String, dynamic> map) {
    return DataPerson(
      map['id']?.toInt() ?? 0,
      map['name'] ?? '',
      map['status'] ?? '',
      map['species'] ?? '',
      map['type'] ?? '',
      map['gender'] ?? '',
      map['origin']['name'] ?? '',
      map['origin']['url'] ?? '',
      map['location']['name'] ?? '',
      map['location']['url'] ?? '',
      map['image'] ?? '',
      List.from(map['episode']),
      map['url'] ?? '',
      map['created'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DataPerson.fromJson(String source) =>
      DataPerson.fromMap(json.decode(source));
}
