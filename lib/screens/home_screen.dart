import 'package:flutter/material.dart';
import 'package:quarks_footer/quarks_footer.dart';
import 'package:todo_caserito/sections/certificates_section.dart';
import 'package:todo_caserito/core/colors.dart';
import 'package:todo_caserito/sections/navbar_section.dart';
import 'package:todo_caserito/sections/hero_section.dart';
import 'package:todo_caserito/sections/about_section.dart';
import 'package:todo_caserito/sections/menu_section.dart';
import 'package:todo_caserito/sections/gallery_section.dart';
import 'package:todo_caserito/sections/contact_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _menuKey = GlobalKey();
  final _galleryKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: NavbarSection(
          onInicio: () => _scrollTo(_heroKey),
          onNosotros: () => _scrollTo(_aboutKey),
          onMenu: () => _scrollTo(_menuKey),
          onGaleria: () => _scrollTo(_galleryKey),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HeroSection(
              key: _heroKey,
              onMenuTap: () => _scrollTo(_menuKey), // ✅ "Ver menú" funciona
            ),
            AboutSection(key: _aboutKey),
            const CertificatesSection(),
            MenuSection(key: _menuKey),
            GallerySection(key: _galleryKey),
            const ContactSection(),
            QuarksFooter(
              backgroundColor: AppColors.charcoalDark,
              textColor: AppColors.cream,
            ),
          ],
        ),
      ),
    );
  }
}
