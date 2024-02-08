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

   // Método para converter um mapa (JSON) em uma instância de User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      level: json['level'],
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      password: json['password'],
    );
  }

  // Método para converter uma instância de User em um mapa (JSON)
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