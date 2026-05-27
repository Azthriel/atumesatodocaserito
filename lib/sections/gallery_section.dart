// lib/sections/gallery_section.dart
import 'dart:math';
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
  // _Photo('assets/images/gallery/budin.jpeg', 'Budin'),
  // Agregá más acá — se muestran todas automáticamente
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
          isMobile ? const _MobileGallery() : const _DesktopGallery(),
        ],
      ),
    );
  }
}

// ── Desktop: grilla dinámica de 3 columnas ───────────────────────────────────
class _DesktopGallery extends StatelessWidget {
  const _DesktopGallery();

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    const cols = 3;
    const rowHeight = 260.0;

    for (int i = 0; i < _photos.length; i += cols) {
      final slice = _photos.sublist(i, min(i + cols, _photos.length));
      rows.add(
        SizedBox(
          height: rowHeight,
          child: Row(
            children: List.generate(slice.length, (j) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: j > 0 ? 8 : 0),
                  child: _GalleryTile(
                    photo: slice[j],
                    radius: _radiusFor(i, j, slice.length),
                  ),
                ),
              );
            }),
          ),
        ),
      );
      if (i + cols < _photos.length) rows.add(const SizedBox(height: 8));
    }

    return Column(children: rows);
  }

  /// Redondea solo las esquinas exteriores de la grilla completa.
  BorderRadius _radiusFor(int rowStart, int col, int colsInRow) {
    const r = Radius.circular(12);
    final isFirstRow = rowStart == 0;
    final isLastRow  = rowStart + colsInRow >= _photos.length;
    final isFirstCol = col == 0;
    final isLastCol  = col == colsInRow - 1;

    return BorderRadius.only(
      topLeft:     (isFirstRow && isFirstCol) ? r : Radius.zero,
      topRight:    (isFirstRow && isLastCol)  ? r : Radius.zero,
      bottomLeft:  (isLastRow  && isFirstCol) ? r : Radius.zero,
      bottomRight: (isLastRow  && isLastCol)  ? r : Radius.zero,
    );
  }
}

// ── Mobile: columna de filas de 2 ────────────────────────────────────────────
class _MobileGallery extends StatelessWidget {
  const _MobileGallery();

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];

    // Primera foto grande
    widgets.add(
      SizedBox(
        height: 220,
        child: _GalleryTile(
          photo: _photos[0],
          radius: BorderRadius.circular(12),
        ),
      ),
    );

    // El resto en pares de 2
    for (int i = 1; i < _photos.length; i += 2) {
      widgets.add(const SizedBox(height: 8));
      final a = _photos[i];
      final b = i + 1 < _photos.length ? _photos[i + 1] : null;
      widgets.add(
        SizedBox(
          height: 160,
          child: Row(
            children: [
              Expanded(
                child: _GalleryTile(
                  photo: a,
                  radius: BorderRadius.circular(12),
                ),
              ),
              if (b != null) ...[
                const SizedBox(width: 8),
                Expanded(
                  child: _GalleryTile(
                    photo: b,
                    radius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }

    return Column(children: widgets);
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
                  textAlign: TextAlign.center,
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