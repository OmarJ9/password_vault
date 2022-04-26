class PassModel {
  final String id;
  final String icon;
  final String website;
  final String password;
  final String category;

  PassModel(
      {required this.icon,
      required this.website,
      required this.password,
      required this.category,
      required this.id});

  factory PassModel.fromJson(Map<String, dynamic> json, String id) {
    return PassModel(
      id: id,
      icon: json['icon'],
      website: json['website'],
      password: json['password'],
      category: json['category'],
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'icon': icon,
      'website': website,
      'password': password,
      'category': category,
    };
  }
}
