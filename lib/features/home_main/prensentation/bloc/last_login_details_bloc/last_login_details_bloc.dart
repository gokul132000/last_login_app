import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/last_login_model.dart';
part 'last_login_details_event.dart';
part 'last_login_details_state.dart';


class LastLoginDetailsBloc extends Bloc<LastLoginDetailsEvent, LastLoginDetailsState> {
  LastLoginDetailsBloc() : super(LastLoginDetailsInitialState()) {
    on<LastLoginDetailsInitEvent>((event, emit) {
      try {
        final List<LastLoginModel> detailViewList = event.lastLoginModelList;
        DateTime now = DateTime.now();
        DateTime todayStart = DateTime(now.year, now.month, now.day);
        DateTime yesterdayStart = todayStart.subtract(const Duration(days: 1));
        DateTime twoDaysAgoStart = todayStart.subtract(const Duration(days: 2));

        emit(LastLoginDetailsLoadState(
          todayList: detailViewList.where((ts) =>
          ts.dateTime >= todayStart.millisecondsSinceEpoch &&
              ts.dateTime < todayStart.add(const Duration(days: 1)).millisecondsSinceEpoch).toList(),
          yesterdayList: detailViewList.where((ts) =>
          ts.dateTime >= yesterdayStart.millisecondsSinceEpoch &&
              ts.dateTime < todayStart.millisecondsSinceEpoch).toList(),
          otherList: detailViewList.where((ts) =>
          ts.dateTime < twoDaysAgoStart.millisecondsSinceEpoch).toList(),
        ));
      } catch (e) {
        emit(LastLoginDetailsErrorState(message: e.toString()));
      }
    });
  }
}
