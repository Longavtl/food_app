// import 'dart:async';

// import 'package:coresystem/Components/base_component.dart';
// import 'package:coresystem/Components/google_map/autocomplete_search.dart';
// import 'package:coresystem/Components/google_map/autocomplete_search_controller.dart';
// import 'package:coresystem/Components/google_map/google_map_place_picker.dart';
// import 'package:coresystem/Components/google_map/pick_result.dart';
// import 'package:coresystem/Components/google_map/place_provider.dart';
// import 'package:coresystem/Components/google_map/uuid.dart';
// import 'package:coresystem/Components/skin/color_skin.dart';
// import 'package:coresystem/Components/skin/typo_skin.dart';
// import 'package:coresystem/Project/SFA/Page/Map/PickerMap.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_api_headers/google_api_headers.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:google_maps_place_picker/google_maps_place_picker.dart';
// // import 'package:google_maps_place_picker/providers/place_provider.dart';
// // import 'package:google_maps_place_picker/src/autocomplete_search.dart';
// // import 'package:google_maps_place_picker/src/controllers/autocomplete_search_controller.dart';
// // import 'package:google_maps_place_picker/src/google_map_place_picker.dart';
// // import 'package:google_maps_place_picker/src/utils/uuid.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:http/http.dart';
// import 'package:provider/provider.dart';
// import 'dart:io' show Platform;

// enum FPinState { Preparing, Idle, Dragging }
// enum FSearchingState { Idle, Searching }

// class FPlacePicker extends StatefulWidget {
//   FPlacePicker({
//     Key key,
//     @required this.apiKey,
//     this.onPlacePicked,
//     @required this.initialPosition,
//     this.useCurrentLocation,
//     this.desiredLocationAccuracy = LocationAccuracy.high,
//     this.onMapCreated,
//     this.hintText,
//     this.searchingText,
//     // this.searchBarHeight,
//     // this.contentPadding,
//     this.onAutoCompleteFailed,
//     this.onGeocodingSearchFailed,
//     this.proxyBaseUrl,
//     this.httpClient,
//     this.selectedPlaceWidgetBuilder,
//     this.pinBuilder,
//     this.autoCompleteDebounceInMilliseconds = 500,
//     this.cameraMoveDebounceInMilliseconds = 750,
//     this.initialMapType = MapType.normal,
//     this.enableMapTypeButton = true,
//     this.enableMyLocationButton = true,
//     this.myLocationButtonCooldown = 10,
//     this.usePinPointingSearch = true,
//     this.usePlaceDetailSearch = false,
//     this.autocompleteOffset,
//     this.autocompleteRadius,
//     this.autocompleteLanguage,
//     this.autocompleteComponents,
//     this.autocompleteTypes,
//     this.strictbounds,
//     this.region,
//     this.selectInitialPosition = false,
//     this.resizeToAvoidBottomInset = true,
//     this.initialSearchString,
//     this.searchForInitialValue = false,
//     this.forceAndroidLocationManager = false,
//     this.forceSearchOnZoomChanged = false,
//     this.automaticallyImplyAppBarLeading = true,
//     this.autocompleteOnTrailingWhitespace = false,
//     this.hidePlaceDetailsWhenDraggingPin = true,
//     this.searchOnly = false,
//   }) : super(key: key);

//   final bool searchOnly;
//   final String apiKey;

//   final LatLng initialPosition;
//   final bool useCurrentLocation;
//   final LocationAccuracy desiredLocationAccuracy;

//   final MapCreatedCallback onMapCreated;

//   final String hintText;
//   final String searchingText;
//   // final double searchBarHeight;
//   // final EdgeInsetsGeometry contentPadding;

//   final ValueChanged<String> onAutoCompleteFailed;
//   final ValueChanged<String> onGeocodingSearchFailed;
//   final int autoCompleteDebounceInMilliseconds;
//   final int cameraMoveDebounceInMilliseconds;

//   final MapType initialMapType;
//   final bool enableMapTypeButton;
//   final bool enableMyLocationButton;
//   final int myLocationButtonCooldown;

//   final bool usePinPointingSearch;
//   final bool usePlaceDetailSearch;

//   final num autocompleteOffset;
//   final num autocompleteRadius;
//   final String autocompleteLanguage;
//   final List<String> autocompleteTypes;
//   final List<Component> autocompleteComponents;
//   final bool strictbounds;
//   final String region;

//   /// If true the [body] and the scaffold's floating widgets should size
//   /// themselves to avoid the onscreen keyboard whose height is defined by the
//   /// ambient [MediaQuery]'s [MediaQueryData.viewInsets] `bottom` property.
//   ///
//   /// For example, if there is an onscreen keyboard displayed above the
//   /// scaffold, the body can be resized to avoid overlapping the keyboard, which
//   /// prevents widgets inside the body from being obscured by the keyboard.
//   ///
//   /// Defaults to true.
//   final bool resizeToAvoidBottomInset;

//   final bool selectInitialPosition;

//   /// By using default setting of Place Picker, it will result result when user hits the select here button.
//   ///
//   /// If you managed to use your own [selectedPlaceWidgetBuilder], then this WILL NOT be invoked, and you need use data which is
//   /// being sent with [selectedPlaceWidgetBuilder].
//   final ValueChanged<FPickResult> onPlacePicked;

//   /// optional - builds selected place's UI
//   ///
//   /// It is provided by default if you leave it as a null.
//   /// INPORTANT: If this is non-null, [onPlacePicked] will not be invoked, as there will be no default 'Select here' button.
//   final FSelectedPlaceWidgetBuilder selectedPlaceWidgetBuilder;

//   /// optional - builds customized pin widget which indicates current pointing position.
//   ///
//   /// It is provided by default if you leave it as a null.
//   final PinBuilder pinBuilder;

//   /// optional - sets 'proxy' value in google_maps_webservice
//   ///
//   /// In case of using a proxy the baseUrl can be set.
//   /// The apiKey is not required in case the proxy sets it.
//   /// (Not storing the apiKey in the app is good practice)
//   final String proxyBaseUrl;

//   /// optional - set 'client' value in google_maps_webservice
//   ///
//   /// In case of using a proxy url that requires authentication
//   /// or custom configuration
//   final BaseClient httpClient;

//   /// Initial value of autocomplete search
//   final String initialSearchString;

//   /// Whether to search for the initial value or not
//   final bool searchForInitialValue;

//   /// On Android devices you can set [forceAndroidLocationManager]
//   /// to true to force the plugin to use the [LocationManager] to determine the
//   /// position instead of the [FusedLocationProviderClient]. On iOS this is ignored.
//   final bool forceAndroidLocationManager;

//   /// Allow searching place when zoom has changed. By default searching is disabled when zoom has changed in order to prevent unwilling API usage.
//   final bool forceSearchOnZoomChanged;

//   /// Whether to display appbar backbutton. Defaults to true.
//   final bool automaticallyImplyAppBarLeading;

//   /// Will perform an autocomplete search, if set to true. Note that setting
//   /// this to true, while providing a smoother UX experience, may cause
//   /// additional unnecessary queries to the Places API.
//   ///
//   /// Defaults to false.
//   final bool autocompleteOnTrailingWhitespace;

//   final bool hidePlaceDetailsWhenDraggingPin;

//   @override
//   _FPlacePickerState createState() => _FPlacePickerState();
// }

// class _FPlacePickerState extends State<FPlacePicker> {
//   GlobalKey appBarKey = GlobalKey();
//   Future<FPlaceProvider> _futureProvider;
//   FPlaceProvider provider;
//   FSearchBarController searchBarController = FSearchBarController();

//   @override
//   void initState() {
//     super.initState();

//     _futureProvider = _initPlaceProvider();
//   }

//   @override
//   void dispose() {
//     searchBarController.dispose();

//     super.dispose();
//   }

//   Future<FPlaceProvider> _initPlaceProvider() async {
//     final headers = await GoogleApiHeaders().getHeaders();
//     final provider = FPlaceProvider(
//       widget.apiKey,
//       widget.proxyBaseUrl,
//       widget.httpClient,
//       headers,
//     );
//     provider.sessionToken = FUuid().generateV4();
//     provider.desiredAccuracy = widget.desiredLocationAccuracy;
//     provider.setMapType(widget.initialMapType);

//     return provider;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () {
//         searchBarController.clearOverlay();
//         return Future.value(true);
//       },
//       child: FutureBuilder<FPlaceProvider>(
//         future: _futureProvider,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             provider = snapshot.data;

//             return MultiProvider(
//               providers: [
//                 ChangeNotifierProvider<FPlaceProvider>.value(value: provider),
//               ],
//               child: Scaffold(
//                 key: ValueKey<int>(provider.hashCode),
//                 resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
//                 extendBodyBehindAppBar: true,
//                 appBar: AppBar(
//                   key: appBarKey,
//                   automaticallyImplyLeading: false,
//                   iconTheme: Theme.of(context).iconTheme,
//                   elevation: 0,
//                   actions: [
//                     widget.searchOnly == true
//                         ? FFilledButton(
//                           backgroundColor: FColorSkin.transparent,
//                           onPressed: () {
//                             Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => PickerMap(),
//                                 ));
//                           },
//                           child: SvgPicture.asset(
//                             'assets/map.svg',
//                             color: Colors.black,
//                             height: 20,
//                             width: 20,
//                           ),
//                         )
//                         : SizedBox(),
//                   ],
//                   backgroundColor: FColorSkin.onColorBackground,
//                   // titleSpacing: 0.0,
//                   leading: FFilledButton.icon(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     backgroundColor: FColorSkin.transparent,
//                     child: FIcon(
//                       icon: FOutlined.left,
//                     ),
//                   ),
//                   title: Text(
//                     'Chọn địa chỉ',
//                     style: FTypoSkin.title3.copyWith(color: FColorSkin.title),
//                   ),
//                   centerTitle: true,
//                   bottom: widget.searchOnly == true
//                       ? PreferredSize(
//                           preferredSize: Size.fromHeight(kToolbarHeight),
//                           child: Container(
//                               padding: EdgeInsets.only(bottom: 8),
//                               child: _buildSearchBar(context)))
//                       : PreferredSize(
//                           preferredSize: Size.fromHeight(0),
//                           child: SizedBox(),
//                         ),
//                 ),
//                 body: widget.searchOnly == true
//                     ? SizedBox()
//                     : _buildMapWithLocation(),
//               ),
//             );
//           }

//           final children = <Widget>[];
//           if (snapshot.hasError) {
//             children.addAll([
//               Icon(
//                 Icons.error_outline,
//                 color: Theme.of(context).errorColor,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 16),
//                 child: Text('Error: ${snapshot.error}'),
//               )
//             ]);
//           } else {
//             children.add(CircularProgressIndicator());
//           }

//           return Scaffold(
//             body: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: children,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildSearchBar(BuildContext context) {
//     return Row(
//       children: <Widget>[
//         // widget.automaticallyImplyAppBarLeading
//         //     ? IconButton(
//         //         onPressed: () => Navigator.maybePop(context),
//         //         icon: Icon(
//         //           Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
//         //         ),
//         //         padding: EdgeInsets.zero)
//         //     : SizedBox(width: 15),
//         Expanded(
//           child: FAutoCompleteSearch(
//               appBarKey: appBarKey,
//               searchBarController: searchBarController,
//               sessionToken: provider.sessionToken,
//               hintText: widget.hintText,
//               searchingText: widget.searchingText,
//               debounceMilliseconds: widget.autoCompleteDebounceInMilliseconds,
//               onPicked: (prediction) {
//                 _pickPrediction(prediction);
//               },
//               onSearchFailed: (status) {
//                 if (widget.onAutoCompleteFailed != null) {
//                   widget.onAutoCompleteFailed(status);
//                 }
//               },
//               autocompleteOffset: widget.autocompleteOffset,
//               autocompleteRadius: widget.autocompleteRadius,
//               autocompleteLanguage: widget.autocompleteLanguage,
//               autocompleteComponents: widget.autocompleteComponents,
//               autocompleteTypes: widget.autocompleteTypes,
//               strictbounds: widget.strictbounds,
//               region: widget.region,
//               initialSearchString: widget.initialSearchString,
//               searchForInitialValue: widget.searchForInitialValue,
//               autocompleteOnTrailingWhitespace:
//                   widget.autocompleteOnTrailingWhitespace),
//         ),
//         SizedBox(width: 5),
//       ],
//     );
//   }

//   _pickPrediction(Prediction prediction) async {
//     provider.placeSearchingState = FSearchingState.Searching;

//     final PlacesDetailsResponse response =
//         await provider.places.getDetailsByPlaceId(
//       prediction.placeId,
//       sessionToken: provider.sessionToken,
//       language: widget.autocompleteLanguage,
//     );

//     if (response.errorMessage?.isNotEmpty == true ||
//         response.status == "REQUEST_DENIED") {
//       if (widget.onAutoCompleteFailed != null) {
//         widget.onAutoCompleteFailed(response.status);
//       }
//       return;
//     } else {
//       provider.selectedPlace =
//           FPickResult.fromPlaceDetailResult(response.result);
//       await Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PickerMap(
//                 lat: provider.selectedPlace.geometry.location.lat,
//                 lon: provider.selectedPlace.geometry.location.lng),
//           ));
//     }

//     provider.selectedPlace = FPickResult.fromPlaceDetailResult(response.result);

//     // Prevents searching again by camera movement.
//     provider.isAutoCompleteSearching = true;

//     await _moveTo(provider.selectedPlace.geometry.location.lat,
//         provider.selectedPlace.geometry.location.lng);

//     provider.placeSearchingState = FSearchingState.Idle;
//   }

//   _moveTo(double latitude, double longitude) async {
//     GoogleMapController controller = provider.mapController;
//     if (controller == null) return;

//     await controller.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: LatLng(latitude, longitude),
//           zoom: 16,
//         ),
//       ),
//     );
//   }

//   _moveToCurrentPosition() async {
//     if (provider.currentPosition != null) {
//       await _moveTo(provider.currentPosition.latitude,
//           provider.currentPosition.longitude);
//     }
//   }

//   Widget _buildMapWithLocation() {
//     if (widget.useCurrentLocation) {
//       return FutureBuilder(
//           future: provider
//               .updateCurrentLocation(widget.forceAndroidLocationManager),
//           builder: (context, snap) {
//             if (snap.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else {
//               if (provider.currentPosition == null) {
//                 return _buildMap(widget.initialPosition);
//               } else {
//                 if(widget.initialPosition != null){
//                   return _buildMap(widget.initialPosition);
//                 }
//                 return _buildMap(LatLng(widget.initialPosition.latitude, widget.initialPosition.longitude));
//               }
//             }
//           });
//     } else {
//       return FutureBuilder(
//         future: Future.delayed(Duration(milliseconds: 1)),
//         builder: (context, snap) {
//           if (snap.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else {
//             return _buildMap(widget.initialPosition);
//           }
//         },
//       );
//     }
//   }

//   Widget _buildMap(LatLng initialTarget) {
//     return FGoogleMapPlacePicker(
//       initialTarget: initialTarget,
//       appBarKey: appBarKey,
//       selectedPlaceWidgetBuilder: widget.selectedPlaceWidgetBuilder,
//       pinBuilder: widget.pinBuilder,
//       onSearchFailed: widget.onGeocodingSearchFailed,
//       debounceMilliseconds: widget.cameraMoveDebounceInMilliseconds,
//       enableMapTypeButton: widget.enableMapTypeButton,
//       enableMyLocationButton: widget.enableMyLocationButton,
//       usePinPointingSearch: widget.usePinPointingSearch,
//       usePlaceDetailSearch: widget.usePlaceDetailSearch,
//       onMapCreated: widget.onMapCreated,
//       selectInitialPosition: widget.selectInitialPosition,
//       language: widget.autocompleteLanguage,
//       forceSearchOnZoomChanged: widget.forceSearchOnZoomChanged,
//       hidePlaceDetailsWhenDraggingPin: widget.hidePlaceDetailsWhenDraggingPin,
//       onToggleMapType: () {
//         provider.switchMapType();
//       },
//       onMyLocation: () async {
//         // Prevent to click many times in short period.
//         if (provider.isOnUpdateLocationCooldown == false) {
//           provider.isOnUpdateLocationCooldown = true;
//           Timer(Duration(seconds: widget.myLocationButtonCooldown), () {
//             provider.isOnUpdateLocationCooldown = false;
//           });
//           await provider
//               .updateCurrentLocation(widget.forceAndroidLocationManager);
//           await _moveToCurrentPosition();
//         }
//       },
//       onMoveStart: () {
//         // searchBarController.reset();
//       },
//       onPlacePicked: widget.onPlacePicked,
//     );
//   }
// }
