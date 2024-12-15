import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/home_main/prensentation/bloc/last_login_details_bloc/last_login_details_bloc.dart';
import 'package:my_app/widget/primary_scaffold.dart';
import 'package:my_app/widget/primary_text.dart';

import '../../../../resource/app_colors.dart';
import '../../../../resource/app_dimension.dart';
import '../../../../widget/custom_tab_bar.dart';
import '../../../../widget/primary_button.dart';
import '../../data/models/last_login_model.dart';

class LastLoginDetailsPage extends StatelessWidget {
  final List<LastLoginModel> lastLoginModelList;

  const LastLoginDetailsPage(this.lastLoginModelList, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LastLoginDetailsBloc()
        ..add(LastLoginDetailsInitEvent(lastLoginModelList: lastLoginModelList)),
      child: BlocBuilder<LastLoginDetailsBloc, LastLoginDetailsState>(
        builder: (context, state) {
          if (state is LastLoginDetailsLoadState) {
            return PrimaryScaffold(
              headerText: 'Last Login',
              isBackArrowEnable: true,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Expanded(
                      child: CustomTabBar(
                        detailsMap: {
                          "Today": state.todayList,
                          "Yesterday": state.yesterdayList,
                          "Other": state.otherList,
                        },
                      ),
                    ),
                    Padding(
                      padding:const EdgeInsets.only(top: 10.0,bottom: 30.0),
                      child: PrimaryButton(
                        btnText: "Save",
                        onTap: () {
                          Navigator.pop(context);
                          },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is LastLoginDetailsErrorState) {
            return Center(
              child: PrimaryText(
                text: state.message,
                color: AppColors.whiteTextColor.withAlpha(150),
                size: AppDimen.textSize22,
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
