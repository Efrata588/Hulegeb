class UserModel {
  final int id;
  final String userName;
  final String email;
  final String password;
  final String phone;
  final Map<String, String> name;

  UserModel({
    required this.id,
    required this.name,
    required this.userName,
    required this.email,
    required this.password,
    required this.phone,
  });

  // for local storage

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    name: json['name'],
    userName: json['userName'],
    email: json['email'],
    password: json['password'],
    phone: json['phone'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'userName': userName,
    'email': email,
    'password': password,
    'phone': phone,
  };
}
