// import 'package:flutter/material.dart';
// import 'package:orevahardware/constants/kcolors.dart';
//
// class ColorChangingContainer extends StatefulWidget {
//   final Color initialColor;
//   final Color borderBorderColor;
//   final String text;
//   // final Function press;
//
//
//   ColorChangingContainer({
//     required this.initialColor,
//     required this.borderBorderColor,
//     required this.text,
//     // required this.press
//   });
//
//   @override
//   _ColorChangingContainerState createState() => _ColorChangingContainerState();
// }
//
// class _ColorChangingContainerState extends State<ColorChangingContainer> {
//   Color containerColor = Colors.transparent;
//   Color? textColor;
//   Color borderColor = Kcolor.primaryColor;
//   bool selected = false;
//   // Function press = press;
//   @override
//   void initState() {
//     super.initState();
//     containerColor = widget.initialColor;
//     textColor = Colors.black;
//     borderColor = widget.borderBorderColor;
//   }
//
//   void onContainerTapped() {
//     setState(() {
//       selected = !selected;
//       if (selected) {
//         containerColor = Colors.brown[100]!;
//         textColor = Colors.white;
//         borderColor = ColorConstants.buttonColor;
//       } else {
//         containerColor = widget.initialColor;
//         textColor = Colors.black;
//         borderColor = Colors.grey;
//       }
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: Container(
//         height: 50,
//         width: 110,
//         decoration: BoxDecoration(
//           color: containerColor,
//           border: Border.all(
//             color: borderColor,
//           ),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Center(
//           child: Text(
//             widget.text,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//               color: textColor,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
