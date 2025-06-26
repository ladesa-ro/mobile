// import 'package:flutter/material.dart';
// import 'package:iconify_flutter/iconify_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:sisgha/app/core/utils/icones.dart';
// import 'package:sisgha/app/core/utils/colors.dart';
// import 'package:sisgha/app/core/utils/estilos.dart';
// import 'package:sisgha/app/core/utils/padroes.dart';
// import 'package:sisgha/app/providers/lista_eventos.dart';

// class CardsProfessor extends StatelessWidget {
//   const CardsProfessor({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double largura = Padroes.larguraGeral();
//     final provider = Provider.of<ListaEventos>(context);
//     final card = provider.teste;

//     return ListView.builder(
//       cacheExtent: 500,
//       physics: NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       padding: EdgeInsets.zero,
//       itemCount: card.length,
//       itemBuilder: (ctx, index) {
//         return Container(
//           margin: EdgeInsets.symmetric(
//             horizontal: 0,
//             vertical: 8,
//           ),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 4,
//                 offset: Offset(0, 2),
//               ),
//             ],
//             border: Border(
//               left: BorderSide(
//                 color: CoresClaras.roxo, // cor da borda
//                 width: 5, // a espreçura
//               ),
//             ),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.all(10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         card[index],
//                         style: estiloTexto(
//                           16,
//                           cor: CoresClaras.vermelho,
//                           peso: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 15),
//                       Text(card[index].inicio, style: estiloTexto(16)),
//                       Text(card[index].termino, style: estiloTexto(16)),
//                       Text(card[index].tempo, style: estiloTexto(16)),
//                       Text(card[index].local, style: estiloTexto(16)),
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(10),
//                 child: SizedBox(
//                   height: 45,
//                   width: largura * 0.115,
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     child: Iconify(Icones.sino),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// ButtonStyle estiloBotaoCard() {
//   return ButtonStyle(
//     padding: WidgetStatePropertyAll(EdgeInsets.zero),
//     backgroundColor: WidgetStatePropertyAll(CoresClaras.verdePrincipal),
//     shape: WidgetStatePropertyAll(
//       RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//     ),
//   );
// }
