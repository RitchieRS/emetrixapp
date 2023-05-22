// import 'package:flutter/material.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:emetrix_flutter/app/ui/utils/utils.dart';

// class TypeBuilder extends StatefulWidget {
//   const TypeBuilder({
//     super.key,
//     required this.type,
//     required this.index,
//     required this.isLast,
//     required this.onTap,
//     required this.finisedSections,
//   });
//   final String type;
//   final int index;
//   final bool isLast;
//   final VoidCallback? onTap;
//   final List<int> finisedSections;

//   @override
//   State<TypeBuilder> createState() => _TypeBuilderState();
// }

// class _TypeBuilderState extends State<TypeBuilder>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     final size = MediaQuery.of(context).size;

//     return FadeIn(
//       child: InkWell(
//         onTap: widget.onTap,
//         borderRadius: BorderRadius.circular(14),
//         child: Ink(
//           width: size.width,
//           height: size.height * 0.15,
//           color: Colors.transparent,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   SizedBox(width: size.width * 0.06),
//                   Container(
//                     height: size.height * 0.08,
//                     width: size.height * 0.08,
//                     decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                             color: widget.finisedSections.contains(widget.index)
//                                 ? Colors.transparent
//                                 : Colors.grey),
//                         color: widget.finisedSections.contains(widget.index)
//                             ? c.primary
//                             : Colors.transparent),
//                     child: icon(widget.finisedSections.contains(widget.index)
//                         ? c.background
//                         : Colors.grey),
//                   ),
//                   SizedBox(width: size.width * 0.06),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text('PASO ${widget.index + 1}', style: t.textDisabled2),
//                       SizedBox(
//                         width: size.width * 0.6,
//                         child: Text(widget.type,
//                             style: widget.finisedSections.contains(widget.index)
//                                 ? t.mediumBold
//                                 : t.mediumDisabled,
//                             maxLines: 3,
//                             overflow: TextOverflow.ellipsis),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),

//               widget.isLast
//                   ? Container()
//                   : Padding(
//                       padding: EdgeInsets.only(
//                           left: size.width * 0.14, top: size.width * 0.01),
//                       child: Container(
//                         color: widget.finisedSections.contains(widget.index)
//                             ? c.primary
//                             : c.disabled.withOpacity(0.2),
//                         height: size.height * 0.06,
//                         width: size.width * 0.01,
//                       ),
//                     )

//               //
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget icon(Color color) {
//     final Map<String, Icon> icons = {
//       'Pregunta demo abierta': Icon(Icons.question_answer, color: color),
//       'Pregunta demo numérica': Icon(Icons.numbers, color: color),
//       'Pregunta demo decimal (con limite minimo 5 y maximo 10)':
//           Icon(Icons.numbers, color: color),
//       'Pregunta demo si o no': Icon(Icons.done, color: color),
//       'Pregunta demo de opción multiple con 1 selección':
//           Icon(Icons.list, color: color),
//       'Pregunta demo de opción multiple con N selecciones':
//           Icon(Icons.list, color: color),
//       '--Pregunta informativa--': Icon(Icons.info, color: color),
//       'Pregunta demo fotográfica': Icon(Icons.camera, color: color),
//       'Pregunta demo GPS': Icon(Icons.gps_fixed, color: color),
//       'Pregunta demo de 3 tiempos con el cronómetro.':
//           Icon(Icons.timer, color: color),
//       'Pregunta demo imágen': Icon(Icons.image, color: color),
//       'Pregunta demo de firma': Icon(Icons.draw, color: color),
//       'Pregunta demo fecha': Icon(Icons.date_range, color: color),
//       'Pregunta demo fecha y hora': Icon(Icons.date_range, color: color),
//       'Pregunta demo hora': Icon(Icons.timer_outlined, color: color),
//       'ESCANEA EL CÓDIGO': Icon(Icons.qr_code, color: color),
//     };

//     return icons[widget.type] ?? Icon(Icons.question_answer, color: color);
//   }

//   @override
//   bool get wantKeepAlive => true;
// }
