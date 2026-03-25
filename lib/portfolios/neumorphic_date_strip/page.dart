import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'design_tokens.dart';
import 'components/date_pill.dart';
import 'components/date_strip.dart';
import 'components/scroll_date_strip.dart';

class NeumorphicDateStripPage extends StatefulWidget {
  const NeumorphicDateStripPage({super.key});

  @override
  State<NeumorphicDateStripPage> createState() =>
      _NeumorphicDateStripPageState();
}

class _NeumorphicDateStripPageState extends State<NeumorphicDateStripPage> {
  final _dates = DateItem.generate();
  final _style = DatePillStyle.neumorphic();
  int _selectedIndex = 6;

  void _onSelect(int index) {
    setState(() => _selectedIndex = index);
  }

  bool get _isMobileDevice =>
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      color: NDSTokens.background,
      child: Center(
        child: ScrollDateStrip(
          dates: _dates,
          initialIndex: _selectedIndex,
          onSelect: _onSelect,
          style: _style,
        ),
      ),
    );

    if (_isMobileDevice) {
      return Scaffold(body: content);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFE8E4E0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8E4E0),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF1A1A2E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Neumorphic Date Strip',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.8,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: _phoneFrame(content),
        ),
      ),
    );
  }

  Widget _phoneFrame(Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(NDSTokens.phoneRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
            blurRadius: 40,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(NDSTokens.phoneRadius),
        child: child,
      ),
    );
  }
}
