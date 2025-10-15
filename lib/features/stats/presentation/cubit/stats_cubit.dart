import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stats_state.dart';

class StatsCubit extends Cubit<StatsState> {
  StatsCubit() : super(StatsInitial());
}
