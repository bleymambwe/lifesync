import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import '../Utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../stateprovider.dart';
import '../Utils/theme.dart'; // Import your StateProvider file

class DrugTableX extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StateProvider>(
      builder: (context, stateProvider, child) {
        final substitutes = stateProvider.potentialSubstitutes;

        if (substitutes.isEmpty) {
          return Center(
            child: Text(
              'Loading ... or No drug substitutes found ',
              style: TextStyle(color: Colors.green, fontSize: 16),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DataTable(
                columns: [
                  DataColumn(
                    label: Text(
                      'Substance Name',
                      style: AppTheme.subsubsubheading,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Brand Names',
                      style: AppTheme.subsubsubheading,
                    ),
                  ),
                ],
                rows: substitutes.map((drug) {
                  final substanceName = drug['substance_name'] ?? 'Unknown';
                  final brandNames =
                      (drug['brand_names'] as List?)?.join(', ') ??
                          'No brands available';

                  return DataRow(
                    cells: [
                      DataCell(BlurryContainer(
                        blur: 15,
                        elevation: 5,
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: Text(
                          substanceName,
                          style: AppTheme.bodyText,
                        ),
                      )),
                      DataCell(BlurryContainer(
                        blur: 15,
                        elevation: 5,
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: Text(
                          brandNames,
                          style: AppTheme.bodyText,
                        ),
                      )),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
