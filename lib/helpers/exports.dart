export 'package:flutter/material.dart';

// ENTRY POINT OF THE APP
export 'package:task_management/ap.dart';

// FIREBASE FILES
export 'package:firebase_auth/firebase_auth.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:cloud_firestore/cloud_firestore.dart';
export 'package:task_management/firebase_options.dart';

// LOCAL
export 'constants.dart';
export 'cal_api.dart';
export 'alerts.dart';
export 'routes.dart';
export 'comon_functions.dart';
export 'enums.dart';
export 'comon_widgets.dart';
export 'network_bindings.dart';
export 'themes.dart';
export 'getxstorage.dart';
export 'conectivity_getx_controler.dart';

// GLOBAL
export 'package:get/get.dart' hide Condition;
export 'package:get_storage/get_storage.dart';
export 'package:device_info_plus/device_info_plus.dart';
export 'package:universal_io/io.dart' hide HeaderValue;
export 'package:flutter/services.dart';
export 'package:flutter/foundation.dart' hide kIsWasm;
export 'dart:convert';
export 'package:flutter/rendering.dart';
export 'dart:async' hide AsyncError;
export 'package:flutter/scheduler.dart';
export 'dart:math';
export 'package:country_picker/country_picker.dart';
export 'package:pinput/pinput.dart';
export 'package:gap/gap.dart';
export 'package:auto_size_text_field/auto_size_text_field.dart';
export 'package:hive/hive.dart';
export 'package:hive_flutter/hive_flutter.dart';
export 'package:intl/intl.dart' hide TextDirection;
export 'package:connectivity_plus/connectivity_plus.dart';

// MODELS
export 'package:task_management/helpers/models/task.dart';
export 'package:task_management/helpers/models/hive_database.dart';

// CONTROLERS
// AUTH SECTION
export 'package:task_management/controlers/auth/auth_vc.dart';
export 'package:task_management/controlers/auth/auth_ext.dart';
export 'package:task_management/controlers/auth/auth_getx_controler.dart';

// INITIAL PAGE
export 'package:task_management/controlers/initial/initial_vc.dart';
export 'package:task_management/controlers/initial/initial_views.dart';
export 'package:task_management/controlers/initial/initial_getx_controler.dart';
