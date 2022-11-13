class ImageClass {
  ImageClass({
    required this.Message,
  });
  late final String Message;

  ImageClass.fromJson(Map<String, dynamic> json) {
    Message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Message'] = Message;
    return _data;
  }
}
