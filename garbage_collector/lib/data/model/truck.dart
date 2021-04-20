import 'dart:convert';

class Truck {
  final String id;
  final String plate;
  final String serial;
  final String alias;

  const Truck({
    this.id,
    this.plate,
    this.serial,
    this.alias,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'plate': plate,
      'serial': serial,
      'alias': alias,
    };
  }

  factory Truck.fromMap(Map<String, dynamic> map) {
    return Truck(
      id: map['id'],
      plate: map['plate'],
      serial: map['serial'],
      alias: map['alias'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Truck.fromJson(String source) => Truck.fromMap(json.decode(source));

  Truck copyWith({
    String id,
    String plate,
    String serial,
    String alias,
  }) {
    return Truck(
      id: id ?? this.id,
      plate: plate ?? this.plate,
      serial: serial ?? this.serial,
      alias: alias ?? this.alias,
    );
  }
}
