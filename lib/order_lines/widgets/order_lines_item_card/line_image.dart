part of 'order_lines_item_card.dart';

class LineImage extends StatelessWidget {
  const LineImage({required this.lineImage, super.key});

  final String lineImage;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: lineImage,
      width: 80,
      height: 80,
      placeholder: (context, url) => const Center(child: Icon(Icons.image_outlined)),
      errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
    );
  }
}
