import 'package:pet_care_flutter_app/src/core/domain/entities/pet_entity.dart';

class PetModel extends PetEntity {
  const PetModel({required super.name, required super.colorValue});

  factory PetModel.fromJson(Map<String, dynamic> parseJson) {
    return PetModel(
      name: parseJson['name'],
      colorValue: parseJson['colorValue'],
    );
  }

  static List<PetModel> fromList(List<dynamic> jsonList) {
    List<PetModel> pets = [];
    for (var pet in jsonList) {
      pets.add(PetModel.fromJson(pet));
    }

    return pets;
  }
}
