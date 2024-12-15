import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/home_main/prensentation/bloc/plugin_view_bloc/plugin_view_bloc.dart';
import 'package:my_app/widget/primary_button.dart';
import 'package:my_app/widget/primary_scaffold.dart';
import 'package:my_app/widget/primary_text.dart';
import 'package:my_app/resource/app_colors.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../resource/app_dimension.dart';
import '../../../../resource/app_font.dart';

import '../../../../utiles/formatted_date_time.dart';
import '../../../../widget/custom_paint.dart';
import '../../data/models/last_login_model.dart';
import '../../data/repositories/plugin_view_repository.dart';
import 'last_login_details_page.dart';

class PluginViewPage extends StatelessWidget {
  const PluginViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PluginViewBloc()..add(PluginViewFetchIPEvent()),
      child: BlocConsumer<PluginViewBloc, PluginViewState>(
        listener: (context, state) {
          if (state is PluginViewDataCreateState) {
            final moneyViewBloc = context.read<PluginViewBloc>();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LastLoginDetailsPage((state).lastLoginModelList),
              ),
            ).then((_) {
              moneyViewBloc.add(PluginViewFetchIPEvent());
            });
          }
        },
        builder: (context, state) {
          return PrimaryScaffold(
            headerText: "PLUGIN",
            body: _showBodyContent(context, state),
          );
        },
      ),
    );
  }

  Widget _showBodyContent(BuildContext context, PluginViewState state) {
    if (state is PluginViewLoadingState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is PluginViewDataFetchState) {
      return _buildPaymentQRPage(state, context);
    } else if (state is PluginViewErrorState) {
      return Center(
        child: PrimaryText(
          text: state.errorMessage,
          color: AppColors.whiteTextColor.withAlpha(150),
          size: AppDimen.textSize22,
        ),
      );
    } else {
      return const Center(
        child: Text("Unexpected Error"),
      );
    }
  }

  Widget _buildPaymentQRPage(PluginViewState state, BuildContext context) {
    String randomPaymentCode = _generateRandomPaymentCodeString();
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              const SizedBox(height: 100),
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 220,
                      decoration: BoxDecoration(
                        color: AppColors.buttonColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipPath(
                        clipper: BottomRightTriangleClipper(),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -80,
                      left: 0,
                      right: 0,
                      child: qrCode(randomPaymentCode),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30,),
        PrimaryButtonLight(
          btnText: (state as PluginViewDataFetchState).lastLoginModelList.isNotEmpty
              ? "Last Login at ${FormattedDateTime.formatDate((state).lastLoginModelList.first.dateTime)}"
              : "Last Login Not Found",
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => LastLoginDetailsPage((state).lastLoginModelList)));
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: PrimaryButton(
            btnText: "Save",
            onTap: () {
              LastLoginModel lastLoginModel = LastLoginModel(
                  id: DateTime.now().microsecond.toInt(),
                  dateTime: DateTime.now().millisecondsSinceEpoch,
                  userId: PluginViewRepository.getCurrentUserId(),
                  city: (state).city,
                  ipAddress:(state).ipAddress,
                  generatorNumber: randomPaymentCode);
              context.read<PluginViewBloc>().add(PluginViewSaveEvent(lastLoginModel));
            },
          ),
        ),
      ],
    );
  }


  Widget qrCode(String randomPaymentCode) {
    return SizedBox(
      height: 280,
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: QrImageView(
                data: randomPaymentCode,
                version: QrVersions.auto,
                size: 130,
                gapless: false,
              ),
            ),
          ),
          const SizedBox(height: 30),
          PrimaryText(
            text: "Generated number",
            color: AppColors.whiteTextColor,
            size: AppDimen.textSize20,
          ),
          const Spacer(),
          PrimaryText(
            text: randomPaymentCode,
            color: AppColors.whiteTextColor,
            size: AppDimen.textSize26,
            weight: AppFont.semiBold,
          ),
        ],
      ),
    );
  }

  String _generateRandomPaymentCodeString() {
    final random = Random();
    return (random.nextInt(900000) + 100000).toString();
  }
}


