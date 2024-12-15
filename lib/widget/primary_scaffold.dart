import 'package:flutter/material.dart';
import 'package:my_app/core/repositories/app_repository.dart';
import 'package:my_app/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:my_app/resource/app_colors.dart';
import 'package:my_app/resource/app_dimension.dart';
import 'package:my_app/widget/primary_text.dart';

class PrimaryScaffold extends StatelessWidget {
  final Widget? body;
  final Color backgroundColor;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final PreferredSizeWidget? appBarBottom;
  final List<Widget>? actions;
  final String? headerText;
  final bool isLogoutEnable;
  final bool isBackArrowEnable;

  const PrimaryScaffold({
    super.key,
    this.body,
    this.backgroundColor = AppColors.bgColor,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.appBarBottom,
    this.actions,
    this.headerText,
    this.isLogoutEnable = true,
    this.isBackArrowEnable = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: floatingActionButtonLocation,
        floatingActionButton: floatingActionButton,
        backgroundColor: AppColors.primaryColor,
        body: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  _buildContentContainer(),
                  if (headerText != null) _buildHeader(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isBackArrowEnable ? TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: PrimaryText(
              text: "<",
              color: AppColors.whiteTextColor,
              size: AppDimen.textSize24,
            ),
          ) : const SizedBox.shrink(),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      width: 120,
      height: 100,
      decoration: const BoxDecoration(
        color: AppColors.roundBgColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(100.0)),
      ),
      alignment: Alignment.center,
      child: isLogoutEnable ? GestureDetector(
        onTap: () => _logout(context),
        child: PrimaryText(
          text: "Logout",
          size: AppDimen.textSize16,
          color: AppColors.whiteTextColor,
        ),
      ) : const SizedBox.shrink(),
    );
  }

  Widget _buildContentContainer() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      ),
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      child: body ?? const SizedBox.shrink(),
    );
  }

  Widget _buildHeader() {
    return Positioned(
      top: -20,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.bodyHeaderBgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          child: PrimaryText(
            text: headerText!,
            color: AppColors.whiteTextColor,
            size: AppDimen.textSize22,
          ),
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    AppRepository().logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
          (route) => false,
    );
  }
}
