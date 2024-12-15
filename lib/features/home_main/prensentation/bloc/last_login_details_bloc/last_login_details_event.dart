part of 'last_login_details_bloc.dart';

abstract class LastLoginDetailsEvent {}

class LastLoginDetailsInitEvent extends LastLoginDetailsEvent {
  final List<LastLoginModel> lastLoginModelList;

  LastLoginDetailsInitEvent({required this.lastLoginModelList});
}
