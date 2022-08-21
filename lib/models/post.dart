class Post {
  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.publisherName,
    required this.publisherId,
    required this.isPublish,
    required this.isVisibleByUser,
    required this.isVisibleByAgent,
    required this.expirationDate,
    required this.medias,
    required this.cover,
    required this.isDraft,
    required this.entityId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.likesCount,
    required this.commentsCount,
    required this.likes,
    required this.userImage,
  });

  final int id;
  final int userId;
  final String title;
  final String description;
  final String publisherName;
  final int publisherId;
  final bool isPublish;
  final int isVisibleByUser;
  final int isVisibleByAgent;
  final dynamic expirationDate;
  final dynamic medias;
  final String cover;
  final bool isDraft;
  final int entityId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final int likesCount;
  final int commentsCount;
  final List<dynamic> likes;
  final String userImage;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        description: json["description"],
        publisherName: json["publisher_name"],
        publisherId: json["publisher_id"],
        isPublish: json["is_publish"],
        isVisibleByUser: json["is_visible_by_user"],
        isVisibleByAgent: json["is_visible_by_agent"],
        expirationDate: json["expiration_date"],
        medias: json["medias"],
        cover: json["cover"],
        isDraft: json["is_draft"],
        entityId: json["entity_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        likesCount: json["likes_count"],
        commentsCount: json["comments_count"],
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
        userImage: json["user_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "description": description,
        "publisher_name": publisherName,
        "publisher_id": publisherId,
        "is_publish": isPublish,
        "is_visible_by_user": isVisibleByUser,
        "is_visible_by_agent": isVisibleByAgent,
        "expiration_date": expirationDate,
        "medias": medias,
        "cover": cover,
        "is_draft": isDraft,
        "entity_id": entityId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "likes_count": likesCount,
        "comments_count": commentsCount,
        "likes": List<dynamic>.from(likes.map((x) => x)),
        "user_image": userImage,
      };
}