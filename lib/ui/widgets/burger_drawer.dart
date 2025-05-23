import 'package:flutter/material.dart';
import 'package:indoor_crowded_regions_frontend/ui/components/error_toast.dart';
import 'package:indoor_crowded_regions_frontend/ui/widgets/utils/types.dart';
import 'package:url_launcher/url_launcher.dart';
import 'exhibits_menu.dart';
import 'filter_page.dart';

class BurgerDrawer extends StatefulWidget {
  final void Function(String category) highlightedCategory;
  final Function(Future<List<DoorObject>> path) setPath;
  const BurgerDrawer(
      {super.key,
      this.highlightedCategory = _defaultHighlightedCategory,
      required this.setPath});
  static void _defaultHighlightedCategory(String category) {}
  @override
  State<BurgerDrawer> createState() => BurgerDrawerState();
}

class BurgerDrawerState extends State<BurgerDrawer> {
  bool showExhibitsMenu = false;

  void highlightedCategory(String category) {
    widget.highlightedCategory(category);
  }
  
  void setPath(Future<List<DoorObject>> path) {
    widget.setPath(path);
  }

  void showExhibitsMenuFunc(bool show) {
    setState(() {
      showExhibitsMenu = show;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1E1E1E), // Dark background for drawer
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: showExhibitsMenu
                  ? ExhibitsMenu(showExhibitsMenu: showExhibitsMenuFunc)
                  : ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.wc_rounded,
                              color: Color(
                                  0xFFFF7D00)), // Brighter orange for dark mode
                          title: const Text('Bathrooms',
                              style: TextStyle(
                                  color: Colors
                                      .white)), // Light text for dark mode
                          onTap: () => highlightedCategory("BATHROOM"),
                        ),
                        ListTile(
                          leading: const Icon(Icons.shopping_cart_outlined,
                              color: Color(
                                  0xFFFF7D00)), // Brighter orange for dark mode
                          title: const Text('Shops',
                              style: TextStyle(
                                  color: Colors
                                      .white)), // Light text for dark mode
                          onTap: () => highlightedCategory("SHOP"),
                        ),
                        ListTile(
                          leading: const Icon(Icons.food_bank_outlined,
                              color: Color(
                                  0xFFFF7D00)), // Brighter orange for dark mode
                          title: const Text('Food',
                              style: TextStyle(
                                  color: Colors
                                      .white)), // Light text for dark mode
                          onTap: () => highlightedCategory("FOOD"),
                        ),
                        ListTile(
                          leading: const Icon(Icons.location_on_outlined,
                              color: Color(
                                  0xFFFF7D00)), // Brighter orange for dark mode
                          title: const Text('Exhibits',
                              style: TextStyle(
                                  color: Colors
                                      .white)), // Light text for dark mode
                          onTap: () => setState(() {
                            showExhibitsMenu = true;
                          }),
                        ),
                        ListTile(
                          leading: const Icon(Icons.web,
                              color: Color(
                                  0xFFFF7D00)), // Brighter orange for dark mode
                          title: const Text('Website',
                              style: TextStyle(
                                  color: Colors
                                      .white)), // Light text for dark mode
                          onTap: () async {
                            try {
                              await launchUrl(Uri.parse('https://www.smk.dk/'));
                            } catch (e) {
                              ErrorToast.show("Failed to access website.");
                            }
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.location_on_outlined,
                              color: Color(
                                  0xFFFF7D00)), // Brighter orange for dark mode
                          title: const Text('Filter Search',
                              style: TextStyle(
                                  color: Colors
                                      .white)), // Light text for dark mode
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FilterPage(
                                setPath: setPath,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
