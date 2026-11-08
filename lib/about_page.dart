// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Page "À Propos" de Matrice Application
/// Présente l'auteur et les informations sur le projet
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

// Texte Matrice Application en anglais
  static const String _matriceAppText = """
INTRODUCTION

1. Context
Matrice Application is a mobile application designed to facilitate the management of academic and administrative tasks for students and faculty members.
2. Problem Statement
Scientific Relevance, Interest and Originality: This project is relevant because it combines computer science and innovation in a mobile application .""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text(
          "À Propos",
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Section Matrice Application
            _buildSectionCard(
              icon: Icons.grid_view,
              title: "Matrice Application",
              titleColor: Colors.green,
              content: _matriceAppText,
              isEnglish: true,
            ),
            const SizedBox(height: 30),

            // Footer
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required String content,
    Color titleColor = Colors.green,
    bool isEnglish = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: titleColor, size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          Text(
            content,
            style: GoogleFonts.poppins(
              fontSize: 14,
              height: 1.6,
              color: Colors.black87,
            ),
            textAlign: isEnglish ? TextAlign.justify : TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    final currentYear = DateTime.now().year;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.grid_view, color: Colors.green, size: 16),
              const SizedBox(width: 8),
              Text(
                "Matrice Application",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "2023 - $currentYear © Bléou Christ - Matrice Application",
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
          ),
          Text(
            "Projet de fin de Licence 1",
            style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
