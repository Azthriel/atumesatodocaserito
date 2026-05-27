// lib/sections/certificates_section.dart
import 'package:flutter/material.dart';
import 'package:todo_caserito/core/colors.dart';
import 'package:todo_caserito/core/text_styles.dart';

class CertificateModel {
  final String title;
  final String institution;
  final String year;
  final String assetPath; // ej: 'assets/images/certificates/cert1.jpg'

  const CertificateModel({
    required this.title,
    required this.institution,
    required this.year,
    required this.assetPath,
  });
}

// ── Cargá tus certificados acá ──────────────────────────────────────────────
const _certs = [
  CertificateModel(
    title: 'Pastelería Profesional',
    institution: 'Instituto Argentino de Gastronomía',
    year: '2022',
    assetPath: 'assets/images/certificates/cert1.jpg',
  ),
  CertificateModel(
    title: 'Decoración de Tortas',
    institution: 'INFP',
    year: '2023',
    assetPath: 'assets/images/certificates/cert2.jpg',
  ),
  // Agregá más acá...
];

class CertificatesSection extends StatelessWidget {
  const CertificatesSection({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 1,
            color: AppColors.border,
            margin: const EdgeInsets.only(bottom: 56),
          ),
          Text('FORMACIÓN', style: AppTextStyles.label()),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              style: AppTextStyles.display(size: 40),
              children: const [
                TextSpan(text: 'Pastelería '),
                TextSpan(
                  text: 'profesional',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: AppColors.orange,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Formación certificada que respalda cada preparación.',
            style: AppTextStyles.body(),
          ),
          const SizedBox(height: 40),
          isMobile ? _CertListMobile(certs: _certs) : _CertGrid(certs: _certs),
        ],
      ),
    );
  }
}

// ── Grid desktop ─────────────────────────────────────────────────────────────
class _CertGrid extends StatelessWidget {
  final List<CertificateModel> certs;
  const _CertGrid({required this.certs});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 24,
      children: certs
          .map((c) => SizedBox(width: 280, child: _CertCard(cert: c)))
          .toList(),
    );
  }
}

// ── Lista mobile ─────────────────────────────────────────────────────────────
class _CertListMobile extends StatelessWidget {
  final List<CertificateModel> certs;
  const _CertListMobile({required this.certs});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: certs
          .map(
            (c) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _CertCard(cert: c),
            ),
          )
          .toList(),
    );
  }
}

// ── Card individual ───────────────────────────────────────────────────────────
class _CertCard extends StatelessWidget {
  final CertificateModel cert;
  const _CertCard({required this.cert});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.creamDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen del certificado — tappeable para ver a full
          GestureDetector(
            onTap: () => _showFullscreen(context, cert),
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: Image.asset(
                cert.assetPath,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  color: AppColors.creamDark,
                  child: const Center(
                    child: Icon(
                      Icons.workspace_premium_outlined,
                      size: 48,
                      color: AppColors.warmGray,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cert.title, style: AppTextStyles.display(size: 17)),
                const SizedBox(height: 4),
                Text(cert.institution, style: AppTextStyles.body(size: 12)),
                const SizedBox(height: 2),
                Text(cert.year, style: AppTextStyles.label()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFullscreen(BuildContext context, CertificateModel cert) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.black87,
        insetPadding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            InteractiveViewer(
              child: Image.asset(cert.assetPath, fit: BoxFit.contain),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
