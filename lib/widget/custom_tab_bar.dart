import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../resource/app_colors.dart';
import '../../../../../resource/app_dimension.dart';
import '../../../../../widget/primary_text.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../features/home_main/data/models/last_login_model.dart';

class CustomTabBar extends StatelessWidget {
  final Map detailsMap;

  const CustomTabBar({super.key,
    required this.detailsMap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DefaultTabController(
        length: detailsMap.length,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
              TabBar(
              isScrollable: true,
              labelColor: AppColors.whiteTextColor,
              indicatorColor: AppColors.whiteTextColor,
              tabAlignment: TabAlignment.start,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 5,
              unselectedLabelColor: AppColors.whiteTextColor,
              dividerColor: AppColors.bgColor,
              unselectedLabelStyle: const TextStyle(
                  color: AppColors.whiteTextColor,
                  fontSize: AppDimen.textSize16
              ),
              labelStyle: const TextStyle(
                color: AppColors.whiteTextColor,
                fontSize: AppDimen.textSize16
              ),
              tabs: detailsMap.keys.map((keys)=> Tab(text: "$keys")).toList(),
            ),
            Expanded(
              child: TabBarView(
                children: detailsMap.values.map((values)=> _cardView(values)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardView(List<LastLoginModel> lastLoginModelList) {
    return lastLoginModelList.isNotEmpty
        ? ListView.builder(
      itemCount: lastLoginModelList.length,
      itemBuilder: (context, index) {
        LastLoginModel lastLoginModel = lastLoginModelList[index];
        return Stack(
          children: [
            Container(
              width: double.infinity,
              margin:  EdgeInsets.only(top: 30.0,bottom: lastLoginModelList.length - 1 == index ? 40.0 : 0.0),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.buttonColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryText(
                    text: DateFormat('hh : mm a').format(
                        DateTime.fromMillisecondsSinceEpoch(lastLoginModel.dateTime)),
                    color: AppColors.whiteTextColor,
                    size: AppDimen.textSize14,
                  ),
                  const SizedBox(height: 10),
                  PrimaryText(
                    text: "IP: ${lastLoginModel.ipAddress}",
                    color: AppColors.whiteTextColor,
                    size: AppDimen.textSize14,
                  ),
                  const SizedBox(height: 10),
                  PrimaryText(
                    text: lastLoginModel.city.toUpperCase(),
                    color: AppColors.whiteTextColor,
                    size: AppDimen.textSize14,
                  ),
                ],
              ),
            ),
            qrCode(lastLoginModel.generatorNumber),
          ],
        );
      },
    )
        : emptyView();
  }

  Widget qrCode(String randomPaymentCode) {
    return Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: Container(
        margin: EdgeInsets.only(top: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: QrImageView(
          data: randomPaymentCode,
          version: QrVersions.auto,
          size: 110,
          gapless: false,
        ),
      ),
    );
  }

  Widget emptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline, size: 80, color: AppColors.whiteTextColor.withAlpha(150)),
          const SizedBox(height: 20),
          PrimaryText(
            text: 'Last Login Not Found',
            color: AppColors.whiteTextColor.withAlpha(150),
            size: AppDimen.textSize22,
          ),
        ],
      ),
    );
  }
}
