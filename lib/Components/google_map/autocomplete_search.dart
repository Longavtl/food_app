// import 'dart:async';

// import 'package:coresystem/Components/base_component.dart';
// import 'package:coresystem/Components/google_map/autocomplete_search_controller.dart';
// import 'package:coresystem/Components/google_map/place_picker.dart';
// import 'package:coresystem/Components/google_map/place_provider.dart';
// import 'package:coresystem/Components/google_map/prediction_tile.dart';
// import 'package:coresystem/Components/google_map/rounded_frame.dart';
// import 'package:coresystem/Components/google_map/search_provider.dart';
// import 'package:coresystem/Components/skin/color_skin.dart';
// import 'package:coresystem/Components/widgets/icon.dart';
// import 'package:flutter/material.dart';
// // import 'package:google_maps_place_picker/google_maps_place_picker.dart';
// // import 'package:google_maps_place_picker/providers/place_provider.dart';
// // import 'package:google_maps_place_picker/providers/search_provider.dart';
// // import 'package:google_maps_place_picker/src/components/prediction_tile.dart';
// // import 'package:google_maps_place_picker/src/components/rounded_frame.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:provider/provider.dart';

// class FAutoCompleteSearch extends StatefulWidget {
//   const FAutoCompleteSearch(
//       {Key key,
//       @required this.sessionToken,
//       @required this.onPicked,
//       @required this.appBarKey,
//       this.hintText,
//       this.searchingText = "Searching...",
//       this.height = 40,
//       this.contentPadding = EdgeInsets.zero,
//       this.debounceMilliseconds,
//       this.onSearchFailed,
//       @required this.searchBarController,
//       this.autocompleteOffset,
//       this.autocompleteRadius,
//       this.autocompleteLanguage,
//       this.autocompleteComponents,
//       this.autocompleteTypes,
//       this.strictbounds,
//       this.region,
//       this.initialSearchString,
//       this.searchForInitialValue,
//       this.autocompleteOnTrailingWhitespace})
//       : assert(searchBarController != null),
//         super(key: key);

//   final String sessionToken;
//   final String hintText;
//   final String searchingText;
//   final double height;
//   final EdgeInsetsGeometry contentPadding;
//   final int debounceMilliseconds;
//   final ValueChanged<Prediction> onPicked;
//   final ValueChanged<String> onSearchFailed;
//   final FSearchBarController searchBarController;
//   final num autocompleteOffset;
//   final num autocompleteRadius;
//   final String autocompleteLanguage;
//   final List<String> autocompleteTypes;
//   final List<Component> autocompleteComponents;
//   final bool strictbounds;
//   final String region;
//   final GlobalKey appBarKey;
//   final String initialSearchString;
//   final bool searchForInitialValue;
//   final bool autocompleteOnTrailingWhitespace;

//   @override
//   FAutoCompleteSearchState createState() => FAutoCompleteSearchState();
// }

// class FAutoCompleteSearchState extends State<FAutoCompleteSearch> {
//   TextEditingController controller = TextEditingController();
//   FocusNode focus = FocusNode();
//   OverlayEntry overlayEntry;
//   FSearchProvider provider = FSearchProvider();

//   @override
//   void initState() {
//     super.initState();
//     if (widget.initialSearchString != null) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         controller.text = widget.initialSearchString;
//         if (widget.searchForInitialValue) {
//           _onSearchInputChange();
//         }
//       });
//     }
//     controller.addListener(_onSearchInputChange);
//     focus.addListener(_onFocusChanged);

//     widget.searchBarController.attach(this);
//   }

//   @override
//   void dispose() {
//     controller.removeListener(_onSearchInputChange);
//     controller.dispose();

//     focus.removeListener(_onFocusChanged);
//     focus.dispose();
//     _clearOverlay();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider.value(
//       value: provider,
//       child: FRoundedFrame(
//         height: widget.height,
//         padding: const EdgeInsets.only(left: 16, right: 16),
//         // color: Theme.of(context).brightness == Brightness.dark ? Colors.black54 : Colors.white,
//         color: FColorSkin.grey3_background,
//         borderRadius: BorderRadius.circular(12),
//         // elevation: 8.0,
//         child: Row(
//           children: <Widget>[
//             // SizedBox(width: 10),
//             // Icon(Icons.search),
//             SizedBox(width: 16),
//             Expanded(child: _buildSearchTextField()),
//             _buildTextClearIcon(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchTextField() {
//     return TextField(
//       autofocus: true,
//       controller: controller,
//       focusNode: focus,
//       decoration: InputDecoration(
//         hintText: widget.hintText,
//         border: InputBorder.none,
//         isDense: true,
//         contentPadding: widget.contentPadding,
//       ),
//     );
//   }

//   Widget _buildTextClearIcon() {
//     return Selector<FSearchProvider, String>(
//         selector: (_, provider) => provider.searchTerm,
//         builder: (_, data, __) {
//           if (data.length > 0) {
//             return Padding(
//               padding: const EdgeInsets.only(right: 0.0),
//               child: FFilledButton(
//                 // child: Icon(
//                 //   Icons.clear,
//                 //   color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
//                 // ),
//                 child: FIcon(
//                   icon: FFilled.close_circle,
//                   size: 14,
//                   color: FColorSkin.grey6_background,
//                 ),
//                 size: FButtonSize.size40,
//                 backgroundColor: FColorSkin.transparent,
//                 onPressed: () {
//                   clearText();
//                 },
//               ),
//             );
//           } else {
//             return SizedBox(width: 10);
//           }
//         });
//   }

//   _onSearchInputChange() {
//     if (!mounted) return;
//     this.provider.searchTerm = controller.text;

//     FPlaceProvider provider = FPlaceProvider.of(context, listen: false);

//     if (controller.text.isEmpty) {
//       provider.debounceTimer?.cancel();
//       _searchPlace(controller.text);
//       return;
//     }

//     if (controller.text.trim() == this.provider.prevSearchTerm.trim()) {
//       provider.debounceTimer?.cancel();
//       return;
//     }

//     if (!widget.autocompleteOnTrailingWhitespace && controller.text.substring(controller.text.length - 1) == " ") {
//       provider.debounceTimer?.cancel();
//       return;
//     }

//     if (provider.debounceTimer?.isActive ?? false) {
//       provider.debounceTimer.cancel();
//     }

//     provider.debounceTimer = Timer(Duration(milliseconds: widget.debounceMilliseconds), () {
//       _searchPlace(controller.text.trim());
//     });
//   }

//   _onFocusChanged() {
//     FPlaceProvider provider = FPlaceProvider.of(context, listen: false);
//     provider.isSearchBarFocused = focus.hasFocus;
//     provider.debounceTimer?.cancel();
//     provider.placeSearchingState = FSearchingState.Idle;
//   }

//   _searchPlace(String searchTerm) {
//     this.provider.prevSearchTerm = searchTerm;

//     if (context == null) return;

//     _clearOverlay();

//     if (searchTerm.length < 1) return;

//     _displayOverlay(_buildSearchingOverlay());

//     _performAutoCompleteSearch(searchTerm);
//   }

//   _clearOverlay() {
//     if (overlayEntry != null) {
//       overlayEntry.remove();
//       overlayEntry = null;
//     }
//   }

//   _displayOverlay(Widget overlayChild) {
//     _clearOverlay();

//     final RenderBox appBarRenderBox = widget.appBarKey.currentContext.findRenderObject() as RenderBox;
//     final screenWidth = MediaQuery.of(context).size.width;

//     overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         top: appBarRenderBox.size.height,
//         left: screenWidth * 0.025,
//         right: screenWidth * 0.025,
//         child: Material(
//           // elevation: 4.0,
//           child: overlayChild,
//         ),
//       ),
//     );

//     Overlay.of(context).insert(overlayEntry);
//   }

//   Widget _buildSearchingOverlay() {
//     return Container(
//       // padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
//       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//       child: Row(
//         children: <Widget>[
//           SizedBox(
//             height: 24,
//             width: 24,
//             child: CircularProgressIndicator(strokeWidth: 3),
//           ),
//           SizedBox(width: 24),
//           Expanded(
//             child: Text(
//               widget.searchingText ?? "Searching...",
//               style: TextStyle(fontSize: 16),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildPredictionOverlay(List<Prediction> predictions) {
//     return ListBody(
//       children: predictions
//           .map(
//             (p) => FPredictionTile(
//               prediction: p,
//               onTap: (selectedPrediction) {
//                 resetSearchBar();
//                 widget.onPicked(selectedPrediction);
//               },
//             ),
//           )
//           .toList(),
//     );
//   }

//   _performAutoCompleteSearch(String searchTerm) async {
//     FPlaceProvider provider = FPlaceProvider.of(context, listen: false);

//     if (searchTerm.isNotEmpty) {
//       final PlacesAutocompleteResponse response = await provider.places.autocomplete(
//         searchTerm,
//         sessionToken: widget.sessionToken,
//         location: provider.currentPosition == null ? null : Location(lat: provider.currentPosition.latitude, lng: provider.currentPosition.longitude),
//         offset: widget.autocompleteOffset,
//         radius: widget.autocompleteRadius,
//         language: widget.autocompleteLanguage,
//         types: widget.autocompleteTypes ?? const [],
//         components: widget.autocompleteComponents ?? const [],
//         strictbounds: widget.strictbounds ?? false,
//         region: widget.region,
//       );

//       if (response.errorMessage?.isNotEmpty == true || response.status == "REQUEST_DENIED") {
//         if (widget.onSearchFailed != null) {
//           widget.onSearchFailed(response.status);
//         }
//         return;
//       }

//       _displayOverlay(_buildPredictionOverlay(response.predictions));
//     }
//   }

//   clearText() {
//     provider.searchTerm = "";
//     controller.clear();
//   }

//   resetSearchBar() {
//     clearText();
//     focus.unfocus();
//   }

//   clearOverlay() {
//     _clearOverlay();
//   }
// }