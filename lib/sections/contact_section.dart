import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/colors.dart';
import '../core/text_styles.dart';

// URL global reutilizable desde otras secciones
Future<void> launchWhatsApp() async {
  final uri = Uri.parse(
    'https://wa.me/5491131707357?text=Hola+Romi!+Quiero+hacer+un+pedido+%F0%9F%8D%B0',
  );
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

Future<void> launchPhone() async {
  final uri = Uri.parse('tel:+5491131707357');
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      color: AppColors.charcoal,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 80,
      ),
      child: Column(
        children: [
          Text(
            'CONTACTO',
            style: AppTextStyles.label(color: const Color(0xFFF0C4B8)),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: AppTextStyles.display(size: isMobile ? 36 : 48, color: AppColors.cream),
              children: const [
                TextSpan(text: '¿Querés hacer\nun '),
                TextSpan(
                  text: 'pedido?',
                  style: TextStyle(fontStyle: FontStyle.italic, color: AppColors.orange, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: launchPhone,
            child: Text(
              '11 3170-7357',
              style: GoogleFonts.cormorantGaramond(
                fontSize: 40,
                fontWeight: FontWeight.w400,
                color: AppColors.cream,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Romi Trillo',
            style: AppTextStyles.body(color: const Color(0xFF8A7A6E)),
          ),
          const SizedBox(height: 32),
          InkWell(
            onTap: launchWhatsApp,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.waGreen,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                'Escribir por WhatsApp',
                style: GoogleFonts.nunito(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
