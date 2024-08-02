
class UserModel {
  final String id;
  final String firstname;
  final String lastname;
  final String profile;
  final String mobileno;
  final String intrestedsports;
  final String level;
  final int age;
  final bool isVerified;

  UserModel({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.profile,
    required this.mobileno,
    required this.intrestedsports,
    required this.level,
    required this.age,
    required this.isVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      profile: json['profile'] ?? '',
      mobileno: json['mobileno'] ?? '',
      intrestedsports: json['intrestedsports'] ?? '',
      level: json['level'] ?? '',
      age: json['age'] ?? 0,
      isVerified: json['isVerified'] ?? false,
    );
  }
}