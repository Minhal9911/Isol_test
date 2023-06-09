class UserReq {
  final String name;
  final String email;
  final String mobile;
  final String description;

  UserReq(
      {required this.name,
      required this.email,
      required this.mobile,
      required this.description});

  factory UserReq.fromJson(Map<String, dynamic> json) {
    return UserReq(
        name: json['name'],
        email: json['email'],
        mobile: json['mobile'],
        description: json['description']);
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'mobile': mobile,
        'description': description
      };
}
