import 'package:petzania/src/core/domain/entities/pet_entity.dart';

class PetModel extends PetEntity {
  const PetModel({
    required super.image,
    required super.name,
    required super.breed,
    required super.age,
    required super.colorValue,
  });

  factory PetModel.fromJson(Map<String, dynamic> parseJson) {
    return PetModel(
      image: parseJson['image'],
      name: parseJson['name'],
      breed: parseJson['breed'],
      age: parseJson['age'],
      colorValue: parseJson['colorValue'],
    );
  }

  static List<PetEntity> addToList(List<dynamic> jsonList) {
    List<PetEntity> pets = [];
    for (var pet in jsonList) {
      pets.add(PetModel.fromJson(pet));
    }

    return pets;
  }
}
