// lib/sections/gallery_section.dart
import 'package:flutter/material.dart';
import 'package:todo_caserito/core/colors.dart';
import 'package:todo_caserito/core/text_styles.dart';

// ── Cargá tus fotos acá ─────────────────────────────────────────────────────
// Asegurate que los nombres coincidan con los archivos en assets/images/gallery/
const _photos = [
  _Photo('assets/images/gallery/lemonpie.jpeg', 'Lemon Pie'),
  _Photo(
    'assets/images/gallery/cocoyddl.jpeg',
    'Torta de coco y dulce de leche',
  ),
  _Photo('assets/images/gallery/tortatoffi.jpeg', 'Torta Toffi'),
  _Photo('assets/images/gallery/bananasplit.jpeg', 'Torta Banana Split'),
  _Photo('assets/images/gallery/frutaldurazno.jpeg', 'Torta frutal de durazno'),
  _Photo(
    'assets/images/gallery/frutalfrutilla.jpeg',
    'Torta frutal de frutilla',
  ),
  _Photo(
    'assets/images/gallery/ricotayddl.jpeg',
    'Torta de ricota y dulce de leche',
  ),
  _Photo('assets/images/gallery/brownie.jpeg', 'Torta Brownie'),
  _Photo('assets/images/gallery/pastafrola.jpeg', 'Pastafrola'),
];

class _Photo {
  final String path;
  final String label;
  const _Photo(this.path, this.label);
}

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
          Container(
            height: 1,
            color: AppColors.border,
            margin: const EdgeInsets.only(bottom: 56),
          ),
          Text('GALERÍA', style: AppTextStyles.label()),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              style: AppTextStyles.display(size: 40),
              children: const [
                TextSpan(text: 'Algunas de mis '),
                TextSpan(
                  text: 'creaciones',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: AppColors.orange,
                    fontWeight: FontWeight.w300,
                  ),
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
          Expanded(
            flex: 2,
            child: _GalleryTile(
              photo: _photos[0],
              radius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: _GalleryTile(
                    photo: _photos[1],
                    radius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(child: _GalleryTile(photo: _photos[2])),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                Expanded(child: _GalleryTile(photo: _photos[3])),
                const SizedBox(height: 8),
                Expanded(
                  child: _GalleryTile(
                    photo: _photos[4],
                    radius: const BorderRadius.only(
                      bottomRight: Radius.circular(16),
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

class _MobileGallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 220,
          child: _GalleryTile(
            photo: _photos[0],
            radius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 160,
          child: Row(
            children: [
              Expanded(
                child: _GalleryTile(
                  photo: _photos[1],
                  radius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _GalleryTile(
                  photo: _photos[2],
                  radius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 160,
          child: Row(
            children: [
              Expanded(
                child: _GalleryTile(
                  photo: _photos[3],
                  radius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _GalleryTile(
                  photo: _photos[4],
                  radius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GalleryTile extends StatelessWidget {
  final _Photo photo;
  final BorderRadius radius;

  const _GalleryTile({required this.photo, this.radius = BorderRadius.zero});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showFullscreen(context),
      child: ClipRRect(
        borderRadius: radius,
        child: Image.asset(
          photo.path,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          // Si el archivo no existe todavía, muestra placeholder
          errorBuilder: (_, _, _) => Container(
            color: AppColors.creamDark,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.image_outlined,
                  size: 32,
                  color: AppColors.warmGray,
                ),
                const SizedBox(height: 6),
                Text(
                  photo.label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.warmGray,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFullscreen(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.black87,
        insetPadding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            InteractiveViewer(
              child: Image.asset(photo.path, fit: BoxFit.contain),
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
