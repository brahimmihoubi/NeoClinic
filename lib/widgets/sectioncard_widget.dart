import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final int? count;

  const SectionCard({
    required this.icon,
    required this.title,
    required this.onTap,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListTile(
          leading: Icon(icon, size: 32),
          title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          trailing: count != null ? Text('$count', style: TextStyle(fontSize: 16)) : Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
