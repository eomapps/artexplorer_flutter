import 'package:artexplorer/theme/app_colors.dart';
import 'package:artexplorer/theme/app_text_styles.dart';
import 'package:artexplorer/utils/app_strings.dart';
import 'package:artexplorer/widgets/linen_panel.dart';
import 'package:flutter/material.dart';

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
          Container(width: double.infinity, height: double.infinity),
          SafeArea(
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
                LinenPanel(child: Text('test the panel')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
