class TypeTherapyEntity {
  final String id;
  final String name;

  TypeTherapyEntity({
    required this.id,
    required this.name,
  });

  factory TypeTherapyEntity.fromJson(Map<String, dynamic> json) {
    return TypeTherapyEntity(
      id: json["id"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }

  TypeTherapyEntity copyWith({
    String? id,
    String? name,
  }) {
    return TypeTherapyEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() => 'TypeTherapyEntity(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TypeTherapyEntity && other.id == id && other.name == name;
  }
}
