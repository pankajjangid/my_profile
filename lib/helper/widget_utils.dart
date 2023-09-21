import 'package:flutter/material.dart';


Widget chip(String label, Color color) {
  return Chip(
    labelPadding: const EdgeInsets.all(5.0),
    avatar: CircleAvatar(
      backgroundColor: Colors.grey.shade600,
      child: Text(label[0].toUpperCase()),
    ),
    label: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: color,
    elevation: 6.0,
    shadowColor: Colors.grey[60],
    padding: const EdgeInsets.all(6.0),
  );
}

dynamicChips(List<String >list) {
  return Wrap(
    spacing: 6.0,
    runSpacing: 6.0,
    children: List<Widget>.generate(list.length, (int index) {
      return Chip(

        label: Text(list[index]),

      );
    }),
  );
}

verticalSpace(){
  return const SizedBox(height: 10);
}
verticalSpaceSmall(){
  return const SizedBox(height: 5);
}
