import 'package:flutter/material.dart';
import 'package:ghclient/common/utils.dart';

class RepositoryItem extends StatelessWidget {
  const RepositoryItem({
    required this.name,
    required this.stars,
    required this.language,
    required this.onTap,
    this.description,
    super.key,
  });

  final String name;
  final String? description;
  final int stars;
  final String? language;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).primaryColor.withOpacity(0.4),
      highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18),
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            if (description != null)
              Column(
                children: [
                  Text(
                    description!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14),
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                ],
              ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.star_border_outlined,
                  size: 16,
                ),
                const SizedBox(width: 2),
                Text(shortenNumber(stars), style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(width: 8),
                if (language != null)
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: getColorFromString(language!),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text((language!), style: Theme.of(context).textTheme.bodyMedium)
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
