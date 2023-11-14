import 'package:animate_do/animate_do.dart';
import 'package:emetrix_flutter/app/ui/modules/route_of_the_day/controller.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomSearchDelegate extends SearchDelegate<SondeosFromStore?> {
  CustomSearchDelegate({
    required this.sondeos,
    required this.ref,
  });
  final List<SondeosFromStore> sondeos;
  final WidgetRef ref;
  List<SondeosFromStore> matchQuery = [];

//Hint Text
  @override
  String get searchFieldLabel => 'Buscar';

//BuildActions
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        FadeIn(
            child: IconButton(
          onPressed: () => query = '',
          icon: const Icon(Icons.clear),
        )),
    ];
  }

//BuildLeading
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
  }

//BuildResults
  @override
  Widget buildResults(BuildContext context) {
    matchQuery = sondeos.where((element) {
      final result = element.store?.tienda?.toLowerCase() ?? '';
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    if (query.isEmpty) {
      matchQuery = [];
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () => _getSondeoFromAStore(context, index),
          minVerticalPadding: 0,
          leading: Icon(Icons.storefront_outlined, color: c.primary500),
          title: Text('${matchQuery[index].store?.tienda}',
              style: t.mediumBold,
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
          subtitle: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cadena: ${matchQuery[index].store?.idCadena}',
                    style: t.text),
                const SizedBox(width: 10),
                Text('Grupo: ${matchQuery[index].store?.idGrupo}',
                    style: t.text),
              ]),
        );
      },
    );
  }

//BuildSuggestions
  @override
  Widget buildSuggestions(BuildContext context) {
    matchQuery = sondeos.where((element) {
      final result = element.store?.tienda?.toLowerCase() ?? '';
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    if (query.isEmpty) {
      matchQuery = [];
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return FadeIn(
          child: ListTile(
            onTap: () => _getSondeoFromAStore(context, index),
            minVerticalPadding: 0,
            leading: Icon(Icons.storefront_outlined, color: c.primary500),
            title: Text('${matchQuery[index].store?.tienda}',
                style: t.mediumBold,
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
            subtitle: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cadena: ${matchQuery[index].store?.idCadena}',
                      style: t.text),
                  const SizedBox(width: 10),
                  Text('Grupo: ${matchQuery[index].store?.idGrupo}',
                      style: t.text),
                ]),
          ),
        );
      },
    );
  }

//------
  Future<void> _getSondeoFromAStore(BuildContext context, int index) async {
    final navigator = Navigator.of(context);
    final sondeos2 = await ref.read(routeOTD.notifier).getSondeoFromDB();
    final currentElement = matchQuery[index];
    final index2 = sondeos.indexOf(currentElement);

    if (sondeos2[index2].idError != 0) {
      if (!context.mounted) return;
      showYesNoMsj(
          context: context,
          yesOnly: true,
          title: 'Error',
          content:
              'Se produjo un error inesperado. Si el error persiste, elimina las tiendas e intentalo de nuevo.');
    } else {
      navigator.pop();
      navigator.push(MaterialPageRoute(builder: (context) {
        return SondeoPage(
            storeUuid: matchQuery[index].uuid ?? '',
            sondeosList: sondeos2[index2].resp ?? [],
            store: matchQuery[index].store ?? Store2());
      }));
    }
  }
}
