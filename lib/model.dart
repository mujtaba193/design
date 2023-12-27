
class Test {
  late String title;
  late String body;
  Test(this.title, this.body);
  Test.fromjson(Map<String, dynamic> json) {
    title = json["title"];
    body = json["body"];
  }
}

class User {
  final String username;
  final String email;
  final String urlAvatar;
  User(this.username, this.email, this.urlAvatar);
}
