class EntityModel {
  int? id;
  String? name;
  String? description;
  String? logo;
  String? photourl;

  EntityModel({
    this.id,
    this.name,
    this.description,
    this.logo,
    this.photourl
  });


  // function to convert json data to EntityModel model
  factory EntityModel.fromJson(Map<String, dynamic> json){
    return EntityModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      logo: json['logo'],
      photourl: json['photo_url']
    );
  }
}