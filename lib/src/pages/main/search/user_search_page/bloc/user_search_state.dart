part of 'user_search_bloc.dart';

class UserSearchState extends Equatable {
  final List<AppApiTrendingSchemaPortfolio> data;

  const UserSearchState({required this.data});

  @override
  List<Object> get props => [data];
}

class UserSearchStateInitial extends UserSearchState {
  UserSearchStateInitial() : super(data: []);
}
