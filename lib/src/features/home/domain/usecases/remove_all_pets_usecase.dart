import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/home_repo.dart';

class RemoveAllPetsUseCase implements UseCase<void, NoParams> {
  final HomeRepo homeRepo;

  RemoveAllPetsUseCase({
    required this.homeRepo,
  });

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await homeRepo.removeAllPets();
  }
}
