import 'dart:convert';

class Video {
  String id;
  String videoName;
  String userId;
  String? video1080pS3Uri;
  String? video720pS3Uri;
  String? video480pS3Uri;
  String? video360pS3Uri;
  String? video240pS3Uri;
  String? video144pS3Uri;
  String videoDescription;
  int videoLikes;
  String videoType;
  String thumbnailS3Uri;
  String? commentsId;

  Video({
    required this.id,
    required this.videoName,
    required this.userId,
    this.video1080pS3Uri,
    this.video720pS3Uri,
    this.video480pS3Uri,
    this.video360pS3Uri,
    this.video240pS3Uri,
    this.video144pS3Uri,
    required this.videoDescription,
    required this.videoLikes,
    required this.videoType,
    required this.thumbnailS3Uri,
    this.commentsId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'video_name': videoName});
    result.addAll({'user_id': userId});
    if (video1080pS3Uri != null) {
      result.addAll({'video_1080p_s3_uri': video1080pS3Uri});
    }
    if (video720pS3Uri != null) {
      result.addAll({'video_720p_s3_uri': video720pS3Uri});
    }
    if (video480pS3Uri != null) {
      result.addAll({'video_480p_s3_uri': video480pS3Uri});
    }
    if (video360pS3Uri != null) {
      result.addAll({'video_360p_s3_uri': video360pS3Uri});
    }
    if (video240pS3Uri != null) {
      result.addAll({'video_240p_s3_uri': video240pS3Uri});
    }
    if (video144pS3Uri != null) {
      result.addAll({'video_144p_s3_uri': video144pS3Uri});
    }
    result.addAll({'video_description': videoDescription});
    result.addAll({'video_likes': videoLikes});
    result.addAll({'video_type': videoType});
    result.addAll({'thumbnail_s3_uri': thumbnailS3Uri});
    if (commentsId != null) {
      result.addAll({'comments_id': commentsId});
    }

    return result;
  }

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      id: map['id'] ?? '',
      videoName: map['video_name'] ?? '',
      userId: map['user_id'] ?? '',
      video1080pS3Uri: map['video_1080p_s3_uri'],
      video720pS3Uri: map['video_720p_s3_uri'],
      video480pS3Uri: map['video_480p_s3_uri'],
      video360pS3Uri: map['video_360p_s3_uri'],
      video240pS3Uri: map['video_240p_s3_uri'],
      video144pS3Uri: map['video_144p_s3_uri'],
      videoDescription: map['video_description'] ?? '',
      videoLikes: map['video_likes']?.toInt() ?? 0,
      videoType: map['video_type'] ?? '',
      thumbnailS3Uri: map['thumbnail_s3_uri'] ?? '',
      commentsId: map['comments_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Video.fromJson(String source) => Video.fromMap(json.decode(source));
}
