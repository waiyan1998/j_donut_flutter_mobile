import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  static const _points = 1250;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sweet rewards',
            style: TextStyle(
              color: AppTheme.chocolate,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Every donut brings you a little closer.',
            style: TextStyle(color: AppTheme.muted, fontSize: 12),
          ),
          const SizedBox(height: 20),
          _MembershipCard(points: _points),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your vouchers',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEAF1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '2 UNLOCKED',
                  style: TextStyle(
                    color: AppTheme.pink,
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          const _VoucherCard(
            title: 'A little treat on us',
            subtitle: 'Free classic donut with your next visit',
            expiry: 'Valid until 30 Nov 2026',
            icon: Icons.redeem_rounded,
            color: Color(0xFFFF4081),
            code: 'SWEET1250',
          ),
          const SizedBox(height: 12),
          const _VoucherCard(
            title: 'Coffee date',
            subtitle: '20% off any drink with 2 donuts',
            expiry: 'Valid until 15 Dec 2026',
            icon: Icons.local_cafe_rounded,
            color: Color(0xFF9B6A53),
            code: 'COFFEETIME',
          ),
          const SizedBox(height: 23),
          const Text(
            'How to earn points',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.auto_awesome_rounded,
                  color: AppTheme.pink,
                  size: 22,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Earn 1 point for every 100 Ks spent. Save your points for sweet surprises!',
                    style: TextStyle(
                      color: AppTheme.muted,
                      fontSize: 11,
                      height: 1.6,
                    ),
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

class _MembershipCard extends StatelessWidget {
  const _MembershipCard({required this.points});

  final int points;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7F5E54), Color(0xFF3E2723), Color(0xFF281916)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.chocolate.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -3,
            top: 0,
            child: Icon(
              Icons.bakery_dining_rounded,
              size: 82,
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD7C8C1).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.workspace_premium_rounded,
                          color: Color(0xFFE4D1C8),
                          size: 13,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'SILVER MEMBER',
                          style: TextStyle(
                            color: Color(0xFFF2E5E0),
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "J'DONUTS",
                    style: TextStyle(
                      color: Color(0xFFFFC7D9),
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              const Text(
                'Your points balance',
                style: TextStyle(color: Color(0xFFD8C3BC), fontSize: 11),
              ),
              const SizedBox(height: 3),
              TweenAnimationBuilder<int>(
                tween: IntTween(begin: 0, end: points),
                duration: const Duration(milliseconds: 1800),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) => Text(
                  '${_formatPoints(value)} pts',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 31,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: const LinearProgressIndicator(
                  value: 0.62,
                  minHeight: 5,
                  backgroundColor: Color(0xFF674C44),
                  valueColor: AlwaysStoppedAnimation(Color(0xFFFFA9C5)),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '750 pts to your next reward',
                style: TextStyle(color: Color(0xFFD8C3BC), fontSize: 9),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VoucherCard extends StatelessWidget {
  const _VoucherCard({
    required this.title,
    required this.subtitle,
    required this.expiry,
    required this.icon,
    required this.color,
    required this.code,
  });

  final String title;
  final String subtitle;
  final String expiry;
  final IconData icon;
  final Color color;
  final String code;

  @override
  Widget build(BuildContext context) {
    return _FloatingBadge(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppTheme.chocolate.withValues(alpha: 0.035),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: color, size: 21),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppTheme.chocolate,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(color: AppTheme.muted, fontSize: 9),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    expiry,
                    style: const TextStyle(color: AppTheme.muted, fontSize: 8),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3F7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                code,
                style: TextStyle(
                  color: color,
                  fontSize: 7,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FloatingBadge extends StatefulWidget {
  const _FloatingBadge({required this.child});

  final Widget child;

  @override
  State<_FloatingBadge> createState() => _FloatingBadgeState();
}

class _FloatingBadgeState extends State<_FloatingBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1900),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, -2.5 + 5 * _controller.value),
        child: child,
      ),
    );
  }
}

String _formatPoints(int points) => points.toString().replaceAllMapped(
  RegExp(r'\B(?=(\d{3})+(?!\d))'),
  (match) => ',',
);
