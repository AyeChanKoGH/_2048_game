import 'package:flutter/material.dart';

double getsecreensize(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getchildheight(BuildContext context, n_column, pad_size) {
  return (getsecreensize(context) / n_column) - 2 * pad_size;
}
