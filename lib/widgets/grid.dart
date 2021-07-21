import 'package:flutter/material.dart';

class Grid extends StatefulWidget {
  final List shape;
  final Map shapeData;
  final Color color;
  const Grid({
    Key? key,
    required this.shape,
    required this.shapeData,
    required this.color,
  }) : super(key: key);

  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  List movingShape = [];
  @override
  void initState() {
    super.initState();
    movingShape = widget.shape;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 10,
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
      ),
      physics: NeverScrollableScrollPhysics(),
      itemCount: 200,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: (widget.shape.contains(index))
                ? widget.color
                : (widget.shapeData.containsKey(index))
                    ? widget.shapeData[index]
                    : Color(0xff242424),
          ),
          // child: Center(child: Text('$index')),
        );
      },
    );
  }
}
