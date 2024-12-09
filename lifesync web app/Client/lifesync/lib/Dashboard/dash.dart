import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:lifesync/Utils/theme.dart';

class DrugSearchPage extends StatefulWidget {
  const DrugSearchPage({super.key});

  @override
  _DrugSearchPageState createState() => _DrugSearchPageState();
}

class _DrugSearchPageState extends State<DrugSearchPage> {
  // Controller for the search text field
  final TextEditingController _searchController = TextEditingController();

  // List of drugs to be filtered
  final List<Drug> _drugs = [
    Drug('Aspirin', 5, 'Low'),
    Drug('Metformin', 10, 'Moderate'),
    Drug('Atorvastatin', 20, 'High'),
    Drug('Ibuprofen', 7, 'Low'),
    Drug('Lisinopril', 15, 'Moderate'),
  ];

  // Filtered list of drugs based on search
  List<Drug> _filteredDrugs = [];

  @override
  void initState() {
    super.initState();
    _filteredDrugs = _drugs;
  }

  void _filterDrugs(String query) {
    setState(() {
      _filteredDrugs = _drugs
          .where(
              (drug) => drug.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Search Container
          BlurryContainer(
            blur: 15,
            elevation: 5,
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Enter Drug Name',
                    style: AppTheme.subsubsubheading,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for a drug...',
                      hintStyle: AppTheme.bodyText,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () => _filterDrugs(_searchController.text),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSubmitted: _filterDrugs,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Drug Results Table
          Expanded(
            child: SingleChildScrollView(
              child: BlurryContainer(
                  blur: 15,
                  elevation: 5,
                  color: Colors.transparent,
                  //borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: DrugTable(drugs: _filteredDrugs)),
            ),
          ),
        ],
      ),
    );
  }
}

class DrugTable extends StatelessWidget {
  final List<Drug> drugs;

  const DrugTable({super.key, required this.drugs});

  @override
  Widget build(BuildContext context) {
    return drugs.isEmpty
        ? Center(
            child: Text(
              'No drugs found',
              style: AppTheme.subheading,
            ),
          )
        : DataTable(
            columns: [
              DataColumn(
                label: Text(
                  'Drug Name',
                  style: AppTheme.subsubsubheading,
                ),
              ),
              DataColumn(
                label: Text(
                  'Cost',
                  style: AppTheme.subsubsubheading,
                ),
              ),
              DataColumn(
                label: Text(
                  'Risk',
                  style: AppTheme.subsubsubheading,
                ),
              ),
            ],
            rows: drugs
                .map(
                  (drug) => DataRow(
                    cells: [
                      DataCell(Text(
                        drug.name,
                        style: AppTheme.bodybodyText,
                      )),
                      DataCell(Text(
                        '\$${drug.cost}',
                        style: AppTheme.bodybodyText,
                      )),
                      DataCell(Text(
                        drug.risk,
                        style: AppTheme.bodybodyText,
                      )),
                    ],
                  ),
                )
                .toList(),
          );
  }
}

// Drug model class
class Drug {
  final String name;
  final int cost;
  final String risk;

  Drug(this.name, this.cost, this.risk);
}
