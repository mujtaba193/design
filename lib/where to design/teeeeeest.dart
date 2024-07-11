// import 'dart:core' as core;
// import 'dart:ffi' as ffi;

// import 'package:ffi/ffi.dart';
// import 'package:meta/meta.dart';
// import 'package:yandex_maps_mapkit/src/bindings/annotations/annotations.dart'
//     as bindings_annotations;
// import 'package:yandex_maps_mapkit/src/bindings/common/library.dart' as lib;
// import 'package:yandex_maps_mapkit/src/bindings/common/string_map.dart'
//     as string_map;
// import 'package:yandex_maps_mapkit/src/bindings/common/to_native.dart'
//     as to_native;
// import 'package:yandex_maps_mapkit/src/bindings/common/to_platform.dart'
//     as to_platform;
// import 'package:yandex_maps_mapkit/src/bindings/common/vector.dart' as vector;
// import 'package:yandex_maps_mapkit/src/bindings/common/weak_interface_wrapper.dart'
//     as weak_interface_wrapper;
// import 'package:yandex_maps_mapkit/src/directions/driving/session.dart'
//     as directions_driving_session;
// import 'package:yandex_maps_mapkit/src/directions/driving/vehicle_options.dart'
//     as directions_driving_vehicle_options;
// import 'package:yandex_maps_mapkit/src/mapkit/annotations/annotation_lang.dart'
//     as mapkit_annotations_annotation_lang;
// import 'package:yandex_maps_mapkit/src/mapkit/request_point.dart'
//     as mapkit_request_point;
// import 'package:yandex_maps_mapkit/src/runtime/error.dart' as runtime_error;

// abstract class DrivingTooComplexAvoidedZonesError
//     implements runtime_error.Error, ffi.Finalizable {}

// final class DrivingOptions {
//   final core.double? initialAzimuth;
//   final core.int? routesCount;
//   final core.bool? avoidTolls;
//   final core.bool? avoidUnpaved;
//   final core.bool? avoidPoorConditions;
//   final core.DateTime? departureTime;
//   final mapkit_annotations_annotation_lang.AnnotationLanguage?
//       annotationLanguage;

//   const DrivingOptions({
//     this.initialAzimuth,
//     this.routesCount,
//     this.avoidTolls,
//     this.avoidUnpaved,
//     this.avoidPoorConditions,
//     this.departureTime,
//     this.annotationLanguage,
//   });

//   @core.override
//   core.int get hashCode => core.Object.hashAll([
//         initialAzimuth,
//         routesCount,
//         avoidTolls,
//         avoidUnpaved,
//         avoidPoorConditions,
//         departureTime,
//         annotationLanguage
//       ]);

//   @core.override
//   core.bool operator ==(covariant DrivingOptions other) {
//     if (core.identical(this, other)) {
//       return true;
//     }
//     return initialAzimuth == other.initialAzimuth &&
//         routesCount == other.routesCount &&
//         avoidTolls == other.avoidTolls &&
//         avoidUnpaved == other.avoidUnpaved &&
//         avoidPoorConditions == other.avoidPoorConditions &&
//         departureTime == other.departureTime &&
//         annotationLanguage == other.annotationLanguage;
//   }

//   @core.override
//   core.String toString() {
//     return "DrivingOptions(initialAzimuth: $initialAzimuth, routesCount: $routesCount, avoidTolls: $avoidTolls, avoidUnpaved: $avoidUnpaved, avoidPoorConditions: $avoidPoorConditions, departureTime: $departureTime, annotationLanguage: $annotationLanguage)";
//   }
// }

// /// Driving router type.
// enum DrivingRouterType {
//   /// Online driving router. Always tries to use online router even if
//   /// network is not available.
//   Online,

//   /// Offline driving router. Always tries to use offline router even if
//   /// network is available.
//   Offline,

//   /// Combined driving router. Decision to use online or offline router is
//   /// based on internal timeout. If server manages to respond within given
//   /// time, then online router result is returned. Otherwise uses offline
//   /// router.  Will combine online and offline router result in single
//   /// session (hence the name). Timeout logic is applied on each resubmit
//   /// until first response from offline router is returned to the listener.
//   /// After that timeout is reduced to zero for all following resubmits.
//   Combined,
//   ;
// }

// /// Interface for the driving router.
// abstract class DrivingRouter implements ffi.Finalizable {
//   /// Builds a route.
//   ///
//   /// [points] Route points.
//   /// [drivingOptions] Driving options.
//   /// [vehicleOptions] Vehicle options.
//   /// [routeListener] Route listener object.
//   directions_driving_session.DrivingSession requestRoutes(
//     DrivingOptions drivingOptions,
//     directions_driving_vehicle_options.DrivingVehicleOptions vehicleOptions,
//     directions_driving_session.DrivingSessionRouteListener routeListener, {
//     required core.List<mapkit_request_point.RequestPoint> points,
//   });

//   /// Creates a route summary.
//   ///
//   /// [points] Route points.
//   /// [drivingOptions] Driving options.
//   /// [vehicleOptions] Vehicle options.
//   /// [summaryListener] Summary listener object.
//   directions_driving_session.DrivingSummarySession requestRoutesSummary(
//     DrivingOptions drivingOptions,
//     directions_driving_vehicle_options.DrivingVehicleOptions vehicleOptions,
//     directions_driving_session.DrivingSummarySessionSummaryListener
//         summaryListener, {
//     required core.List<mapkit_request_point.RequestPoint> points,
//   });
// }

// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// // GENERATED CODE - DO NOT MODIFY BY HAND

// // **************************************************************************
// // ContainerGenerator
// // **************************************************************************

// extension DrivingTooComplexAvoidedZonesErrorContainerExtension
//     on DrivingTooComplexAvoidedZonesError {
//   static ffi.Pointer<ffi.Void> toNativeMap(
//       core.Map<core.String, DrivingTooComplexAvoidedZonesError?>? obj) {
//     if (obj == null) {
//       return ffi.nullptr;
//     }

//     return string_map.toNativeMap(
//         obj, DrivingTooComplexAvoidedZonesErrorImpl.getNativePtr);
//   }

//   static ffi.Pointer<ffi.Void> toNativeMapVector(
//       core.Map<core.String, core.List<DrivingTooComplexAvoidedZonesError?>?>?
//           obj) {
//     if (obj == null) {
//       return ffi.nullptr;
//     }

//     return string_map.toNativeMap(obj, toNativeVector);
//   }

//   static ffi.Pointer<ffi.Void> toNativeMapDictionary(
//       core.Map<core.String,
//               core.Map<core.String, DrivingTooComplexAvoidedZonesError?>?>?
//           obj) {
//     if (obj == null) {
//       return ffi.nullptr;
//     }

//     return string_map.toNativeMap(obj, toNativeMap);
//   }

//   static ffi.Pointer<ffi.Void> toNativeVector(
//       core.List<DrivingTooComplexAvoidedZonesError?>? obj) {
//     if (obj == null) {
//       return ffi.nullptr;
//     }

//     return vector.toNativeVector(
//         obj, DrivingTooComplexAvoidedZonesErrorImpl.getNativePtr);
//   }

//   static ffi.Pointer<ffi.Void> toNativeVectorVector(
//       core.List<core.List<DrivingTooComplexAvoidedZonesError?>?>? obj) {
//     if (obj == null) {
//       return ffi.nullptr;
//     }

//     return vector.toNativeVector(obj, toNativeVector);
//   }

//   static ffi.Pointer<ffi.Void> toNativeVectorDictionary(
//       core.List<core.Map<core.String, DrivingTooComplexAvoidedZonesError?>?>?
//           obj) {
//     if (obj == null) {
//       return ffi.nullptr;
//     }

//     return vector.toNativeVector(obj, toNativeMap);
//   }

//   static string_map.StringMap<DrivingTooComplexAvoidedZonesError> toPlatformMap(
//       ffi.Pointer<ffi.Void> ptr) {
//     return string_map.StringMap(
//         ptr,
//         (val) => DrivingTooComplexAvoidedZonesErrorImpl.fromOptionalPtr(
//             val.cast<ffi.Pointer<ffi.Void>>().value));
//   }

//   static string_map.StringMap<vector.Vector<DrivingTooComplexAvoidedZonesError>>
//       toPlatformMapVector(ffi.Pointer<ffi.Void> ptr) {
//     return string_map.StringMap(
//         ptr,
//         (val) => val == ffi.nullptr
//             ? null
//             : toPlatformVector(val.cast<ffi.Pointer<ffi.Void>>().value));
//   }

//   static string_map
//       .StringMap<string_map.StringMap<DrivingTooComplexAvoidedZonesError>>
//       toPlatformMapDictionary(ffi.Pointer<ffi.Void> ptr) {
//     return string_map.StringMap(
//         ptr,
//         (val) => val == ffi.nullptr
//             ? null
//             : toPlatformMap(val.cast<ffi.Pointer<ffi.Void>>().value));
//   }

//   static vector.Vector<DrivingTooComplexAvoidedZonesError> toPlatformVector(
//       ffi.Pointer<ffi.Void> ptr) {
//     return vector.Vector(
//         ptr,
//         (val) => DrivingTooComplexAvoidedZonesErrorImpl.fromOptionalPtr(
//             val.cast<ffi.Pointer<ffi.Void>>().value));
//   }

//   static vector.Vector<vector.Vector<DrivingTooComplexAvoidedZonesError>>
//       toPlatformVectorVector(ffi.Pointer<ffi.Void> ptr) {
//     return vector.Vector(
//         ptr,
//         (val) => val == ffi.nullptr
//             ? null
//             : toPlatformVector(val.cast<ffi.Pointer<ffi.Void>>().value));
//   }

//   static vector.Vector<string_map.StringMap<DrivingTooComplexAvoidedZonesError>>
//       toPlatformVectorDictionary(ffi.Pointer<ffi.Void> ptr) {
//     return vector.Vector(
//         ptr,
//         (val) => val == ffi.nullptr
//             ? null
//             : toPlatformMap(val.cast<ffi.Pointer<ffi.Void>>().value));
//   }
// }

// extension DrivingRouterContainerExtension on DrivingRouter {
//   static ffi.Pointer<ffi.Void> toNativeMap(
//       core.Map<core.String, DrivingRouter?>? obj) {
//     if (obj == null) {
//       return ffi.nullptr;
//     }

//     return string_map.toNativeMap(obj, DrivingRouterImpl.getNativePtr);
//   }

//   static ffi.Pointer<ffi.Void> toNativeMapVector(
//       core.Map<core.String, core.List<DrivingRouter?>?>? obj) {
//     if (obj == null) {
//       return ffi.nullptr;
//     }

//     return string_map.toNativeMap(obj, toNativeVector);
//   }

//   static ffi.Pointer<ffi.Void> toNativeMapDictionary(
//       core.Map<core.String, core.Map<core.String, DrivingRouter?>?>? obj) {
//     if (obj == null) {
//       return ffi.nullptr;
//     }

//     return string_map.toNativeMap(obj, toNativeMap);
//   }

//   static ffi.Pointer<ffi.Void> toNativeVector(core.List<DrivingRouter?>? obj) {
//     if (obj == null) {
//       return ffi.nullptr;
//     }

//     return vector.toNativeVector(obj, DrivingRouterImpl.getNativePtr);
//   }

//   static ffi.Pointer<ffi.Void> toNativeVectorVector(
//       core.List<core.List<DrivingRouter?>?>? obj) {
//     if (obj == null) {
//       return ffi.nullptr;
//     }

//     return vector.toNativeVector(obj, toNativeVector);
//   }

//   static ffi.Pointer<ffi.Void> toNativeVectorDictionary(
//       core.List<core.Map<core.String, DrivingRouter?>?>? obj) {
//     if (obj == null) {
//       return ffi.nullptr;
//     }

//     return vector.toNativeVector(obj, toNativeMap);
//   }

//   static string_map.StringMap<DrivingRouter> toPlatformMap(
//       ffi.Pointer<ffi.Void> ptr) {
//     return string_map.StringMap(
//         ptr,
//         (val) => DrivingRouterImpl.fromOptionalPtr(
//             val.cast<ffi.Pointer<ffi.Void>>().value));
//   }

//   static string_map.StringMap<vector.Vector<DrivingRouter>> toPlatformMapVector(
//       ffi.Pointer<ffi.Void> ptr) {
//     return string_map.StringMap(
//         ptr,
//         (val) => val == ffi.nullptr
//             ? null
//             : toPlatformVector(val.cast<ffi.Pointer<ffi.Void>>().value));
//   }

//   static string_map.StringMap<string_map.StringMap<DrivingRouter>>
//       toPlatformMapDictionary(ffi.Pointer<ffi.Void> ptr) {
//     return string_map.StringMap(
//         ptr,
//         (val) => val == ffi.nullptr
//             ? null
//             : toPlatformMap(val.cast<ffi.Pointer<ffi.Void>>().value));
//   }

//   static vector.Vector<DrivingRouter> toPlatformVector(
//       ffi.Pointer<ffi.Void> ptr) {
//     return vector.Vector(
//         ptr,
//         (val) => DrivingRouterImpl.fromOptionalPtr(
//             val.cast<ffi.Pointer<ffi.Void>>().value));
//   }

//   static vector.Vector<vector.Vector<DrivingRouter>> toPlatformVectorVector(
//       ffi.Pointer<ffi.Void> ptr) {
//     return vector.Vector(
//         ptr,
//         (val) => val == ffi.nullptr
//             ? null
//             : toPlatformVector(val.cast<ffi.Pointer<ffi.Void>>().value));
//   }

//   static vector.Vector<string_map.StringMap<DrivingRouter>>
//       toPlatformVectorDictionary(ffi.Pointer<ffi.Void> ptr) {
//     return vector.Vector(
//         ptr,
//         (val) => val == ffi.nullptr
//             ? null
//             : toPlatformMap(val.cast<ffi.Pointer<ffi.Void>>().value));
//   }
// }

// extension DrivingOptionsContainerExtension on DrivingOptions {
//   static ffi.Pointer<ffi.Void> toNativeMap(
//       core.Map<core.String, DrivingOptions?>? obj) {
//     if (obj == null) {
//       return ffi.nullptr;
//     }

//     return string_map.toNativeMap(obj, DrivingOptionsImpl.toPointer);
//   }

//   static ffi.Pointer<ffi.Void> toNativeMapVector(
//       core.Map<core.String, core.List<DrivingOptions?>?>? obj) {
//     if (obj == null) {
//       return ffi.nullptr;
//     }

//     return string_map.toNativeMap(obj, toNativeVector);
//   }

//   static ffi.Pointer<ffi.Void> toNativeMapDictionary(
//       core.Map<core.String, core.Map<core.String, DrivingOptions?>?>? obj) {
//     if (obj == null) {
//       return ffi.nullptr;
//     }

//     return string_map.toNativeMap(obj, toNativeMap);
//   }

//   static ffi.Pointer<ffi.Void> toNativeVector(core.List<DrivingOptions?>? obj) {
//     if (obj == null) {
//       return ffi.nullptr;
//     }

//     return vector.toNativeVector(obj, DrivingOptionsImpl.toPointer);
//   }

//   static ffi.Pointer<ffi.Void> toNativeVectorVector(
//       core.List<core.List<DrivingOptions?>?>? obj) {
//     if (obj == null) {
//       return ffi.nullptr;
//     }

//     return vector.toNativeVector(obj, toNativeVector);
//   }

//   static ffi.Pointer<ffi.Void> toNativeVectorDictionary(
//       core.List<core.Map<core.String, DrivingOptions?>?>? obj) {
//     if (obj == null) {
//       return ffi.nullptr;
//     }

//     return vector.toNativeVector(obj, toNativeMap);
//   }

//   static string_map.StringMap<DrivingOptions> toPlatformMap(
//       ffi.Pointer<ffi.Void> ptr) {
//     return string_map.StringMap(
//         ptr, (val) => DrivingOptionsImpl.fromPointer(val, needFree: false));
//   }

//   static string_map.StringMap<vector.Vector<DrivingOptions>>
//       toPlatformMapVector(ffi.Pointer<ffi.Void> ptr) {
//     return string_map.StringMap(
//         ptr,
//         (val) => val == ffi.nullptr
//             ? null
//             : toPlatformVector(val.cast<ffi.Pointer<ffi.Void>>().value));
//   }

//   static string_map.StringMap<string_map.StringMap<DrivingOptions>>
//       toPlatformMapDictionary(ffi.Pointer<ffi.Void> ptr) {
//     return string_map.StringMap(
//         ptr,
//         (val) => val == ffi.nullptr
//             ? null
//             : toPlatformMap(val.cast<ffi.Pointer<ffi.Void>>().value));
//   }

//   static vector.Vector<DrivingOptions> toPlatformVector(
//       ffi.Pointer<ffi.Void> ptr) {
//     return vector.Vector(
//         ptr, (val) => DrivingOptionsImpl.fromPointer(val, needFree: false));
//   }

//   static vector.Vector<vector.Vector<DrivingOptions>> toPlatformVectorVector(
//       ffi.Pointer<ffi.Void> ptr) {
//     return vector.Vector(
//         ptr,
//         (val) => val == ffi.nullptr
//             ? null
//             : toPlatformVector(val.cast<ffi.Pointer<ffi.Void>>().value));
//   }

//   static vector.Vector<string_map.StringMap<DrivingOptions>>
//       toPlatformVectorDictionary(ffi.Pointer<ffi.Void> ptr) {
//     return vector.Vector(
//         ptr,
//         (val) => val == ffi.nullptr
//             ? null
//             : toPlatformMap(val.cast<ffi.Pointer<ffi.Void>>().value));
//   }
// }

// extension DrivingRouterTypeContainerExtension on DrivingRouterType {
//   static ffi.Pointer<ffi.Void> toNativeMap(
//       core.Map<core.String, DrivingRouterType?>? obj) {
//     if (obj == null) {
//       return ffi.nullptr;
//     }

//     return string_map.toNativeMap(obj, DrivingRouterTypeImpl.toPointer);
//   }

//   static ffi.Pointer<ffi.Void> toNativeMapVector(
//       core.Map<core.String, core.List<DrivingRouterType?>?>? obj) {
//     if (obj == null) {
//       return ffi.nullptr;
//     }

//     return string_map.toNativeMap(obj, toNativeVector);
//   }

//   static ffi.Pointer<ffi.Void> toNativeMapDictionary(
//       core.Map<core.String, core.Map<core.String, DrivingRouterType?>?>? obj) {
//     if (obj == null) {
//       return ffi.nullptr;
//     }

//     return string_map.toNativeMap(obj, toNativeMap);
//   }

//   static ffi.Pointer<ffi.Void> toNativeVector(
//       core.List<DrivingRouterType?>? obj) {
//     if (obj == null) {
//       return ffi.nullptr;
//     }

//     return vector.toNativeVector(obj, DrivingRouterTypeImpl.toPointer);
//   }

//   static ffi.Pointer<ffi.Void> toNativeVectorVector(
//       core.List<core.List<DrivingRouterType?>?>? obj) {
//     if (obj == null) {
//       return ffi.nullptr;
//     }

//     return vector.toNativeVector(obj, toNativeVector);
//   }

//   static ffi.Pointer<ffi.Void> toNativeVectorDictionary(
//       core.List<core.Map<core.String, DrivingRouterType?>?>? obj) {
//     if (obj == null) {
//       return ffi.nullptr;
//     }

//     return vector.toNativeVector(obj, toNativeMap);
//   }

//   static string_map.StringMap<DrivingRouterType> toPlatformMap(
//       ffi.Pointer<ffi.Void> ptr) {
//     return string_map.StringMap(
//         ptr, (val) => DrivingRouterTypeImpl.fromPointer(val, needFree: false));
//   }

//   static string_map.StringMap<vector.Vector<DrivingRouterType>>
//       toPlatformMapVector(ffi.Pointer<ffi.Void> ptr) {
//     return string_map.StringMap(
//         ptr,
//         (val) => val == ffi.nullptr
//             ? null
//             : toPlatformVector(val.cast<ffi.Pointer<ffi.Void>>().value));
//   }

//   static string_map.StringMap<string_map.StringMap<DrivingRouterType>>
//       toPlatformMapDictionary(ffi.Pointer<ffi.Void> ptr) {
//     return string_map.StringMap(
//         ptr,
//         (val) => val == ffi.nullptr
//             ? null
//             : toPlatformMap(val.cast<ffi.Pointer<ffi.Void>>().value));
//   }

//   static vector.Vector<DrivingRouterType> toPlatformVector(
//       ffi.Pointer<ffi.Void> ptr) {
//     return vector.Vector(
//         ptr, (val) => DrivingRouterTypeImpl.fromPointer(val, needFree: false));
//   }

//   static vector.Vector<vector.Vector<DrivingRouterType>> toPlatformVectorVector(
//       ffi.Pointer<ffi.Void> ptr) {
//     return vector.Vector(
//         ptr,
//         (val) => val == ffi.nullptr
//             ? null
//             : toPlatformVector(val.cast<ffi.Pointer<ffi.Void>>().value));
//   }

//   static vector.Vector<string_map.StringMap<DrivingRouterType>>
//       toPlatformVectorDictionary(ffi.Pointer<ffi.Void> ptr) {
//     return vector.Vector(
//         ptr,
//         (val) => val == ffi.nullptr
//             ? null
//             : toPlatformMap(val.cast<ffi.Pointer<ffi.Void>>().value));
//   }
// }

// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// @bindings_annotations
//     .WeakInterface('directions.driving.TooComplexAvoidedZonesError')
// @bindings_annotations.ContainerData(
//     toNative: 'DrivingTooComplexAvoidedZonesErrorImpl.getNativePtr',
//     toPlatform:
//         '(val) => DrivingTooComplexAvoidedZonesErrorImpl.fromOptionalPtr(val.cast<ffi.Pointer<ffi.Void>>().value)',
//     platformType: 'DrivingTooComplexAvoidedZonesError')
// class DrivingTooComplexAvoidedZonesErrorImpl extends runtime_error.ErrorImpl
//     implements DrivingTooComplexAvoidedZonesError, ffi.Finalizable {
//   static final _finalizer =
//       ffi.NativeFinalizer(_DrivingTooComplexAvoidedZonesError_free.cast());

//   /// @nodoc
//   DrivingTooComplexAvoidedZonesErrorImpl.fromExternalPtr(
//       ffi.Pointer<ffi.Void> ptr)
//       : super.fromExternalPtr(ptr);

//   /// @nodoc
//   @internal
//   DrivingTooComplexAvoidedZonesErrorImpl.fromNativePtrImpl(
//       ffi.Pointer<ffi.Void> ptr)
//       : super.fromExternalPtr(ptr) {
//     _finalizer.attach(this, ptr);
//   }

//   /// @nodoc
//   @internal
//   factory DrivingTooComplexAvoidedZonesErrorImpl.fromNativePtr(
//           ffi.Pointer<ffi.Void> ptr) =>
//       weak_interface_wrapper.createFromNative(ptr);

//   @internal

//   /// @nodoc
//   static ffi.Pointer<ffi.Void> getNativePtr(
//       DrivingTooComplexAvoidedZonesError? obj) {
//     if (obj == null) return ffi.nullptr;
//     return (obj as DrivingTooComplexAvoidedZonesErrorImpl).ptr;
//   }

//   core.bool isValid() {
//     return _DrivingTooComplexAvoidedZonesError_check(ptr);
//   }

//   @internal

//   /// @nodoc
//   static DrivingTooComplexAvoidedZonesError? fromOptionalPtr(
//       ffi.Pointer<ffi.Void> ptr) {
//     if (ptr == ffi.nullptr) return null;
//     return DrivingTooComplexAvoidedZonesErrorImpl.fromNativePtr(ptr);
//   }
// }

// final _DrivingTooComplexAvoidedZonesError_free = lib.library.lookup<
//         ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>>(
//     'yandex_flutter_directions_driving_DrivingTooComplexAvoidedZonesError_free');
// final core.bool Function(
//     ffi
//         .Pointer<ffi.Void>) _DrivingTooComplexAvoidedZonesError_check = lib
//     .library
//     .lookup<ffi.NativeFunction<ffi.Bool Function(ffi.Pointer<ffi.Void>)>>(
//         'yandex_flutter_directions_driving_DrivingTooComplexAvoidedZonesError_check')
//     .asFunction(isLeaf: true);

// final class DrivingOptionsNative extends ffi.Struct {
//   external ffi.Pointer<ffi.Void> initialAzimuth;
//   external ffi.Pointer<ffi.Void> routesCount;
//   external ffi.Pointer<ffi.Void> avoidTolls;
//   external ffi.Pointer<ffi.Void> avoidUnpaved;
//   external ffi.Pointer<ffi.Void> avoidPoorConditions;
//   external ffi.Pointer<ffi.Void> departureTime;
//   external ffi.Pointer<ffi.Void> annotationLanguage;
// }

// final DrivingOptionsNative Function(
//         ffi.Pointer<ffi.Void>,
//         ffi.Pointer<ffi.Void>,
//         ffi.Pointer<ffi.Void>,
//         ffi.Pointer<ffi.Void>,
//         ffi.Pointer<ffi.Void>,
//         ffi.Pointer<ffi.Void>,
//         ffi.Pointer<ffi.Void>) _DrivingOptionsNativeInit =
//     lib.library
//         .lookup<
//                 ffi.NativeFunction<
//                     DrivingOptionsNative Function(
//                         ffi.Pointer<ffi.Void>,
//                         ffi.Pointer<ffi.Void>,
//                         ffi.Pointer<ffi.Void>,
//                         ffi.Pointer<ffi.Void>,
//                         ffi.Pointer<ffi.Void>,
//                         ffi.Pointer<ffi.Void>,
//                         ffi.Pointer<ffi.Void>)>>(
//             'yandex_flutter_directions_driving_DrivingOptions_init')
//         .asFunction(isLeaf: true);

// @bindings_annotations.ContainerData(
//     toNative: 'DrivingOptionsImpl.toPointer',
//     toPlatform: '(val) => DrivingOptionsImpl.fromPointer(val, needFree: false)',
//     platformType: 'DrivingOptions')
// extension DrivingOptionsImpl on DrivingOptions {
//   static DrivingOptions fromNative(DrivingOptionsNative native) {
//     return DrivingOptions(
//         initialAzimuth:
//             to_platform.toPlatformFromPointerDouble(native.initialAzimuth),
//         routesCount: to_platform.toPlatformFromPointerInt(native.routesCount),
//         avoidTolls: to_platform.toPlatformFromPointerBool(native.avoidTolls),
//         avoidUnpaved:
//             to_platform.toPlatformFromPointerBool(native.avoidUnpaved),
//         avoidPoorConditions:
//             to_platform.toPlatformFromPointerBool(native.avoidPoorConditions),
//         departureTime:
//             to_platform.toPlatformFromPointerAbsTimestamp(native.departureTime),
//         annotationLanguage: mapkit_annotations_annotation_lang
//             .AnnotationLanguageImpl.fromPointer(native.annotationLanguage));
//   }

//   static DrivingOptionsNative toNative(DrivingOptions obj) {
//     return _DrivingOptionsNativeInit(
//         to_native.toNativePtrDouble(obj.initialAzimuth),
//         to_native.toNativePtrInt(obj.routesCount),
//         to_native.toNativePtrBool(obj.avoidTolls),
//         to_native.toNativePtrBool(obj.avoidUnpaved),
//         to_native.toNativePtrBool(obj.avoidPoorConditions),
//         to_native.toNativePtrAbsTimestamp(obj.departureTime),
//         mapkit_annotations_annotation_lang.AnnotationLanguageImpl.toPointer(
//             obj.annotationLanguage));
//   }

//   static DrivingOptions? fromPointer(ffi.Pointer<ffi.Void> ptr,
//       {core.bool needFree = true}) {
//     if (ptr == ffi.nullptr) {
//       return null;
//     }
//     final result =
//         DrivingOptionsImpl.fromNative(ptr.cast<DrivingOptionsNative>().ref);

//     if (needFree) {
//       malloc.free(ptr);
//     }
//     return result;
//   }

//   static ffi.Pointer<ffi.Void> toPointer(DrivingOptions? val) {
//     if (val == null) {
//       return ffi.nullptr;
//     }
//     final result = malloc.call<DrivingOptionsNative>();
//     result.ref = toNative(val);

//     return result.cast();
//   }
// }

// @bindings_annotations.ContainerData(
//     toNative: 'DrivingRouterTypeImpl.toPointer',
//     toPlatform:
//         '(val) => DrivingRouterTypeImpl.fromPointer(val, needFree: false)',
//     platformType: 'DrivingRouterType')
// extension DrivingRouterTypeImpl on DrivingRouterType {
//   static core.int toInt(DrivingRouterType e) {
//     return e.index;
//   }

//   static DrivingRouterType fromInt(core.int val) {
//     return DrivingRouterType.values[val];
//   }

//   static DrivingRouterType? fromPointer(ffi.Pointer<ffi.Void> ptr,
//       {core.bool needFree = true}) {
//     if (ptr == ffi.nullptr) {
//       return null;
//     }
//     final result = fromInt(ptr.cast<ffi.Int64>().value);

//     if (needFree) {
//       malloc.free(ptr);
//     }
//     return result;
//   }

//   static ffi.Pointer<ffi.Void> toPointer(DrivingRouterType? val) {
//     if (val == null) {
//       return ffi.nullptr;
//     }

//     final result = malloc.call<ffi.Int64>();
//     result.value = toInt(val);

//     return result.cast();
//   }
// }

// @bindings_annotations.ContainerData(
//     toNative: 'DrivingRouterImpl.getNativePtr',
//     toPlatform:
//         '(val) => DrivingRouterImpl.fromOptionalPtr(val.cast<ffi.Pointer<ffi.Void>>().value)',
//     platformType: 'DrivingRouter')
// class DrivingRouterImpl implements DrivingRouter, ffi.Finalizable {
//   @protected
//   final ffi.Pointer<ffi.Void> ptr;
//   static final _finalizer = ffi.NativeFinalizer(_DrivingRouter_free.cast());

//   /// @nodoc
//   DrivingRouterImpl.fromExternalPtr(this.ptr);

//   /// @nodoc
//   @internal
//   DrivingRouterImpl.fromNativePtr(this.ptr) {
//     _finalizer.attach(this, ptr);
//   }

//   @internal

//   /// @nodoc
//   static ffi.Pointer<ffi.Void> getNativePtr(DrivingRouter? obj) {
//     if (obj == null) return ffi.nullptr;
//     return (obj as DrivingRouterImpl).ptr;
//   }

//   @internal

//   /// @nodoc
//   static DrivingRouter? fromOptionalPtr(ffi.Pointer<ffi.Void> ptr) {
//     if (ptr == ffi.nullptr) return null;
//     return DrivingRouterImpl.fromNativePtr(ptr);
//   }

//   directions_driving_session.DrivingSession requestRoutes(
//     DrivingOptions drivingOptions,
//     directions_driving_vehicle_options.DrivingVehicleOptions vehicleOptions,
//     directions_driving_session.DrivingSessionRouteListener routeListener, {
//     required core.List<mapkit_request_point.RequestPoint> points,
//   }) {
//     return directions_driving_session.DrivingSessionImpl.fromNativePtr(
//         _DrivingRouter_requestRoutes(
//       ptr,
//       mapkit_request_point.RequestPointContainerExtension.toNativeVector(
//           points),
//       DrivingOptionsImpl.toNative(drivingOptions),
//       directions_driving_vehicle_options.DrivingVehicleOptionsImpl.toNative(
//           vehicleOptions),
//       directions_driving_session.DrivingSessionRouteListenerImpl.getNativePtr(
//           routeListener),
//     ));
//   }

//   directions_driving_session.DrivingSummarySession requestRoutesSummary(
//     DrivingOptions drivingOptions,
//     directions_driving_vehicle_options.DrivingVehicleOptions vehicleOptions,
//     directions_driving_session.DrivingSummarySessionSummaryListener
//         summaryListener, {
//     required core.List<mapkit_request_point.RequestPoint> points,
//   }) {
//     return directions_driving_session.DrivingSummarySessionImpl.fromNativePtr(
//         _DrivingRouter_requestRoutesSummary(
//       ptr,
//       mapkit_request_point.RequestPointContainerExtension.toNativeVector(
//           points),
//       DrivingOptionsImpl.toNative(drivingOptions),
//       directions_driving_vehicle_options.DrivingVehicleOptionsImpl.toNative(
//           vehicleOptions),
//       directions_driving_session.DrivingSummarySessionSummaryListenerImpl
//           .getNativePtr(summaryListener),
//     ));
//   }
// }

// final _DrivingRouter_free = lib.library
//     .lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>>(
//         'yandex_flutter_directions_driving_DrivingRouter_free');

// final ffi.Pointer<ffi.Void> Function(
//         ffi.Pointer<ffi.Void>,
//         ffi.Pointer<ffi.Void>,
//         DrivingOptionsNative,
//         directions_driving_vehicle_options.DrivingVehicleOptionsNative,
//         ffi.Pointer<ffi.Void>) _DrivingRouter_requestRoutes =
//     lib.library
//         .lookup<
//                 ffi.NativeFunction<
//                     ffi.Pointer<ffi.Void> Function(
//                         ffi.Pointer<ffi.Void>,
//                         ffi.Pointer<ffi.Void>,
//                         DrivingOptionsNative,
//                         directions_driving_vehicle_options
//                             .DrivingVehicleOptionsNative,
//                         ffi.Pointer<ffi.Void>)>>(
//             'yandex_flutter_directions_driving_DrivingRouter_requestRoutes')
//         .asFunction();
// final ffi.Pointer<ffi.Void> Function(
//     ffi.Pointer<ffi.Void>,
//     ffi.Pointer<ffi.Void>,
//     DrivingOptionsNative,
//     directions_driving_vehicle_options.DrivingVehicleOptionsNative,
//     ffi
//         .Pointer<ffi.Void>) _DrivingRouter_requestRoutesSummary = lib.library
//     .lookup<
//             ffi.NativeFunction<
//                 ffi.Pointer<ffi.Void> Function(
//                     ffi.Pointer<ffi.Void>,
//                     ffi.Pointer<ffi.Void>,
//                     DrivingOptionsNative,
//                     directions_driving_vehicle_options.DrivingVehicleOptionsNative,
//                     ffi.Pointer<ffi.Void>)>>(
//         'yandex_flutter_directions_driving_DrivingRouter_requestRoutesSummary')
//     .asFunction();
