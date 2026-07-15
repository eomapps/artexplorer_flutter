import 'package:artexplorer/blocs/auth/auth_event.dart';
import 'package:artexplorer/theme/app_colors.dart';
import 'package:artexplorer/theme/app_text_styles.dart';
import 'package:artexplorer/utils/app_strings.dart';
import 'package:artexplorer/widgets/linen_panel.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:artexplorer/blocs/auth/auth_bloc.dart';
import 'package:artexplorer/blocs/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _showEmailForm = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          debugPrint(state.error);
          final snackBar = SnackBar(content: Text(state.error));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
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
                      child: !_showEmailForm
                          ? buildSignInOptions(isLoading)
                          : buildEnterEmailUI(isLoading),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildSignInOptions(bool isLoading) {
    return Column(
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
          onPressed: () {
            context.read<AuthBloc>().add(SignInWithGoogle());
          },
          label: Text(AppStrings.continueWithGoogle.toUpperCase()),
          style: ButtonStyle(
            textStyle: WidgetStatePropertyAll(AppTextStyles.buttonLabel),
            elevation: const WidgetStatePropertyAll(0),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 16),
            ),
            backgroundColor: const WidgetStatePropertyAll(AppColors.accent),
            foregroundColor: const WidgetStatePropertyAll(AppColors.white),
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
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 14),
            ),
            foregroundColor: const WidgetStatePropertyAll(AppColors.inkMuted),
            side: WidgetStatePropertyAll(BorderSide(color: AppColors.divider)),
          ),
          onPressed: () {
            setState(() {
              _showEmailForm = true;
            });
          },
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
    );
  }

  Widget buildEnterEmailUI(bool isLoading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppStrings.email.toUpperCase(),
          style: AppTextStyles.kicker.copyWith(
            letterSpacing: 1.5,
            color: AppColors.inkMuted,
          ),
        ),
        SizedBox(height: 6),
        TextField(
          controller: emailController,
          style: AppTextStyles.serifBody,
          decoration: InputDecoration(
            hint: Text(AppStrings.emailExample),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(width: 1, color: AppColors.divider),
            ),
          ),
        ),
        SizedBox(height: 6),
        Text(
          AppStrings.password.toUpperCase(),
          style: AppTextStyles.kicker.copyWith(
            letterSpacing: 1.5,
            color: AppColors.inkMuted,
          ),
        ),
        SizedBox(height: 6),
        TextField(
          controller: passwordController,
          style: AppTextStyles.serifBody,
          decoration: InputDecoration(
            hint: Text(AppStrings.passwordExample),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(width: 1, color: AppColors.divider),
            ),
          ),
          obscureText: true,
        ),
        SizedBox(height: 10),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.accent),
            foregroundColor: WidgetStatePropertyAll(AppColors.white),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 16),
            ),
          ),
          onPressed: () {
            context.read<AuthBloc>().add(
              SignInWithEmail(
                email: emailController.text,
                password: passwordController.text,
              ),
            );
          },
          child: Text(
            AppStrings.signInPrompt.toUpperCase(),
            style: AppTextStyles.buttonLabel,
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
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 14),
            ),
            foregroundColor: const WidgetStatePropertyAll(AppColors.inkMuted),
            side: WidgetStatePropertyAll(BorderSide(color: AppColors.divider)),
          ),
          onPressed: () {
            setState(() {
              _showEmailForm = false;
            });
          },
          child: Text(AppStrings.back.toUpperCase()),
        ),
      ],
    );
  }
}
