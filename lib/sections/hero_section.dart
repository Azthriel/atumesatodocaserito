import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_caserito/core/colors.dart';
import 'package:todo_caserito/core/text_styles.dart';
import 'contact_section.dart' show launchWhatsApp;

class HeroSection extends StatelessWidget {
  final VoidCallback? onMenuTap;
  const HeroSection({super.key, this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 768;

    return Container(
      color: AppColors.cream,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 48 : 80,
      ),
      child: isMobile
          ? _MobileHero(onMenuTap: onMenuTap)
          : _DesktopHero(onMenuTap: onMenuTap),
    );
  }
}

class _DesktopHero extends StatelessWidget {
  final VoidCallback? onMenuTap;
  const _DesktopHero({this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: _HeroText(onMenuTap: onMenuTap)),
        const SizedBox(width: 40),
        const _MascotBox(size: 280),
      ],
    );
  }
}

class _MobileHero extends StatelessWidget {
  final VoidCallback? onMenuTap;
  const _MobileHero({this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _MascotBox(size: 200),
        const SizedBox(height: 32),
        _HeroText(onMenuTap: onMenuTap),
      ],
    );
  }
}

class _HeroText extends StatelessWidget {
  final VoidCallback? onMenuTap;
  const _HeroText({this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'REPOSTERÍA ARTESANAL · HURLINGHAM · BUENOS AIRES',
          style: AppTextStyles.label(),
        ),
        const SizedBox(height: 12),
        RichText(
          text: TextSpan(
            style: AppTextStyles.display(size: 56),
            children: const [
              TextSpan(text: 'Tortas hechas\ncon '),
              TextSpan(
                text: 'amor',
                style: TextStyle(
                  color: AppColors.orange,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Para tu cumpleaños, tu evento,\no simplemente para darte un gustito.',
          style: AppTextStyles.body(),
        ),
        const SizedBox(height: 28),
        Row(
          children: [
            _CtaButton(
              label: 'Hacer pedido',
              filled: true,
              onTap: launchWhatsApp,
            ),
            const SizedBox(width: 12),
            _CtaButton(
              label: 'Ver menú',
              filled: false,
              onTap: onMenuTap ?? () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _CtaButton extends StatelessWidget {
  final String label;
  final bool filled;
  final VoidCallback onTap;
  const _CtaButton({
    required this.label,
    required this.filled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: filled ? AppColors.orange : Colors.transparent,
          border: Border.all(color: AppColors.orange),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          style: GoogleFonts.nunito(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: filled ? Colors.white : AppColors.orange,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}

class _MascotBox extends StatelessWidget {
  final double size;
  const _MascotBox({required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset('assets/images/personaje.jpg', fit: BoxFit.contain),
    );
  }
}
