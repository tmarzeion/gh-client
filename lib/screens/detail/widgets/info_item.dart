import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? value;

  final bool loading;
  final bool error;

  const InfoItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    this.value,
    this.loading = false,
    this.error = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 40),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            if (loading)
              const SizedBox(
                height: 20.0,
                width: 20.0,
                child: CircularProgressIndicator(),
              )
            else if (error)
              const Icon(Icons.error_outline, color: Colors.red)
            else
              SizedBox(
                height: 20,
                child: Center(
                  child: Text(
                    value ?? 'N/A',
                    style: const TextStyle(fontSize: 14.0),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
