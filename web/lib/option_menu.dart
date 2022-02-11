import 'package:flutter/material.dart';

class OptionWidget extends StatefulWidget {
  final List<String> options;
  final String type;

  final ValueChanged<String> onSelect;

  const OptionWidget(
      {required this.type, required this.options, required this.onSelect});
  @override
  _OptionWidgetState createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget> {
  String city = "";
  @override
  Widget build(BuildContext context) {
    if (city == "") city = widget.type;
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      child: Column(
        children: [
          DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: widget.type,
              border: OutlineInputBorder(),
            ),
            hint: Text(
              city,
              style: TextStyle(color: Colors.blue),
            ),
            isExpanded: true,
            style: TextStyle(color: Colors.blue),
            items: widget.options.map(
              (val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                );
              },
            ).toList(),
            onChanged: (val) {
              setState(
                () {
                  widget.onSelect(val.toString());
                  city = val.toString();
                },
              );
            },
          )
        ],
      ),
    );
  }
}
