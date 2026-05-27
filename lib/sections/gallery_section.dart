import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/colors.dart';
import '../core/text_styles.dart';

// 📸 Cuando tengas las fotos, reemplazá los _GalleryPlaceholder
// con Image.asset('assets/images/gallery/fotoX.jpg', fit: BoxFit.cover)
// dentro de un ClipRRect con el mismo borderRadius.

const _labels = [
  'Torta Balcarce',
  'Cheesecake',
  'Lemon Pie',
  'Carrot Cake',
  'Pastafrola',
];

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

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
          Container(height: 1, color: AppColors.border, margin: const EdgeInsets.only(bottom: 56)),
          Text('GALERÍA', style: AppTextStyles.label()),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              style: AppTextStyles.display(size: 40),
              children: const [
                TextSpan(text: 'Algunas de mis '),
                TextSpan(
                  text: 'creaciones',
                  style: TextStyle(fontStyle: FontStyle.italic, color: AppColors.orange, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          isMobile ? _MobileGallery() : _DesktopGallery(),
        ],
      ),
    );
  }
}

class _DesktopGallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 440,
      child: Row(
        children: [
          // Foto destacada grande
          Expanded(
            flex: 2,
            child: _GalleryPlaceholder(label: _labels[0], radius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            )),
          ),
          const SizedBox(width: 8),
          // 2 columnas con 2 fotos cada una
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(child: _GalleryPlaceholder(label: _labels[1], radius: const BorderRadius.only(topRight: Radius.circular(16)))),
                const SizedBox(height: 8),
                Expanded(child: _GalleryPlaceholder(label: _labels[2])),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(child: _GalleryPlaceholder(label: _labels[3])),
                const SizedBox(height: 8),
                Expanded(child: _GalleryPlaceholder(label: _labels[4], radius: const BorderRadius.only(bottomRight: Radius.circular(16)))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileGallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 220,
          child: _GalleryPlaceholder(label: _labels[0], radius: BorderRadius.circular(12)),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 160,
          child: Row(
            children: [
              Expanded(child: _GalleryPlaceholder(label: _labels[1], radius: BorderRadius.circular(12))),
              const SizedBox(width: 8),
              Expanded(child: _GalleryPlaceholder(label: _labels[2], radius: BorderRadius.circular(12))),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 160,
          child: Row(
            children: [
              Expanded(child: _GalleryPlaceholder(label: _labels[3], radius: BorderRadius.circular(12))),
              const SizedBox(width: 8),
              Expanded(child: _GalleryPlaceholder(label: _labels[4], radius: BorderRadius.circular(12))),
            ],
          ),
        ),
      ],
    );
  }
}

class _GalleryPlaceholder extends StatelessWidget {
  final String label;
  final BorderRadius radius;

  const _GalleryPlaceholder({
    required this.label,
    this.radius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.creamDark,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_outlined, size: 32, color: AppColors.warmGray),
            const SizedBox(height: 6),
            Text(
              label,
              style: GoogleFonts.nunito(fontSize: 11, color: AppColors.warmGray),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
