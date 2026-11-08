import 'package:flutter/material.dart';

class MainColorPicker extends StatelessWidget {
  final Color currentColor;
  final ValueChanged<Color> onColorSelected;

  const MainColorPicker({
    super.key,
    required this.currentColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showColorPickerDialog(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withOpacity(0.15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: currentColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Couleur de fond',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Choisissez une nuance claire pour le tableau de bord et les pages principales',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
            const Icon(Icons.color_lens_outlined, color: Colors.blueAccent),
          ],
        ),
      ),
    );
  }

  void _showColorPickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choisir une couleur'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _buildColorOptions(context),
          ),
        );
      },
    );
  }

  List<Widget> _buildColorOptions(BuildContext context) {
    return [
      _buildColorOption(
        context,
        const Color(0xFFF8E4E6),
        'Rouge pâle',
        'Sombre et doux : contraste discret avec une ambiance chaleureuse.',
      ),
      _buildColorOption(
        context,
        const Color(0xFFDAE6F4),
        'Bleu pâle',
        'Ambiance fraîche et calme, idéale pour un tableau de bord serein.',
      ),
      _buildColorOption(
        context,
        const Color(0xFFF5F5F5),
        'Gris clair',
        'Fond neutre et discret, bon pour réduire la fatigue visuelle.',
      ),
      _buildColorOption(
        context,
        Colors.white,
        'Blanc',
        'Option classique, claire et facile à associer.',
      ),
    ];
  }

  Widget _buildColorOption(
    BuildContext context,
    Color color,
    String label,
    String description,
  ) {
    final bool isSelected = color == currentColor;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
        ),
      ),
      title: Text(label),
      subtitle: Text(
        description,
        style: const TextStyle(fontSize: 12, color: Colors.black54),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: Colors.blueAccent)
          : null,
      onTap: () {
        onColorSelected(color);
        Navigator.of(context).pop();
      },
    );
  }
}

