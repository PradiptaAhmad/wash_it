import 'package:flutter/material.dart';

BoxShadow localMainShadow() {
  return BoxShadow(
    color: Colors.grey.withOpacity(0.2),
    spreadRadius: 2,
    blurRadius: 4,
    offset: const Offset(0.5, 2),
  );
}
