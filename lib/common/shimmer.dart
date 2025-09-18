import 'package:bhk_artisan/common/gradient.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerContainer({double width = double.infinity, double height = 100, double radius = 12}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(radius)),
    ),
  );
}

Widget shimmerProduct(double w) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(width: w * 0.5, height: 20, color: Colors.grey),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(width: 60, height: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
      15.kH,
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 20.0, mainAxisSpacing: 7.0, childAspectRatio: 0.6),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: w * 0.4,
                  height: 180,
                  decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(12)),
                ),
                10.kH,
                Container(width: w * 0.4, height: 14, color: Colors.grey),
                6.kH,
                Container(width: w * 0.3, height: 14, color: Colors.grey),
                3.kH,
                Container(width: w * 0.25, height: 12, color: Colors.grey),
                3.kH,
                Container(width: w * 0.35, height: 14, color: Colors.grey),
              ],
            ),
          );
        },
      ),
    ],
  );
}

PreferredSizeWidget shimmerAppBarHome(double w) {
  return AppBar(
    flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppGradients.customGradient)),
    elevation: 0,
    automaticallyImplyLeading: false,
    toolbarHeight: 75,
    centerTitle: false,
    titleSpacing: 2,
    leading: Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 16.0),
        width: 50,
        height: 50,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
      ),
    ),
    title: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(width: w * 0.4, height: 20, color: Colors.grey),
        ),
        const SizedBox(height: 6),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(width: w * 0.3, height: 16, color: Colors.grey),
        ),
      ],
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
          ),
        ),
      ),
    ],
  );
}

Widget shimmerMyProducts(double w, double h) {
  return Expanded(
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 115,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), bottomLeft: Radius.circular(8.0)),
                  ),
                ),
                10.kW,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(width: w * 0.4, height: 14, color: Colors.grey),
                        5.kH,
                        Container(width: w * 0.3, height: 12, color: Colors.grey),
                        5.kH,
                        Row(
                          children: [
                            Container(width: 60, height: 20, color: Colors.grey),
                            8.kW,
                            Container(width: 60, height: 20, color: Colors.grey),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

Widget shimmerProductDetails(double h, double w) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: h * 0.43,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
        ),
      ),
      20.kH,
      SizedBox(
        height: h * 0.095,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.all(4),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: w * 0.2,
                  decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
                ),
              ),
            );
          },
        ),
      ),
      Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: w * 0.6, height: 24, color: Colors.grey.shade300),
            10.kH,
            Container(width: w * 0.4, height: 18, color: Colors.grey.shade300),
            12.kH,
            Container(width: w * 0.9, height: 14, color: Colors.grey.shade300),
            20.kH,
            Container(width: w * 0.3, height: 22, color: Colors.grey.shade300),
            10.kH,
            Container(width: w * 0.5, height: 14, color: Colors.grey.shade300),
            20.kH,
            Container(width: w * 0.7, height: 18, color: Colors.grey.shade300),
            16.kH,
            Container(width: w * 0.8, height: 14, color: Colors.grey.shade300),
            6.kH,
            Container(width: w * 0.5, height: 15, color: Colors.grey.shade300),
            16.kH,
            Container(width: w * 0.8, height: 14, color: Colors.grey.shade300),
            6.kH,
            Container(width: w * 0.6, height: 15, color: Colors.grey.shade300),
          ],
        ),
      ),
    ],
  );
}

Widget shimmerAddressScreen(double h, double w) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
    child: ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(width: 25, height: 25, color: Colors.grey),
                    10.kW,
                    Container(width: w * 0.3, height: 18, color: Colors.grey),
                    10.kW,
                    Container(width: 50, height: 18, color: Colors.grey),
                  ],
                ),
                10.kH,
                Container(width: w * 0.6, height: 16, color: Colors.grey),
                6.kH,
                Container(width: w * 0.5, height: 16, color: Colors.grey),
              ],
            ),
          ),
        );
      },
    ),
  );
}

Widget shimmerRoundedLine(double w, double h) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      width: w,
      height: h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
    ),
  );
}

Widget shimmerList(double w, double h,{int list = 2}) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        list,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: w,
              height: h,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
            ),
          ),
        ),
      ),
    ),
  );
}
