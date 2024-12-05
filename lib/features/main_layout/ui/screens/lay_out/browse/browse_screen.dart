import 'package:flutter/material.dart';
import '../../../widgets/custom_choice_chip.dart';
import '../../../widgets/movie_card.dart';

class BrowseScreen extends StatefulWidget {
  static const routeName = "Browse";
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 40, child: _buildCategoriesList()),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemCount: 20,
                itemBuilder: (context, index) => const MovieCard(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 9,
      itemBuilder: (context, index) => CustomChoiceChip(
          label: "Category", onSelected: () {}, isSelected: true),
    );
  }
}
