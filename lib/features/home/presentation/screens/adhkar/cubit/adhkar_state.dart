part of 'adhkar_cubit.dart';

sealed class AdhkarState extends Equatable {
  const AdhkarState();

  @override
  List<Object> get props => [];
}

final class AdhkarInitial extends AdhkarState {}

final class AdhkarLoading extends AdhkarState {}

final class AdhkarLoaded extends AdhkarState {
  final AzkarSectionEntity adhkar;

  const AdhkarLoaded({required this.adhkar});
}

final class AdhkarError extends AdhkarState {
  final String message;

  const AdhkarError({required this.message});
}

final class AdhkarCategoriesLoaded extends AdhkarState {
  const AdhkarCategoriesLoaded();
}
