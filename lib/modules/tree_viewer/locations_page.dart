import 'package:factory_tree_viewer/modules/fake_service/fake_service.dart';
import 'package:factory_tree_viewer/modules/fake_service/model/company.dart';
import 'package:factory_tree_viewer/modules/shared/metrics.dart';
import 'package:factory_tree_viewer/modules/shared/tractian_app_bar.dart';
import 'package:factory_tree_viewer/modules/tree_viewer/company_card.dart';
import 'package:flutter/material.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  final FakeService fakeService = FakeService();
  Future<List<Company>?> companies = Future.delayed(const Duration(hours: 1));

  @override
  void initState() {
    super.initState();
    companies = fakeService.getCompanies();
  }

  Future<void> onRefreshHandler() async {
    companies = fakeService.getCompanies();
    await companies;
  }

  void handleCompanyClick(Company company) {
    Navigator.pushNamed(
      context,
      '/company',
      arguments: {
        'company': company.toJson(),
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractianAppBar(context),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: onRefreshHandler,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppMetrics.defaultSpacing,
              vertical: AppMetrics.defaultSpacing * 1.5,
            ),
            child: FutureBuilder(
                future: companies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "There was an error while trying to load companies.",
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppMetrics.defaultSpacing),
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  companies = fakeService.getCompanies();
                                });
                              },
                              child: const Text('Try again'),
                            )
                          ],
                        ),
                      );
                    }
                    if (snapshot.data != null && snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("There are no companies."),
                      );
                    } else {
                      final List<Company> companies = snapshot.data!;
                      return ListView.builder(
                        itemCount: companies.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: index == companies.length - 1
                                ? EdgeInsets.zero
                                : const EdgeInsets.only(
                                    bottom: 2 * AppMetrics.defaultSpacing,
                                  ),
                            child: CompanyCard(
                              onTap: () => handleCompanyClick(companies[index]),
                              name: companies[index].name,
                            ),
                          );
                        },
                      );
                    }
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
