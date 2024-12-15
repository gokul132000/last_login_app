import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/last_login_model.dart';
import '../../../data/repositories/plugin_view_repository.dart';
part 'plgin_view_event.dart';
part 'plugin_view_state.dart';

class PluginViewBloc extends Bloc<PluginViewEvent, PluginViewState> {
  PluginViewBloc() : super(PluginViewInitialState()) {
    on<PluginViewFetchIPEvent>(_onFetchIPAndCityEvent);
    on<PluginViewSaveEvent>(createData);
  }


  Future<void> _onFetchIPAndCityEvent(PluginViewFetchIPEvent event, Emitter<PluginViewState> emit) async {
    emit(PluginViewLoadingState());
    final lastLoginModelList = await PluginViewRepository.getLastLoginModelList();
    final ipInfoResult = await PluginViewRepository.getIpInfo();
    emit(PluginViewDataFetchState(ipAddress: ipInfoResult["ipAddress"], city: ipInfoResult["city"],lastLoginModelList: lastLoginModelList));
  }

  Future<void> createData(PluginViewSaveEvent event, Emitter<PluginViewState> emit,) async {
    emit(PluginViewLoadingState());
    await PluginViewRepository.postLastModelData(data: event.moneyVieModel.toMap());
    final result = await PluginViewRepository.getLastLoginModelList();
    emit(PluginViewDataCreateState(result));
  }

}


