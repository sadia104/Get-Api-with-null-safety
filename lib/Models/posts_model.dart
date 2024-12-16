class PostsModel {
  PostsModel({
    num? userId,
    num? id,
    String? title,
    String? body,
  }) {
    _userId = userId ?? 0; // Default value: 0
    _id = id ?? 0;         // Default value: 0
    _title = title ?? '';  // Default value: empty string
    _body = body ?? '';    // Default value: empty string
  }

  PostsModel.fromJson(dynamic json) {
    _userId = json['userId'] ?? 0; // Handle null values safely
    _id = json['id'] ?? 0;
    _title = json['title'] ?? '';
    _body = json['body'] ?? '';
  }

  num? _userId;
  num? _id;
  String? _title;
  String? _body;

  PostsModel copyWith({
    num? userId,
    num? id,
    String? title,
    String? body,
  }) =>
      PostsModel(
        userId: userId ?? _userId,
        id: id ?? _id,
        title: title ?? _title,
        body: body ?? _body,
      );

  num? get userId => _userId;
  num? get id => _id;
  String? get title => _title;
  String? get body => _body;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['id'] = _id;
    map['title'] = _title;
    map['body'] = _body;
    return map;
  }
}
