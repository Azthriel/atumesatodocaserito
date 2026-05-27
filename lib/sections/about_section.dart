import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_caserito/core/colors.dart';
import 'package:todo_caserito/core/text_styles.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      color: AppColors.cream,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 72,
      ),
      child: Column(
        children: [
          Container(
            height: 1,
            color: AppColors.border,
            margin: const EdgeInsets.only(bottom: 72),
          ),
          isMobile ? _MobileAbout() : _DesktopAbout(),
        ],
      ),
    );
  }
}

class _DesktopAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _PhotoPlaceholder(),
        const SizedBox(width: 64),
        const Expanded(child: _AboutText()),
      ],
    );
  }
}

class _MobileAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [_PhotoPlaceholder(), SizedBox(height: 32), _AboutText()],
    );
  }
}

class _PhotoPlaceholder extends StatelessWidget {
  const _PhotoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      height: 320,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset('assets/images/romi.jpeg', fit: BoxFit.cover),
      ),

      // 📸 Reemplazá con:
      // decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      // child: ClipRRect(
      //   borderRadius: BorderRadius.circular(16),
      //   child: Image.asset('assets/images/romi.jpg', fit: BoxFit.cover),
      // ),
    );
  }
}

class _AboutText extends StatelessWidget {
  const _AboutText();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('SOBRE MÍ', style: AppTextStyles.label()),
        const SizedBox(height: 12),
        RichText(
          text: TextSpan(
            style: AppTextStyles.display(size: 40),
            children: const [
              TextSpan(text: 'Todo hecho '),
              TextSpan(
                text: 'en casa,',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: AppColors.orange,
                  fontWeight: FontWeight.w300,
                ),
              ),
              TextSpan(text: '\ncon cariño'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Soy Romi, una pastelera profesional, hago tortas artesanales a pedido desde mi casa. '
          'Cada postre está hecho con ingredientes seleccionados y muchísimo amor.',
          style: AppTextStyles.body(),
        ),
        const SizedBox(height: 8),
        Text(
          'Trabajamos con pedidos anticipados para garantizar la mejor calidad '
          'y frescura en cada preparación. ¡Te llevamos el pedido a domicilio!',
          style: AppTextStyles.body(),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _Tag('100% Artesanal'),
            _Tag('Hecho con amor'),
            _Tag('A domicilio'),
            _Tag('Pedidos anticipados'),
          ],
        ),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.orangePale,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: GoogleFonts.nunito(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppColors.orange,
        ),
      ),
    );
  }
}
