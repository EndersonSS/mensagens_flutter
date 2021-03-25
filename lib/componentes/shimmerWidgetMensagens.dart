import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidgetMensagens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(5.0),
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.white,
            child: Card(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 90.0,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
