import 'package:flutter/material.dart';
import 'package:quarks_footer/quarks_footer.dart';
import '../core/colors.dart';
import '../sections/navbar_section.dart';
import '../sections/hero_section.dart';
import '../sections/about_section.dart';
import '../sections/menu_section.dart';
import '../sections/gallery_section.dart';
import '../sections/contact_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: const NavbarSection(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeroSection(),
            const AboutSection(),
            const MenuSection(),
            const GallerySection(),
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
