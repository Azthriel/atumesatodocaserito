import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_caserito/core/colors.dart';
import 'package:todo_caserito/core/text_styles.dart';
import 'contact_section.dart' show launchWhatsApp;

class NavbarSection extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onInicio;
  final VoidCallback? onNosotros;
  final VoidCallback? onMenu;
  final VoidCallback? onGaleria;

  const NavbarSection({
    super.key,
    this.onInicio,
    this.onNosotros,
    this.onMenu,
    this.onGaleria,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
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
            _NavLink(label: 'Inicio', onTap: onInicio),
            const SizedBox(width: 24),
            _NavLink(label: 'Nosotros', onTap: onNosotros),
            const SizedBox(width: 24),
            _NavLink(label: 'Menú', onTap: onMenu),
            const SizedBox(width: 24),
            _NavLink(label: 'Galería', onTap: onGaleria),
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
  final VoidCallback? onTap;
  const _NavLink({required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Text(label.toUpperCase(), style: AppTextStyles.nav()),
      ),
    );
  }
}

class _WaButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: launchWhatsApp,
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
