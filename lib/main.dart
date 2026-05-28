import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/semantics.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'app.dart';
import 'package:quarks_version_checker/quarks_version_checker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  usePathUrlStrategy();
  if (kIsWeb) SemanticsBinding.instance.ensureSemantics();
  await GoogleFonts.pendingFonts([
    GoogleFonts.cormorantGaramond(),
    GoogleFonts.cormorantGaramond(
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.italic,
    ),
    GoogleFonts.cormorantGaramond(fontWeight: FontWeight.w400),
    GoogleFonts.cormorantGaramond(fontWeight: FontWeight.w600),
    GoogleFonts.nunito(fontWeight: FontWeight.w300),
    GoogleFonts.nunito(fontWeight: FontWeight.w500),
    GoogleFonts.nunito(fontWeight: FontWeight.w600),
    GoogleFonts.nunito(fontWeight: FontWeight.w700),
  ]);
  try {
    await AppVersionChecker.instance.start();
  } catch (_) {}
  runApp(const TodoCaseritoApp());
}
