class User {
  String firstname;
  String lastname;
  String email;
  int age;
  int height;
  int weight;
  int? avatarId;
  List<dynamic> stats;

  User.blank()
      : firstname = 'F',
        lastname = 'T',
        email = '',
        age = 0,
        height = 0,
        weight = 0,
        stats = [];

  User({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.age,
    required this.height,
    required this.weight,
    required this.stats,
    required this.avatarId,
  });

  User.fromJson(Map<String, dynamic> json)
      : this(
          firstname: json['firstname']!,
          lastname: json['lastname']!,
          email: json['email']!,
          age: json['age']!,
          height: json['height'],
          weight: json['weight'],
          stats: json['edges']['stats'],
          avatarId: json['edges']?['avatar']?['id']!,
        );
}
