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
              'No drug substitutes found',
              style: TextStyle(color: Colors.grey, fontSize: 16),
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

class DrugSubstituteTable extends StatefulWidget {
  final List<dynamic>? substitutes;

  const DrugSubstituteTable({Key? key, this.substitutes}) : super(key: key);

  @override
  _DrugSubstituteTableState createState() => _DrugSubstituteTableState();
}

class _DrugSubstituteTableState extends State<DrugSubstituteTable> {
  List<Map<String, dynamic>> _processedSubstitutes = [];

  @override
  void initState() {
    super.initState();
    _processSubstitutes();
  }

  @override
  void didUpdateWidget(DrugSubstituteTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.substitutes != widget.substitutes) {
      _processSubstitutes();
    }
  }

  void _processSubstitutes() {
    // If no substitutes or null, set to empty list
    if (widget.substitutes == null) {
      setState(() => _processedSubstitutes = []);
      return;
    }

    // Process and deduplicate substitutes
    final processedList = _preprocessSubstitutes(widget.substitutes!);

    setState(() {
      _processedSubstitutes = processedList;
    });
  }

  List<Map<String, dynamic>> _preprocessSubstitutes(List<dynamic> substitutes) {
    // Set to keep track of unique substance names
    final uniqueSubstances = <String, Map<String, dynamic>>{};

    for (final item in substitutes) {
      // Handle different input types
      Map<String, dynamic> processedItem = {};

      if (item is Map) {
        // Convert Map<dynamic, dynamic> to Map<String, dynamic>
        processedItem = Map<String, dynamic>.from(item);
      } else if (item is Map<String, dynamic>) {
        processedItem = item;
      } else {
        // Skip items that can't be processed
        continue;
      }

      // Extract substance name and brand names
      final substanceName = _extractString(processedItem, 'substance_name') ??
          _extractString(processedItem, 'substanceName') ??
          'Unknown Substance';

      final brandNames = _extractBrandNames(processedItem);

      // Only add if substance name is meaningful
      if (substanceName != 'Unknown Substance') {
        // Keep the first occurrence of each unique substance
        if (!uniqueSubstances.containsKey(substanceName)) {
          uniqueSubstances[substanceName] = {
            'substanceName': substanceName,
            'brandNames': brandNames,
          };
        }
      }
    }

    // Convert to list and return
    return uniqueSubstances.values.toList();
  }

  String? _extractString(Map<String, dynamic> item, String key) {
    final value = item[key];
    return value is String ? value.trim() : null;
  }

  String _extractBrandNames(Map<String, dynamic> item) {
    dynamic brandNames = item['brand_names'] ?? item['brandNames'];

    if (brandNames == null) return 'No brands available';

    if (brandNames is List) {
      // Remove duplicates and empty strings
      final uniqueBrands = brandNames
          .where((brand) => brand is String && brand.trim().isNotEmpty)
          .toSet()
          .toList();

      return uniqueBrands.isEmpty
          ? 'No brands available'
          : uniqueBrands.join(', ');
    }

    if (brandNames is String) {
      return brandNames.trim().isEmpty ? 'No brands available' : brandNames;
    }

    return 'No brands available';
  }

  @override
  Widget build(BuildContext context) {
    // If no processed substitutes, show a message
    if (_processedSubstitutes.isEmpty) {
      return Center(
        child: Text(
          'No drug substitutes found',
          style: AppTheme.subheadingtitle,
        ),
      );
    }

    // Build the data table
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
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
        rows: _processedSubstitutes.map((substitute) {
          return DataRow(
            cells: [
              DataCell(
                Text(
                  substitute['substanceName'] ?? 'Unknown',
                  style: AppTheme.bodybodyText,
                ),
              ),
              DataCell(
                Text(
                  substitute['brandNames'] ?? 'No brands',
                  style: AppTheme.bodybodyText,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
