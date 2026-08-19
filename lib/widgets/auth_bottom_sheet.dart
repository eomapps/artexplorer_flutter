import 'dart:io';

import 'package:artexplorer/blocs/auth/auth_bloc.dart';
import 'package:artexplorer/blocs/auth/auth_event.dart';
import 'package:artexplorer/blocs/auth/auth_state.dart';
import 'package:artexplorer/blocs/collection/collection_bloc.dart';
import 'package:artexplorer/blocs/collection/collection_event.dart';
import 'package:artexplorer/models/artwork.dart';
import 'package:artexplorer/theme/app_colors.dart';
import 'package:artexplorer/theme/app_text_styles.dart';
import 'package:artexplorer/utils/app_strings.dart';
import 'package:artexplorer/widgets/linen_panel.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthDisplayState { signInOptions, enterEmail, createAccount }

class AuthBottomSheet extends StatefulWidget {
  final Artwork? artwork;
  const AuthBottomSheet({super.key, this.artwork});

  @override
  State<AuthBottomSheet> createState() => _AuthBottomSheet();
}

class _AuthBottomSheet extends State<AuthBottomSheet> {
  AuthDisplayState displayState = AuthDisplayState.signInOptions;
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
          _showSnackbar(friendlyMessage(state.error));
        }
        if (state is AuthPasswordReset) {
          _showSnackbar(AppStrings.checkEmail);
        }
        if (state is AuthAuthenticated) {
          if (widget.artwork != null) {
            context.read<CollectionBloc>().add(
              SaveArtwork(artwork: widget.artwork!),
            );
          }
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return LinenPanel(child: getLinenPanelWidget());
      },
    );
  }

  Widget getLinenPanelWidget() {
    return switch (displayState) {
      AuthDisplayState.signInOptions => buildSignInOptions(),
      AuthDisplayState.enterEmail => buildEnterEmailUI(),
      AuthDisplayState.createAccount => buildCreateEmailSignInUI(),
    };
  }

  Widget buildSignInOptions() {
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
              displayState = AuthDisplayState.enterEmail;
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

  Widget buildEnterEmailUI() {
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(width: 1, color: AppColors.divider),
            ),
          ),
          obscureText: true,
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            if (EmailValidator.validate(emailController.text.trim())) {
              context.read<AuthBloc>().add(
                ResetPassword(email: emailController.text.trim()),
              );
            } else {
              _showSnackbar(AppStrings.enterValidEmailPrompt);
            }
          },
          child: Text(
            AppStrings.forgotPasswordPrompt,
            style: AppTextStyles.kicker.copyWith(
              letterSpacing: 1.5,
              color: AppColors.inkMuted,
            ),
          ),
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
            if (EmailValidator.validate(emailController.text.trim())) {
              if (passwordController.text.trim().isNotEmpty) {
                context.read<AuthBloc>().add(
                  SignInWithEmail(
                    email: emailController.text.trim(),
                    password: passwordController.text,
                  ),
                );
              } else {
                _showSnackbar(AppStrings.enterPasswordPrompt);
              }
            } else {
              _showSnackbar(AppStrings.enterValidEmailPrompt);
            }
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
              displayState = AuthDisplayState.signInOptions;
              emailController.clear();
              passwordController.clear();
            });
          },
          child: Text(AppStrings.back.toUpperCase()),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            setState(() {
              displayState = AuthDisplayState.createAccount;
              emailController.clear();
              passwordController.clear();
            });
          },
          child: Center(
            child: Text(
              AppStrings.signUpPrompt,
              style: AppTextStyles.kicker.copyWith(
                letterSpacing: 1.5,
                color: AppColors.inkMuted,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCreateEmailSignInUI() {
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
            if (EmailValidator.validate(emailController.text.trim())) {
              if (passwordController.text.trim().length >= 8) {
                context.read<AuthBloc>().add(
                  CreateLoginWithEmail(
                    email: emailController.text.trim(),
                    password: passwordController.text,
                  ),
                );
              } else {
                _showSnackbar(AppStrings.checkPasswordLength);
              }
            } else {
              _showSnackbar(AppStrings.enterValidEmailPrompt);
            }
          },
          child: Text(
            AppStrings.signUp.toUpperCase(),
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
              displayState = AuthDisplayState.enterEmail;
              emailController.clear();
              passwordController.clear();
            });
          },
          child: Text(AppStrings.back.toUpperCase()),
        ),
      ],
    );
  }

  void _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String friendlyMessage(FirebaseAuthException e) {
    switch (e.code) {
      case AppStrings.caseInvalidCredential:
        return AppStrings.incorrectEmail;
      case AppStrings.caseUserNotFound:
        return AppStrings.noAccountFound;
      case AppStrings.caseEmailAlreadyInUse:
        return AppStrings.accountAlreadyExists;
      case AppStrings.caseTooManyRequests:
        return AppStrings.tooManyAttempts;
      default:
        return AppStrings.defaultErrorMessage;
    }
  }
}
