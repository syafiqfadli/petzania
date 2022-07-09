part of 'add_pet_cubit.dart';

abstract class AddPetState extends Equatable {
  const AddPetState();

  @override
  List<Object> get props => [];
}

class AddPetInitial extends AddPetState {}

class AddPetSuccessful extends AddPetState {}

class AddPetFailed extends AddPetState {}
