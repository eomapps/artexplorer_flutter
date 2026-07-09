import 'package:artexplorer/theme/app_colors.dart';
import 'package:artexplorer/theme/app_text_styles.dart';
import 'package:artexplorer/utils/app_strings.dart';
import 'package:artexplorer/widgets/linen_panel.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _showEmailForm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFd4c9b8),
                  Color(0xFFc4b5a0),
                  Color(0xFFb8a690),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Opacity(
            opacity: 0.04,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/textures/noise.png'),
                  repeat: ImageRepeat.repeat,
                ),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 32.0, left: 32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.appEyebrowLabel.toUpperCase(),
                          style: AppTextStyles.kicker.copyWith(
                            color: AppColors.inkMuted,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          AppStrings.appTitle,
                          style: AppTextStyles.wordmark.copyWith(
                            color: AppColors.ink,
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          width: 40,
                          height: 2,
                          color: AppColors.accent,
                        ),
                        SizedBox(height: 16),
                        Text(
                          AppStrings.tagline,
                          style: AppTextStyles.serifItalicMuted.copyWith(
                            color: AppColors.inkMuted,
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
                LinenPanel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton.icon(
                        icon: Platform.isIOS
                            ? Image.asset(
                                'assets/buttons/g_logo_ios.png',
                                width: 18,
                                height: 18,
                              )
                            : Image.asset(
                                'assets/buttons/g_logo_android.png',
                                width: 18,
                                height: 18,
                              ),
                        onPressed: () {},
                        label: Text(
                          AppStrings.continueWithGoogle.toUpperCase(),
                        ),
                        style: ButtonStyle(
                          textStyle: WidgetStatePropertyAll(
                            AppTextStyles.buttonLabel,
                          ),
                          elevation: const WidgetStatePropertyAll(0),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          padding: const WidgetStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 16),
                          ),
                          backgroundColor: const WidgetStatePropertyAll(
                            AppColors.accent,
                          ),
                          foregroundColor: const WidgetStatePropertyAll(
                            AppColors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      OutlinedButton(
                        style: ButtonStyle(
                          textStyle: WidgetStatePropertyAll(
                            AppTextStyles.buttonLabel.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          elevation: const WidgetStatePropertyAll(0),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          padding: const WidgetStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 14),
                          ),
                          foregroundColor: const WidgetStatePropertyAll(
                            AppColors.inkMuted,
                          ),
                          side: WidgetStatePropertyAll(
                            BorderSide(color: AppColors.divider),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(AppStrings.signInWithEmail.toUpperCase()),
                      ),
                      SizedBox(height: 12),
                      Text(
                        AppStrings.youAcceptTOS,
                        style: AppTextStyles.kicker.copyWith(
                          color: AppColors.inkFaint,
                          letterSpacing: 0.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
