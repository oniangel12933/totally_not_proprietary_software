part of 'trending_user_cubit.dart';

class TrendingUserState extends Equatable {
  final List<AppApiTrendingSchemaUser> data;

  const TrendingUserState({
    required this.data,
  });

  @override
  List<Object> get props => [data];
}

class TrendingUserInitial extends TrendingUserState {
  TrendingUserInitial() : super(data: []);
}
