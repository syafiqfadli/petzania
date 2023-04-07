import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class PetDetailsRepo {
  Future<Either<Failure, void>> updatePet(
    int index,
    String name,
    String breed,
    String image,
    int age,
    int colorValue,
  );
}
