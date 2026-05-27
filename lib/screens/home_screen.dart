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
            const CertificatesSection(),
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
