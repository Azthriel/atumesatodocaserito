import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_caserito/core/colors.dart';
import 'package:todo_caserito/core/text_styles.dart';

class NavbarSection extends StatelessWidget implements PreferredSizeWidget {
  const NavbarSection({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: AppColors.cream,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          // Brand
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Todo Caserito',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.charcoal,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                'A TU MESA',
                style: AppTextStyles.label().copyWith(fontSize: 8),
              ),
            ],
          ),
          const Spacer(),
          if (!isMobile) ...[
            _NavLink(label: 'Inicio'),
            const SizedBox(width: 24),
            _NavLink(label: 'Nosotros'),
            const SizedBox(width: 24),
            _NavLink(label: 'Menú'),
            const SizedBox(width: 24),
            _NavLink(label: 'Galería'),
            const SizedBox(width: 24),
          ],
          _WaButton(),
        ],
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  const _NavLink({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(label.toUpperCase(), style: AppTextStyles.nav());
  }
}

class _WaButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {}, // ver contact_section.dart para la lógica de URL
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: AppColors.waGreen,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          'WHATSAPP',
          style: GoogleFonts.nunito(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
