// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:plant_design_system/plant_design_system.dart';

class PlantBasicProductCardWidget extends StatefulWidget {
  final String name;
  bool isFavorite;

  PlantBasicProductCardWidget({
    Key? key,
    required this.name,
    required this.isFavorite,
  }) : super(key: key);

  @override
  State<PlantBasicProductCardWidget> createState() => _PlantBasicProductCardWidgetState();
}

class _PlantBasicProductCardWidgetState extends State<PlantBasicProductCardWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.28,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size.width * 0.33,
            height: size.height * 0.23,
            decoration: BoxDecoration(
              color: PlantCustomColor.earthyColor,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(widget.name, style: theme.textTheme.headline3),
          )
        ],
      ),
    );
  }
}
