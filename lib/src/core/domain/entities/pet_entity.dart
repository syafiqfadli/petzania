import 'package:equatable/equatable.dart';

class PetEntity extends Equatable {
  final String? image;
  final String name;
  final int colorValue;

  const PetEntity({
    required this.image,
    required this.name,
    required this.colorValue,
  });

  @override
  List<Object?> get props => [
        image,
        name,
        colorValue,
      ];

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'colorValue': colorValue,
    };
  }

  static get empty => const PetEntity(
        image: null,
        name: '',
        colorValue: 0,
      );
}
