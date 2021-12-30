part of 'trending_user_cubit.dart';

class TrendingUserState extends Equatable {
  const TrendingUserState({
    required this.data,
  });

  final List<AppApiTrendingSchemaUser> data;

  @override
  List<Object> get props => [data];
}

class TrendingUserInitial extends TrendingUserState {
  TrendingUserInitial() : super(data: []);

  @override
  List<Object> get props => [];
}
