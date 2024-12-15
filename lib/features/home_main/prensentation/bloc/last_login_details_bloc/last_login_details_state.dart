part of 'last_login_details_bloc.dart';

abstract class LastLoginDetailsState {}

class LastLoginDetailsInitialState extends LastLoginDetailsState {}

class LastLoginDetailsLoadState extends LastLoginDetailsState {
  final List<LastLoginModel> todayList;
  final List<LastLoginModel> yesterdayList;
  final List<LastLoginModel> otherList;

  LastLoginDetailsLoadState({
    required this.todayList,
    required this.yesterdayList,
    required this.otherList,
  });
}

class LastLoginDetailsErrorState extends LastLoginDetailsState {
  final String message;
  LastLoginDetailsErrorState({required this.message});
}
