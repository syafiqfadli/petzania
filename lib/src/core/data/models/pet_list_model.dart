import 'package:pet_care_flutter_app/src/core/data/models/pet_model.dart';
import 'package:pet_care_flutter_app/src/core/domain/entities/pet_list_entity.dart';

class PetListModel extends PetListEntity {
  const PetListModel({required super.petList});

  factory PetListModel.create(
    List<dynamic> parseList,
  ) {
    final pets = PetModel.fromList(parseList);

    return PetListModel(petList: pets);
  }
}
