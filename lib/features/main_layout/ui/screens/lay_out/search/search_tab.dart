import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../../generated/assets.dart';
import '../../../widgets/movie_card.dart';

class SearchTab extends StatefulWidget {
  SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  bool _isSearching = false;

  List movies = [];
  //from cubit
  List searchedMovies = [];
  //filtered
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 22,
        ),
        _buildSearchField(),
        _isSearching
            ? _searchedItemGrid()
            : Expanded(child: Image.asset(Assets.imagesEmpty))
      ],
    );
  }

  Widget _searchedItemGrid() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        itemCount: 20,
        itemBuilder: (context, index) => Text("data"),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      height: 56,
      margin: const EdgeInsets.all(14),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xff282A28),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10.0, right: 8),
            child: Icon(
              FontAwesomeIcons.searchengin,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "search",
                hintStyle: TextStyle(color: Colors.white),
              ),
              onChanged: (searchedMovie) {
                _searchFor(searchedMovie);
              },
            ),
          )
        ],
      ),
    );
  }

  void _searchFor(String movieName) {
    searchedMovies = movies.where((movie) {
      return movie.toString().toLowerCase().startsWith(movieName[0]);
    }).toList();
    _startSearching();
  }

  void _startSearching() {
    _stopSearching();
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    if (_searchController.text.isEmpty) {
      _clearSearch();
      _isSearching = false;
      setState(() {});
    }
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {});
  }
}
