class Role {
  String name;

  Role({
    required this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
