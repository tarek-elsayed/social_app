class PostModel {
  String name;
  String dateTime;
  String text;
  String postImage;
  String image;
  String uId;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.text,
    this.dateTime,
    this.postImage,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
    uId = json['uId'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'postImage': postImage,
      'text': text,
      'image': image,
      'uId': uId,
      'dateTime': dateTime,

    };
  }
}
