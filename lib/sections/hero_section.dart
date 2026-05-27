import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_caserito/core/colors.dart';
import 'package:todo_caserito/core/text_styles.dart';
import 'contact_section.dart' show launchWhatsApp;

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

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
      child: isMobile ? _MobileHero() : _DesktopHero(),
    );
  }
}

class _DesktopHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: _HeroText()),
        const SizedBox(width: 40),
        _MascotBox(size: 280),
      ],
    );
  }
}

class _MobileHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MascotBox(size: 200),
        const SizedBox(height: 32),
        _HeroText(),
      ],
    );
  }
}

class _HeroText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'REPOSTERÍA ARTESANAL · BUENOS AIRES',
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
            _CtaButton(label: 'Ver menú', filled: false, onTap: () {}),
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
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.creamDark,
        shape: BoxShape.circle,
      ),
      // 📸 Reemplazá con:
      // child: Image.asset('assets/images/personaje.png', fit: BoxFit.contain),
      child: Center(
        child: Image.asset('assets/images/personaje.jpg', fit: BoxFit.contain),
      ),
    );
  }
}
