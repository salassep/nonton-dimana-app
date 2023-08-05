import 'package:flutter/material.dart';

Column keyValueColumn(String key, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        key,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
      Text(
        value,
        style: const TextStyle(
          fontSize: 16.0,
        ),
      ),
    ],
  );
}