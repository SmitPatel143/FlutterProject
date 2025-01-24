import "package:flutter/material.dart";

class customSearchBar extends StatefulWidget {
  const customSearchBar({super.key});

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<customSearchBar> {

  bool _isFocused = false;


  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 30),
        height: 100,
        width: 1 * MediaQuery.of(context).size.width,
        color: Colors.white,
        child: SearchBar(
          leading: Icon(
            Icons.search,
            color: _isFocused ? Colors.white : Colors.black,
          ),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            return _isFocused
                ? Color.fromRGBO(44, 42, 42, 1.0)
                : Colors.white;
          }),
          textStyle: WidgetStateProperty.resolveWith((states) {
            return TextStyle(
                color: _isFocused
                    ? Colors.white
                    : Colors.black
            );
          }),
          shadowColor: WidgetStateProperty.all(Colors.black),
          hintText: 'Search',
          hintStyle: WidgetStateProperty.resolveWith((states) {
            return TextStyle(
              color: _isFocused ? Colors.white70 : Colors.black,
            );
          }),
          elevation: WidgetStateProperty.all(8),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
              side: const BorderSide(color: Colors.black12),
            ),
          ),
          onTap: (){
            setState(() {
              _isFocused = true;
            });
          },
          onTapOutside: (PointerDownEvent event) {
            setState(() {
              _isFocused = false;
            });
          },
          onSubmitted: (_) {
            setState(() {
              _isFocused = false;
            });
          },

        ));
  }
}
