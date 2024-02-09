class User {
  String level;
  String name;
  String surname;
  String email;
  String password;
  
  User(
    {
    required this.level, 
    required this.name, 
    required this.surname,
    required this.email,
    required this.password
    }
  );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      level: json['level'],
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'name': name,
      'surname': surname,
      'email': email,
      'password': password,
    };
  }
}