library client.globals;
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';


Socket client;
List<Object> messaggi = [];
List<String> userNames = [];
List<bool> mioMessaggio = [];
List<bool> isImage = [];
TextEditingController userName  = TextEditingController();
CameraDescription camera;