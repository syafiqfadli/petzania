import 'package:equatable/equatable.dart';

class PetEntity extends Equatable {
  final String name;
  final int colorValue;

  const PetEntity({
    required this.name,
    required this.colorValue,
  });

  @override
  List<Object?> get props => [name, colorValue];

  Map<String, dynamic> toJson() {
    return {'name': name, 'colorValue': colorValue};
  }

  static get empty => const PetEntity(name: '', colorValue: 0);
}
