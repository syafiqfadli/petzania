import 'package:equatable/equatable.dart';

class PetEntity extends Equatable {
  final String? image;
  final String name;
  final String? breed;
  final int colorValue;

  const PetEntity({
    required this.image,
    required this.name,
    required this.breed,
    required this.colorValue,
  });

  @override
  List<Object?> get props => [
        image,
        name,
        breed,
        colorValue,
      ];

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'breed': breed,
      'colorValue': colorValue,
    };
  }

  static get empty => const PetEntity(
        image: null,
        name: '',
        breed: '',
        colorValue: 0,
      );
}
