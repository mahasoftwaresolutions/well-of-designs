import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'portfolio_menu.dart';
import 'portfolio_registry.dart';

void main() {
  runApp(const DesignWellApp());
}

class DesignWellApp extends StatelessWidget {
  const DesignWellApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design Well',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D0D12),
        colorScheme: ColorScheme.dark(
          surface: const Color(0xFF0D0D12),
          primary: const Color(0xFF6C63FF),
          secondary: const Color(0xFF00D9A6),
          tertiary: const Color(0xFFFF6B9D),
          onSurface: Colors.white,
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF0D0D12),
          elevation: 0,
          titleTextStyle: GoogleFonts.outfit(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (_) => const PortfolioMenu());
        }

        // Match /portfolio/<name>
        final uri = Uri.parse(settings.name ?? '');
        if (uri.pathSegments.length == 2 &&
            uri.pathSegments[0] == 'portfolio') {
          final name = uri.pathSegments[1];
          final entry = PortfolioRegistry.findBySlug(name);
          if (entry != null) {
            return PageRouteBuilder(
              pageBuilder: (context3, animation, secondaryAnimation2) =>
                  entry.pageBuilder(),
              transitionsBuilder:
                  (context2, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutCubic,
                      ),
                      child: SlideTransition(
                        position:
                            Tween<Offset>(
                              begin: const Offset(0, 0.03),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeOutCubic,
                              ),
                            ),
                        child: child,
                      ),
                    );
                  },
              transitionDuration: const Duration(milliseconds: 400),
            );
          }
        }

        return MaterialPageRoute(builder: (_) => const PortfolioMenu());
      },
    );
  }
}
