import 'user.dart';

class Post {
  int? id;
  Null? userId;
  String? title;
  String? description;
  String? publisherName;
  int? publisherId;
  bool? isPublish;
  bool? isVisibleByUser;
  bool? isVisibleByAgent;
  String? expirationDate;
  String? medias;
  String? cover;
  bool? isDraft;
  int? entityId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Post(
      {this.id,
      this.userId,
      this.title,
      this.description,
      this.publisherName,
      this.publisherId,
      this.isPublish,
      this.isVisibleByUser,
      this.isVisibleByAgent,
      this.expirationDate,
      this.medias,
      this.cover,
      this.isDraft,
      this.entityId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
    publisherName = json['publisher_name'];
    publisherId = json['publisher_id'];
    isPublish = json['is_publish'];
    isVisibleByUser = json['is_visible_by_user'];
    isVisibleByAgent = json['is_visible_by_agent'];
    expirationDate = json['expiration_date'];
    medias = json['medias'];
    cover = json['cover'];
    isDraft = json['is_draft'];
    entityId = json['entity_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['publisher_name'] = this.publisherName;
    data['publisher_id'] = this.publisherId;
    data['is_publish'] = this.isPublish;
    data['is_visible_by_user'] = this.isVisibleByUser;
    data['is_visible_by_agent'] = this.isVisibleByAgent;
    data['expiration_date'] = this.expirationDate;
    data['medias'] = this.medias;
    data['cover'] = this.cover;
    data['is_draft'] = this.isDraft;
    data['entity_id'] = this.entityId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}