// import 'dart:async';

// import 'package:coresystem/Components/base_component.dart';
// import 'package:coresystem/Components/google_map/animated_pin.dart';
// import 'package:coresystem/Components/google_map/floating_cart.dart';
// import 'package:coresystem/Components/google_map/pick_result.dart';
// import 'package:coresystem/Components/google_map/place_picker.dart';
// import 'package:coresystem/Components/google_map/place_provider.dart';
// import 'package:coresystem/Components/skin/color_skin.dart';
// import 'package:coresystem/Project/SFA/Page/Map/BottomMap.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:google_maps_place_picker/google_maps_place_picker.dart';
// // import 'package:google_maps_place_picker/providers/place_provider.dart';
// // import 'package:google_maps_place_picker/src/components/animated_pin.dart';
// // import 'package:google_maps_place_picker/src/components/floating_card.dart';
// // import 'package:google_maps_place_picker/src/place_picker.dart';
// import 'package:google_maps_webservice/geocoding.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:provider/provider.dart';
// import 'package:tuple/tuple.dart';

// typedef FSelectedPlaceWidgetBuilder = Widget Function(
//   BuildContext context,
//   FPickResult selectedPlace,
//   FSearchingState state,
//   bool isSearchBarFocused,
// );

// typedef PinBuilder = Widget Function(
//   BuildContext context,
//   FPinState state,
// );

// class FGoogleMapPlacePicker extends StatelessWidget {
//   const FGoogleMapPlacePicker({
//     Key key,
//     @required this.initialTarget,
//     @required this.appBarKey,
//     this.selectedPlaceWidgetBuilder,
//     this.pinBuilder,
//     this.onSearchFailed,
//     this.onMoveStart,
//     this.onMapCreated,
//     this.debounceMilliseconds,
//     this.enableMapTypeButton,
//     this.enableMyLocationButton,
//     this.onToggleMapType,
//     this.onMyLocation,
//     this.onPlacePicked,
//     this.usePinPointingSearch,
//     this.usePlaceDetailSearch,
//     this.selectInitialPosition,
//     this.language,
//     this.forceSearchOnZoomChanged,
//     this.hidePlaceDetailsWhenDraggingPin,
//   }) : super(key: key);

//   final LatLng initialTarget;
//   final GlobalKey appBarKey;

//   final FSelectedPlaceWidgetBuilder selectedPlaceWidgetBuilder;
//   final PinBuilder pinBuilder;

//   final ValueChanged<String> onSearchFailed;
//   final VoidCallback onMoveStart;
//   final MapCreatedCallback onMapCreated;
//   final VoidCallback onToggleMapType;
//   final VoidCallback onMyLocation;
//   final ValueChanged<FPickResult> onPlacePicked;

//   final int debounceMilliseconds;
//   final bool enableMapTypeButton;
//   final bool enableMyLocationButton;

//   final bool usePinPointingSearch;
//   final bool usePlaceDetailSearch;

//   final bool selectInitialPosition;

//   final String language;

//   final bool forceSearchOnZoomChanged;
//   final bool hidePlaceDetailsWhenDraggingPin;

//   _searchByCameraLocation(FPlaceProvider provider) async {
//     // We don't want to search location again if camera location is changed by zooming in/out.
//     bool hasZoomChanged = provider.cameraPosition != null &&
//         provider.prevCameraPosition != null &&
//         provider.cameraPosition.zoom != provider.prevCameraPosition.zoom;

//     if (forceSearchOnZoomChanged == false && hasZoomChanged) {
//       provider.placeSearchingState = FSearchingState.Idle;
//       return;
//     }

//     provider.placeSearchingState = FSearchingState.Searching;

//     final GeocodingResponse response =
//         await provider.geocoding.searchByLocation(
//       Location(
//           lat: provider.cameraPosition.target.latitude,
//           lng: provider.cameraPosition.target.longitude),
//       language: language,
//     );

//     if (response.errorMessage?.isNotEmpty == true ||
//         response.status == "REQUEST_DENIED") {
//       print("Camera Location Search Error: " + response.errorMessage);
//       if (onSearchFailed != null) {
//         onSearchFailed(response.status);
//       }
//       provider.placeSearchingState = FSearchingState.Idle;
//       return;
//     }

//     if (usePlaceDetailSearch) {
//       final PlacesDetailsResponse detailResponse =
//           await provider.places.getDetailsByPlaceId(
//         response.results[0].placeId,
//         language: language,
//       );

//       if (detailResponse.errorMessage?.isNotEmpty == true ||
//           detailResponse.status == "REQUEST_DENIED") {
//         print("Fetching details by placeId Error: " +
//             detailResponse.errorMessage);
//         if (onSearchFailed != null) {
//           onSearchFailed(detailResponse.status);
//         }
//         provider.placeSearchingState = FSearchingState.Idle;
//         return;
//       }

//       provider.selectedPlace =
//           FPickResult.fromPlaceDetailResult(detailResponse.result);
//     } else {
//       provider.selectedPlace =
//           FPickResult.fromGeocodingResult(response.results[0]);
//     }

//     provider.placeSearchingState = FSearchingState.Idle;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         _buildGoogleMap(context),
//         _buildPin(),
//         _buildFloatingCard(),
//         _buildMapIcons(context),
//       ],
//     );
//   }

//   Widget _buildGoogleMap(BuildContext context) {
//     return Selector<FPlaceProvider, MapType>(
//         selector: (_, provider) => provider.mapType,
//         builder: (_, data, __) {
//           FPlaceProvider provider = FPlaceProvider.of(context, listen: false);
//           CameraPosition initialCameraPosition =
//               CameraPosition(target: initialTarget, zoom: 15);

//           return GoogleMap(
//             myLocationButtonEnabled: false,
//             compassEnabled: false,
//             mapToolbarEnabled: false,
//             initialCameraPosition: initialCameraPosition,
//             mapType: data,
//             myLocationEnabled: true,
//             onMapCreated: (GoogleMapController controller) {
//               provider.mapController = controller;
//               provider.setCameraPosition(null);
//               provider.pinState = FPinState.Idle;

//               // When select initialPosition set to true.
//               if (selectInitialPosition) {
//                 provider.setCameraPosition(initialCameraPosition);
//                 _searchByCameraLocation(provider);
//               }
//             },
//             onCameraIdle: () {
//               if (provider.isAutoCompleteSearching) {
//                 provider.isAutoCompleteSearching = false;
//                 provider.pinState = FPinState.Idle;
//                 return;
//               }

//               // Perform search only if the setting is to true.
//               if (usePinPointingSearch) {
//                 // Search current camera location only if camera has moved (dragged) before.
//                 if (provider.pinState == FPinState.Dragging) {
//                   // Cancel previous timer.
//                   if (provider.debounceTimer?.isActive ?? false) {
//                     provider.debounceTimer.cancel();
//                   }
//                   provider.debounceTimer =
//                       Timer(Duration(milliseconds: debounceMilliseconds), () {
//                     _searchByCameraLocation(provider);
//                   });
//                 }
//               }

//               provider.pinState = FPinState.Idle;
//             },
//             onCameraMoveStarted: () {
//               provider.setPrevCameraPosition(provider.cameraPosition);

//               // Cancel any other timer.
//               provider.debounceTimer?.cancel();

//               // Update state, dismiss keyboard and clear text.
//               provider.pinState = FPinState.Dragging;

//               // Begins the search state if the hide details is enabled
//               if (this.hidePlaceDetailsWhenDraggingPin) {
//                 provider.placeSearchingState = FSearchingState.Searching;
//               }

//               onMoveStart();
//             },
//             onCameraMove: (CameraPosition position) {
//               provider.setCameraPosition(position);
//             },
//             // gestureRecognizers make it possible to navigate the map when it's a
//             // child in a scroll view e.g ListView, SingleChildScrollView...
//             gestureRecognizers: Set()
//               ..add(Factory<EagerGestureRecognizer>(
//                   () => EagerGestureRecognizer())),
//           );
//         });
//   }

//   Widget _buildPin() {
//     return Center(
//       child: Selector<FPlaceProvider, FPinState>(
//         selector: (_, provider) => provider.pinState,
//         builder: (context, state, __) {
//           if (pinBuilder == null) {
//             return _defaultPinBuilder(context, state);
//           } else {
//             return Builder(
//                 builder: (builderContext) => pinBuilder(builderContext, state));
//           }
//         },
//       ),
//     );
//   }

//   Widget _defaultPinBuilder(BuildContext context, FPinState state) {
//     if (state == FPinState.Preparing) {
//       return Container();
//     } else if (state == FPinState.Idle) {
//       return Stack(
//         children: <Widget>[
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 FIcon(
//                   icon: FFilled.pin_map,
//                   size: 34,
//                   color: FColorSkin.primaryColor,
//                 ),
//                 SizedBox(height: 52),
//               ],
//             ),
//           ),
//           Center(
//             child: Container(
//               width: 17,
//               height: 17,
//               decoration: BoxDecoration(
//                 border:
//                     Border.all(width: 3, color: FColorSkin.grey1_background),
//                 color: FColorSkin.primaryColor,
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//         ],
//       );
//     } else {
//       return Stack(
//         children: <Widget>[
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 FAnimatedPin(
//                   child: FIcon(
//                     icon: FFilled.pin_map,
//                     size: 34,
//                     color: FColorSkin.primaryColor,
//                   ),
//                 ),
//                 SizedBox(height: 42),
//               ],
//             ),
//           ),
//           Center(
//             child: Container(
//               width: 17,
//               height: 17,
//               decoration: BoxDecoration(
//                 border:
//                     Border.all(width: 3, color: FColorSkin.grey1_background),
//                 color: FColorSkin.primaryColor,
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//         ],
//       );
//     }
//   }

//   Widget _buildFloatingCard() {
//     return Selector<FPlaceProvider,
//         Tuple4<FPickResult, FSearchingState, bool, FPinState>>(
//       selector: (_, provider) => Tuple4(
//           provider.selectedPlace,
//           provider.placeSearchingState,
//           provider.isSearchBarFocused,
//           provider.pinState),
//       builder: (context, data, __) {
//         final fPickResultLoading = FPickResult(
//             name: 'Đang tải',
//             addressComponents: [
//               AddressComponent(
//                   longName: 'Đang tải', shortName: 'Đang tải', types: ['', ''])
//             ],
//             formattedAddress: 'Đang tải');

//         if ((data.item1 == null && data.item2 == FSearchingState.Idle) ||
//             data.item3 == true ||
//             data.item4 == FPinState.Dragging &&
//                 this.hidePlaceDetailsWhenDraggingPin) {
//           if (data.item1 != null) {
//             return _defaultPlaceWidgetBuilderLoading(context, data.item1);
//           }
//           return _defaultPlaceWidgetBuilderLoading(context, fPickResultLoading);
//         } else {
//           if (selectedPlaceWidgetBuilder == null) {
//             if (data.item2 == FSearchingState.Searching) {
//               return _defaultPlaceWidgetBuilder(
//                   context, data.item1, data.item2);
//             }
//             return _defaultPlaceWidgetBuilder(context, data.item1, data.item2);
//           } else {
//             return Builder(
//                 builder: (builderContext) => selectedPlaceWidgetBuilder(
//                     builderContext, data.item1, data.item2, data.item3));
//           }
//         }
//       },
//     );
//   }

//   Widget _defaultPlaceWidgetBuilder(
//       BuildContext context, FPickResult data, FSearchingState state) {
//     return FFloatingCard(
//         bottomPosition: 0,
//         leftPosition: MediaQuery.of(context).size.width * 0.025,
//         rightPosition: MediaQuery.of(context).size.width * 0.025,
//         width: MediaQuery.of(context).size.width,
//         borderRadius: BorderRadius.circular(12.0),
//         elevation: 4.0,
//         color: Theme.of(context).cardColor,
//         child: state == FSearchingState.Searching
//             ? _buildSelectionDetailsLoading(context, data)
//             : _buildSelectionDetails(context, data));
//   }

//   Widget _defaultPlaceWidgetBuilderLoading(
//       BuildContext context, FPickResult data) {
//     return FFloatingCard(
//         bottomPosition: 0,
//         leftPosition: MediaQuery.of(context).size.width * 0.025,
//         rightPosition: MediaQuery.of(context).size.width * 0.025,
//         width: MediaQuery.of(context).size.width,
//         borderRadius: BorderRadius.circular(12.0),
//         elevation: 4.0,
//         color: Theme.of(context).cardColor,
//         child: _buildSelectionDetailsLoading(context, data));
//   }

//   Widget _buildLoadingIndicator() {
//     return Container(
//       height: 48,
//       child: const Center(
//         child: SizedBox(
//           width: 24,
//           height: 24,
//           child: CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }

//   Widget _buildSelectionDetailsLoading(
//       BuildContext context, FPickResult result) {
//         final fPickResultLoading = FPickResult(
//         name: 'Đang tải',
//         addressComponents: [
//           AddressComponent(
//               longName: 'Đang tải', shortName: 'Đang tải', types: ['', ''])
//         ],
//         formattedAddress: 'Đang tải');
//     return Container(
//       child: Column(
//         children: [
//           BottomMap(
//             result: result ?? fPickResultLoading,
//             isLoading: true,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSelectionDetails(BuildContext context, FPickResult result) {
//     return Container(
//       // margin: EdgeInsets.all(10),
//       child: Column(
//         children: <Widget>[
//           BottomMap(
//             result: result,
//           )
//           // Text(
//           //   result.formattedAddress,
//           //   style: TextStyle(fontSize: 18),
//           //   textAlign: TextAlign.center,
//           // ),
//           // SizedBox(height: 10),
//           // RaisedButton(
//           //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//           //   child: Text(
//           //     "Select here",
//           //     style: TextStyle(fontSize: 16),
//           //   ),
//           //   shape: RoundedRectangleBorder(
//           //     borderRadius: BorderRadius.circular(4.0),
//           //   ),
//           //   onPressed: () {
//           //     onPlacePicked(result);
//           //   },
//           // ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMapIcons(BuildContext context) {
//     final RenderBox appBarRenderBox =
//         appBarKey.currentContext.findRenderObject() as RenderBox;

//     return Positioned(
//       top: appBarRenderBox.size.height,
//       right: 15,
//       child: Column(
//         children: <Widget>[
//           enableMapTypeButton
//               ? Container(
//                   width: 35,
//                   height: 35,
//                   child: RawMaterialButton(
//                     shape: CircleBorder(),
//                     fillColor: Theme.of(context).brightness == Brightness.dark
//                         ? Colors.black54
//                         : Colors.white,
//                     elevation: 8.0,
//                     onPressed: onToggleMapType,
//                     child: Icon(Icons.layers),
//                   ),
//                 )
//               : Container(),
//           SizedBox(height: 10),
//           enableMyLocationButton
//               ? Container(
//                   width: 35,
//                   height: 35,
//                   child: RawMaterialButton(
//                     shape: CircleBorder(),
//                     fillColor: Theme.of(context).brightness == Brightness.dark
//                         ? Colors.black54
//                         : Colors.white,
//                     elevation: 8.0,
//                     onPressed: onMyLocation,
//                     child: Icon(Icons.my_location),
//                   ),
//                 )
//               : Container(),
//         ],
//       ),
//     );
//   }
// }
