import 'package:flutter/material.dart';

class CustomToggleSwitch extends StatefulWidget {
  final List<String> labels;
  final List<IconData> icons;
  final void Function(int) onToggle;

  const CustomToggleSwitch({
    Key? key,
    required this.labels,
    required this.icons,
    required this.onToggle,
  }) : super(key: key);

  @override
  _CustomToggleSwitchState createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch> {
  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = List.generate(widget.labels.length, (index) => false);
    
    
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var i = 0; i < widget.labels.length; i++)
              GestureDetector(
                onTap: () {
                  setState(() {
                    for (var j = 0; j < widget.labels.length; j++) {
                      isSelected[j] = i == j;
                    }
                    widget.onToggle(i);
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected[i] ? Colors.black : Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        widget.icons[i],
                        color: isSelected[i] ? Colors.white : Colors.black,
                      ),
                      SizedBox(width: 8),
                      Text(
                        widget.labels[i],
                        style: TextStyle(
                          color: isSelected[i] ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
