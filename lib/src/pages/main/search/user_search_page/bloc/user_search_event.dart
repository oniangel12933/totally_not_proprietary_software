part of 'user_search_bloc.dart';

class UserSearchEvent extends Equatable {
  final String searchStr;
  const UserSearchEvent({required this.searchStr});

  @override
  List<Object?> get props => [searchStr];
}
