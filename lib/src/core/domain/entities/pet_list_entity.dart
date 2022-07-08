import 'package:equatable/equatable.dart';

import 'package:pet_care_flutter_app/src/core/domain/entities/pet_entity.dart';

class PetListEntity extends Equatable {
  final List<PetEntity> petList;

  const PetListEntity({
    required this.petList,
  });

  @override
  List<Object?> get props => [petList];

  static get empty => const PetListEntity(petList: []);
}
