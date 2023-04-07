import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/pet_entity.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/home_repo.dart';

class GetPetListUseCase implements UseCase<List<PetEntity>, NoParams> {
  final HomeRepo homeRepo;

  GetPetListUseCase({
    required this.homeRepo,
  });

  @override
  Future<Either<Failure, List<PetEntity>>> call(NoParams params) async {
    return await homeRepo.getPetList();
  }
}
