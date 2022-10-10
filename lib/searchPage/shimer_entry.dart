import 'package:flutter/material.dart';

class ShimmerEntry extends StatelessWidget {
  const ShimmerEntry({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Solid_white_bordered.svg/2048px-Solid_white_bordered.svg.png",
            width: 100,
            height: 150,
            fit: BoxFit.cover,
          ),
          SizedBox(height:2),
          Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Solid_white_bordered.svg/2048px-Solid_white_bordered.svg.png",
            width: 130,
            height: 20,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
