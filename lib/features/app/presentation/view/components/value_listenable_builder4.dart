import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ValueListenableBuilder4<A, B, C, D> extends StatelessWidget {
  final ValueListenable<A> a;
  final ValueListenable<B> b;
  final ValueListenable<C> c;
  final ValueListenable<D> d;
  final Widget Function(BuildContext, A, B, C, D) builder;

  const ValueListenableBuilder4(this.a, this.b, this.c, this.d,
      {super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: a,
      builder: (_, va, __) => ValueListenableBuilder<B>(
        valueListenable: b,
        builder: (_, vb, __) => ValueListenableBuilder<C>(
          valueListenable: c,
          builder: (_, vc, __) => ValueListenableBuilder<D>(
            valueListenable: d,
            builder: (context, vd, __) => builder(context, va, vb, vc, vd),
          ),
        ),
      ),
    );
  }
}
