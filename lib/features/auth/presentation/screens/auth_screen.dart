import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_page_route.dart';
import '../../../home/presentation/screens/home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  Timer? _countdown;
  int _secondsRemaining = 300;
  bool _isOtpView = false;
  bool _isVerifying = false;
  String? _errorMessage;

  @override
  void dispose() {
    _countdown?.cancel();
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _requestCode() {
    if (_phoneController.text.trim().length < 7) {
      setState(() => _errorMessage = 'Enter a valid phone number to continue.');
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() {
      _isOtpView = true;
      _errorMessage = null;
      _secondsRemaining = 300;
      _codeController.clear();
    });
    _startCountdown();
  }

  void _startCountdown() {
    _countdown?.cancel();
    _countdown = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_secondsRemaining <= 1) {
        timer.cancel();
        setState(() => _secondsRemaining = 0);
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  Future<void> _verifyCode() async {
    if (_codeController.text.length != 4) {
      setState(() => _errorMessage = 'Please enter the 4-digit code.');
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() {
      _isVerifying = true;
      _errorMessage = null;
    });
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    _countdown?.cancel();
    Navigator.of(context).pushAndRemoveUntil<void>(
      AppPageRoute<void>(child: const HomeScreen()),
      (route) => false,
    );
  }

  String get _formattedCountdown {
    final minutes = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final keyboardVisible = MediaQuery.viewInsetsOf(context).bottom > 0;
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _dismissKeyboard,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(AppAssets.authWallpaper, fit: BoxFit.cover),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppTheme.chocolate.withValues(alpha: 0.38),
                    const Color(0xFF542535).withValues(alpha: 0.64),
                    AppTheme.chocolate.withValues(alpha: 0.9),
                  ],
                  stops: const [0, 0.42, 1],
                ),
              ),
            ),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final contentPadding = EdgeInsets.fromLTRB(
                    24,
                    keyboardVisible ? 12 : 28,
                    24,
                    keyboardVisible ? 12 : 22,
                  );
                  return SingleChildScrollView(
                    padding: contentPadding,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight:
                            constraints.maxHeight - contentPadding.vertical,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              if (!keyboardVisible) ...[
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 13,
                                    vertical: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.16),
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.22,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'FRESHLY MADE  ·  ALWAYS SWEET',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.1,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 17),
                              ],
                              Text(
                                "J'Donuts",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: keyboardVisible ? 30 : 43,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -1.4,
                                  height: 1.1,
                                ),
                              ),
                              if (!keyboardVisible) ...[
                                const SizedBox(height: 7),
                                Text(
                                  'A little happiness, made fresh.',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          SizedBox(height: keyboardVisible ? 14 : 28),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 360),
                            switchInCurve: Curves.easeOutCubic,
                            switchOutCurve: Curves.easeInCubic,
                            transitionBuilder: (child, animation) =>
                                FadeTransition(
                                  opacity: animation,
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(0.04, 0.04),
                                      end: Offset.zero,
                                    ).animate(animation),
                                    child: child,
                                  ),
                                ),
                            child: _isOtpView
                                ? _buildOtpCard(key: const ValueKey('otp'))
                                : _buildPhoneCard(key: const ValueKey('phone')),
                          ),
                          if (!keyboardVisible) ...[
                            const SizedBox(height: 20),
                            Text(
                              'By continuing, you agree to our Terms & Privacy Policy.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.78),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneCard({Key? key}) {
    return _AuthCard(
      key: key,
      eyebrow: 'WELCOME, SWEET FRIEND',
      title: 'Your treat is waiting',
      subtitle: 'Sign in with your phone number to get started.',
      errorMessage: _errorMessage,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _PhoneInput(
            controller: _phoneController,
            onTapOutside: _dismissKeyboard,
          ),
          const SizedBox(height: 18),
          _PrimaryButton(
            label: 'Send me a code',
            icon: Icons.arrow_forward_rounded,
            onPressed: _requestCode,
          ),
        ],
      ),
    );
  }

  Widget _buildOtpCard({Key? key}) {
    return _AuthCard(
      key: key,
      eyebrow: 'ONE LAST STEP',
      title: 'Check your messages',
      subtitle: 'We sent a 4-digit code to +95 ${_phoneController.text}.',
      errorMessage: _errorMessage,
      onBack: () {
        setState(() {
          _countdown?.cancel();
          _isOtpView = false;
          _errorMessage = null;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _codeController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 4,
            onTapOutside: (_) => _dismissKeyboard(),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(4),
            ],
            style: const TextStyle(
              color: AppTheme.chocolate,
              fontSize: 25,
              fontWeight: FontWeight.w700,
              letterSpacing: 17,
            ),
            decoration: InputDecoration(
              counterText: '',
              hintText: '• • • •',
              hintStyle: TextStyle(
                color: AppTheme.muted.withValues(alpha: 0.6),
                letterSpacing: 8,
              ),
              filled: true,
              fillColor: AppTheme.cream,
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppTheme.pink, width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Center(
            child: _secondsRemaining > 0
                ? Text.rich(
                    TextSpan(
                      text: 'Code expires in ',
                      style: const TextStyle(
                        color: AppTheme.muted,
                        fontSize: 12,
                      ),
                      children: [
                        TextSpan(
                          text: _formattedCountdown,
                          style: const TextStyle(
                            color: AppTheme.pink,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  )
                : TextButton(
                    onPressed: () {
                      setState(() => _secondsRemaining = 300);
                      _startCountdown();
                    },
                    child: const Text('Resend code'),
                  ),
          ),
          const SizedBox(height: 10),
          _PrimaryButton(
            label: 'Verify & continue',
            icon: Icons.favorite_rounded,
            isLoading: _isVerifying,
            onPressed: _verifyCode,
          ),
        ],
      ),
    );
  }

  void _dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

class _AuthCard extends StatelessWidget {
  const _AuthCard({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.child,
    this.errorMessage,
    this.onBack,
  });

  final String eyebrow;
  final String title;
  final String subtitle;
  final String? errorMessage;
  final Widget child;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 23, 22, 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: AppTheme.chocolate.withValues(alpha: 0.16),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onBack != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: InkWell(
                onTap: onBack,
                borderRadius: BorderRadius.circular(20),
                child: const Padding(
                  padding: EdgeInsets.only(right: 10, bottom: 5, top: 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_back_rounded, size: 17),
                      SizedBox(width: 5),
                      Text('Change number', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ),
          Text(
            eyebrow,
            style: const TextStyle(
              color: AppTheme.pink,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.chocolate,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              color: AppTheme.muted,
              fontSize: 12,
              height: 1.5,
            ),
          ),
          if (errorMessage != null) ...[
            const SizedBox(height: 12),
            Text(
              errorMessage!,
              style: const TextStyle(color: Color(0xFFC62828), fontSize: 12),
            ),
          ],
          const SizedBox(height: 19),
          child,
        ],
      ),
    );
  }
}

class _PhoneInput extends StatelessWidget {
  const _PhoneInput({required this.controller, required this.onTapOutside});

  final TextEditingController controller;
  final VoidCallback onTapOutside;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.phone,
      maxLength: 10,
      onTapOutside: (_) => onTapOutside(),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      style: const TextStyle(
        color: AppTheme.chocolate,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        counterText: '',
        hintText: '9 123 456 789',
        hintStyle: const TextStyle(color: Color(0xFFB7A8A3), fontSize: 13),
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 14, right: 11),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.phone_iphone_rounded, size: 18, color: AppTheme.pink),
              SizedBox(width: 9),
              Text(
                '+95',
                style: TextStyle(
                  color: AppTheme.chocolate,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 10),
              SizedBox(height: 22, child: VerticalDivider(width: 1)),
              SizedBox(width: 4),
            ],
          ),
        ),
        filled: true,
        fillColor: AppTheme.cream,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppTheme.pink, width: 1.5),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppTheme.pink,
          disabledBackgroundColor: AppTheme.pink.withValues(alpha: 0.7),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 3,
          shadowColor: AppTheme.pink.withValues(alpha: 0.3),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          child: isLoading
              ? const SizedBox(
                  key: ValueKey('loading'),
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.4,
                    color: Colors.white,
                  ),
                )
              : Row(
                  key: const ValueKey('label'),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(icon, size: 18),
                  ],
                ),
        ),
      ),
    );
  }
}
