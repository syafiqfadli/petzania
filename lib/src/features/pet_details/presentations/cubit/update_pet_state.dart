part of 'update_pet_cubit.dart';

abstract class UpdatePetState extends Equatable {
  const UpdatePetState();

  @override
  List<Object> get props => [];
}

class UpdatePetInitial extends UpdatePetState {}

class UpdatePetSuccessful extends UpdatePetState {}

class UpdatePetFailed extends UpdatePetState {}
