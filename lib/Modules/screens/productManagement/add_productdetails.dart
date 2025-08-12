import 'package:bhk_artisan/common/commonmethods.dart';
import 'package:bhk_artisan/common/gradient.dart';
import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/data/response/status.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/inputformatter.dart';
import 'package:bhk_artisan/routes/routes_class.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controller/addproductdetailscontroller.dart';

class AddProductDetails extends ParentWidget {
  const AddProductDetails({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    AddProductDetailsController controller = Get.put(AddProductDetailsController());
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: const Color.fromARGB(195, 247, 243, 233),
            appBar: AppBar(
              flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppGradients.customGradient)),
              actions: [
                controller.producteditId == false
                    ? InkWell(
                        onTap: () {
                          controller.addnewvariants(context);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.add, size: 20, color: Colors.white),
                            Text('Add More', style: TextStyle(color: Colors.white, fontSize: 14)),
                            SizedBox(width: 10),
                          ],
                        ),
                      )
                    : SizedBox(),
                SizedBox(width: 10),
              ],
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.white),
              title: Text(controller.producteditId == true ? "Edit Product".toUpperCase() : "Add Product".toUpperCase(), style: const TextStyle(fontSize: 16, color: Colors.white)),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.producteditId == true
                        ? const Row(
                            children: [
                              SizedBox(width: 5),
                              Icon(Icons.edit, size: 20.0, color: Colors.blue),
                              SizedBox(width: 10.0),
                              Text('Edit Product', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
                            ],
                          )
                        : const Row(
                            children: [
                              SizedBox(width: 5),
                              Icon(Icons.shopping_cart, size: 20.0, color: Colors.blue),
                              SizedBox(width: 10.0),
                              Text('Add Product', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
                            ],
                          ),
                    SizedBox(height: 5.0),
                    controller.producteditId == true
                        ? const Text(
                            'Edit and manage your product.',
                            style: TextStyle(fontSize: 11.0, color: Color.fromARGB(255, 140, 136, 136), fontWeight: FontWeight.bold),
                          )
                        : const Text(
                            'Add a new product to your store.',
                            style: TextStyle(fontSize: 11.0, color: Color.fromARGB(255, 140, 136, 136), fontWeight: FontWeight.bold),
                          ),
                    SizedBox(height: 25.0),
                    //buildCircle(1, 1),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: const Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Color", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                Text(
                                  " *",
                                  style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            flex: 7,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Size", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                Text(
                                  " *",
                                  style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color.fromARGB(197, 113, 113, 113), width: 1.5),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: DropdownButton2<String>(
                                hint: Text("Select a Colour"),
                                style: TextStyle(fontSize: 14, color: Colors.black),
                                value: controller.selectedColorcheck.value,
                                alignment: Alignment.center,
                                items: controller.getColorModel.value.data?[0].value?.map((String color) {
                                  return DropdownMenuItem(
                                    alignment: AlignmentDirectional.center,
                                    value: color,
                                    child: Row(
                                      children: <Widget>[
                                        Container(width: 20.0, height: 20.0, color: controller.getColor(color)),
                                        const SizedBox(width: 15.0),
                                        Text(color),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  controller.selectedColor.value = newValue ?? "";
                                  controller.selectedColorcheck.value = newValue ?? "";
                                },
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: MediaQuery.of(context).size.height * .25,
                                  width: MediaQuery.of(context).size.width * .44,
                                  offset: const Offset(-10, -2),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                                ),
                                dropdownSearchData: DropdownSearchData(
                                  searchController: controller.colorController.value,
                                  searchInnerWidgetHeight: 50,
                                  searchInnerWidget: Container(
                                    height: 50,
                                    padding: const EdgeInsets.only(top: 8, bottom: 4, right: 8, left: 8),
                                    child: TextFormField(
                                      expands: true,
                                      maxLines: null,
                                      controller: controller.colorController.value,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        hintText: 'Search Your Colour',
                                        hintStyle: const TextStyle(fontSize: 12),
                                        border: OutlineInputBorder(borderSide: BorderSide(width: 2.0), borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(82, 151, 92, 71), width: 2.0)),
                                      ),
                                    ),
                                  ),
                                  searchMatchFn: (item, searchValue) {
                                    return item.value
                                        .toString()
                                        .toLowerCase() // Convert item value to lowercase
                                        .contains(searchValue.toLowerCase()); // Convert search value to lowercase
                                  },
                                ),
                                //This to clear the search value when you close the menu
                                onMenuStateChange: (isOpen) {
                                  if (!isOpen) {
                                    controller.colorController.value.clear();
                                  }
                                },
                                isExpanded: true,
                                underline: const SizedBox(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 5,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color.fromARGB(197, 113, 113, 113), width: 1.5),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: DropdownButton2<String>(
                                hint: Text("Select a Size"),
                                style: TextStyle(fontSize: 14, color: Colors.black),
                                value: controller.selectedSizecheck.value,
                                alignment: Alignment.center,
                                items: controller.getSizeModel.value.data?[0].value?.map((String size) {
                                  return DropdownMenuItem(alignment: AlignmentDirectional.center, value: size, child: Text(size));
                                }).toList(),
                                onChanged: (newValue) {
                                  controller.selectedSize.value = newValue ?? "";
                                  controller.selectedSizecheck.value = newValue ?? "";
                                },
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: MediaQuery.of(context).size.height * .25,
                                  width: MediaQuery.of(context).size.width * .44,
                                  offset: const Offset(-10, -2),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                                ),
                                dropdownSearchData: DropdownSearchData(
                                  searchController: controller.sizeController.value,
                                  searchInnerWidgetHeight: 50,
                                  searchInnerWidget: Container(
                                    height: 50,
                                    padding: const EdgeInsets.only(top: 8, bottom: 4, right: 8, left: 8),
                                    child: TextFormField(
                                      expands: true,
                                      maxLines: null,
                                      controller: controller.sizeController.value,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        hintText: 'Search Your Size',
                                        hintStyle: const TextStyle(fontSize: 12),
                                        border: OutlineInputBorder(borderSide: BorderSide(width: 2.0), borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(82, 151, 92, 71), width: 2.0)),
                                      ),
                                    ),
                                  ),
                                  searchMatchFn: (item, searchValue) {
                                    return item.value
                                        .toString()
                                        .toLowerCase() // Convert item value to lowercase
                                        .contains(searchValue.toLowerCase()); // Convert search value to lowercase
                                  },
                                ),
                                //This to clear the search value when you close the menu
                                onMenuStateChange: (isOpen) {
                                  if (!isOpen) {
                                    controller.sizeController.value.clear();
                                  }
                                },
                                isExpanded: true,
                                underline: const SizedBox(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Maximum Retail Price (MRP)", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                        Text(
                          " *",
                          style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    TextFormField(
                      validator: (value) {
                        if (value == '') {
                          return '*Required Field! Please enter MRP';
                        }
                        return null;
                      },
                      cursorColor: Colors.grey,
                      cursorWidth: 1.5,
                      style: const TextStyle(height: 1),
                      keyboardType: TextInputType.number,
                      controller: controller.mrpController.value,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(7)],
                      decoration: const InputDecoration(
                        hintText: 'Enter Maximum Retail Price',
                        prefixText: '₹ ',
                        hintStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(borderSide: BorderSide(width: 2.0), borderRadius: BorderRadius.all(Radius.circular(8.0))),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(82, 151, 92, 71), width: 2.0)),
                      ),
                      onChanged: (value) {
                        controller.calculateSellingPrice();
                      },
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: const Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Discount(%)", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                Text(
                                  " *",
                                  style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            flex: 7,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Selling Price", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                Text(
                                  " *",
                                  style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: TextFormField(
                              validator: (value) {
                                if (value == '') {
                                  return '*Required Field! Please Enter Discount';
                                }
                                return null;
                              },
                              cursorColor: Colors.grey,
                              cursorWidth: 1.5,
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly, RangeInputFormatter()],
                              style: const TextStyle(height: 1),
                              controller: controller.discountController.value,
                              decoration: const InputDecoration(
                                hintText: 'Enter discount',
                                suffixText: '%',
                                hintStyle: TextStyle(fontSize: 12),
                                border: OutlineInputBorder(borderSide: BorderSide(width: 2.0), borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(82, 151, 92, 71), width: 2.0)),
                              ),
                              onChanged: (value) {
                                controller.calculateSellingPrice();
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 5,
                            child: TextFormField(
                              cursorColor: Colors.grey,
                              cursorWidth: 1.5,
                              controller: TextEditingController(text: "₹ ${controller.sellingprice.value.toStringAsFixed(2)}"),
                              keyboardType: TextInputType.number,
                              readOnly: true,
                              style: const TextStyle(height: 1),
                              decoration: const InputDecoration(
                                hintText: '₹ 0',
                                hintStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                border: OutlineInputBorder(borderSide: BorderSide(width: 2.0), borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(82, 151, 92, 71), width: 2.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Quantity", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                        Text(
                          " *",
                          style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    TextFormField(
                      validator: (value) {
                        if (value == '') {
                          return '*Required Field! Please enter Quantity';
                        }
                        return null;
                      },
                      cursorColor: Colors.grey,
                      cursorWidth: 1.5,
                      style: const TextStyle(height: 1),
                      inputFormatters: [NoLeadingSpaceFormatter(), LengthLimitingTextInputFormatter(5), FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      controller: controller.quantityController.value,
                      decoration: const InputDecoration(
                        hintText: 'Enter Quantity',
                        hintStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(borderSide: BorderSide(width: 2.0), borderRadius: BorderRadius.all(Radius.circular(8.0))),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(82, 151, 92, 71), width: 2.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Net Weight (${controller.dropdownValues})", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                        const Text(
                          " *",
                          style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: TextFormField(
                              validator: (value) {
                                if (value == '') {
                                  controller.gm = true;
                                  return '*Required Field! Please enter Net Weight';
                                }
                                controller.gm = false;
                                return null;
                              },
                              cursorColor: Colors.grey,
                              cursorWidth: 1.5,
                              keyboardType: TextInputType.number,
                              inputFormatters: [NoLeadingSpaceFormatter(), LengthLimitingTextInputFormatter(7), FilteringTextInputFormatter.digitsOnly],
                              style: const TextStyle(height: 1),
                              controller: controller.netweightController.value,
                              decoration: InputDecoration(
                                hintText: 'Enter Net Weight(in ${controller.dropdownValues})',
                                hintStyle: const TextStyle(fontSize: 12),
                                border: const OutlineInputBorder(borderSide: BorderSide(width: 2.0), borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(82, 151, 92, 71), width: 2.0)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: controller.gm == true ? const EdgeInsets.fromLTRB(0, 0, 0, 20) : const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color.fromARGB(197, 113, 113, 113), width: 1.5),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: DropdownButton2<String>(
                                style: TextStyle(fontSize: 14, color: Colors.black),
                                value: controller.dropdownValues.value,
                                alignment: Alignment.center,
                                items: controller.weights.map((String value) {
                                  return DropdownMenuItem(
                                    alignment: AlignmentDirectional.center,
                                    value: value,
                                    child: Text(value, style: TextStyle(fontSize: 15)),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  controller.dropdownValues.value = newValue ?? "";
                                },
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: MediaQuery.of(context).size.height * .25,
                                  width: MediaQuery.of(context).size.width * .22,
                                  offset: const Offset(-10, -2),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                                ),
                                isExpanded: true,
                                underline: SizedBox(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Material", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                        Text(
                          " *",
                          style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    TextFormField(
                      validator: (value) {
                        if (value == '') {
                          return '*Required Field! Please enter Material Used';
                        }
                        return null;
                      },
                      cursorColor: Colors.grey,
                      cursorWidth: 1.5,
                      style: const TextStyle(height: 1),
                      controller: controller.materialController.value,
                      inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), SpecialCharacterValidator(), EmojiInputFormatter(), LengthLimitingTextInputFormatter(50)],
                      decoration: const InputDecoration(
                        hintText: 'Enter Material Used',
                        hintStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(borderSide: BorderSide(width: 2.0), borderRadius: BorderRadius.all(Radius.circular(8.0))),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(82, 151, 92, 71), width: 2.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Dimension(in L*B*H) in ${controller.dropdownValue}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                        const Text(
                          " *",
                          style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              validator: (value) {
                                if (value == '') {
                                  controller.gm = true;
                                  return '*Required Field! Please enter Dimension(in L*B*H)';
                                }
                                controller.gm = false;
                                return null;
                              },
                              cursorColor: Colors.grey,
                              cursorWidth: 1.5,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(height: 1),
                              controller: controller.lengthController.value,
                              inputFormatters: [NoLeadingSpaceFormatter(), FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4)],
                              decoration: const InputDecoration(
                                hintText: 'Length',
                                hintStyle: TextStyle(fontSize: 12),
                                border: OutlineInputBorder(borderSide: BorderSide(width: 2.0), borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(82, 151, 92, 71), width: 2.0)),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              validator: (value) {
                                if (value == '') {
                                  controller.gm = true;
                                  return '*Required Field! Please enter Dimension(in L*B*H)';
                                }
                                controller.gm = false;
                                return null;
                              },
                              cursorColor: Colors.grey,
                              cursorWidth: 1.5,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(height: 1),
                              controller: controller.breadthController.value,
                              inputFormatters: [NoLeadingSpaceFormatter(), FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4)],
                              decoration: const InputDecoration(
                                hintText: 'Breadth',
                                hintStyle: TextStyle(fontSize: 12),
                                border: OutlineInputBorder(borderSide: BorderSide(width: 2.0), borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(82, 151, 92, 71), width: 2.0)),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              validator: (value) {
                                if (value == '') {
                                  controller.gm = true;
                                  return '*Required Field! Please enter Dimension(in L*B*H)';
                                }
                                controller.gm = false;
                                return null;
                              },
                              cursorColor: Colors.grey,
                              cursorWidth: 1.5,
                              keyboardType: TextInputType.number,
                              inputFormatters: [NoLeadingSpaceFormatter(), FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4)],
                              style: const TextStyle(height: 1),
                              controller: controller.heightController.value,
                              decoration: const InputDecoration(
                                hintText: 'Height',
                                hintStyle: TextStyle(fontSize: 12),
                                border: OutlineInputBorder(borderSide: BorderSide(width: 2.0), borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(82, 151, 92, 71), width: 2.0)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            flex: 3,
                            child: Container(
                              margin: controller.gm == true ? const EdgeInsets.fromLTRB(0, 0, 0, 20) : const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color.fromARGB(197, 113, 113, 113), width: 1.5),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: DropdownButton2<String>(
                                style: TextStyle(fontSize: 14, color: Colors.black),
                                value: controller.dropdownValue.value,
                                alignment: Alignment.center,
                                items: controller.measureunits.map((String value) {
                                  return DropdownMenuItem(
                                    alignment: AlignmentDirectional.center,
                                    value: value,
                                    child: Text(value, style: TextStyle(fontSize: 15)),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  controller.dropdownValue.value = newValue ?? "";
                                },
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: MediaQuery.of(context).size.height * .25,
                                  width: MediaQuery.of(context).size.width * .275,
                                  offset: const Offset(-10, -3),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                                ),
                                isExpanded: true,
                                underline: SizedBox(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Description", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                        Text(
                          " *",
                          style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    TextFormField(
                      cursorColor: Colors.grey,
                      cursorWidth: 1.5,
                      validator: (value) {
                        if (value == '') {
                          return '*Required Field! Please enter description';
                        }
                        return null;
                      },
                      controller: controller.descriptionController.value,
                      maxLines: 2,
                      inputFormatters: [NoLeadingSpaceFormatter(), RemoveTrailingPeriodsFormatter(), LengthLimitingTextInputFormatter(1000)],
                      decoration: const InputDecoration(
                        hintText: 'Enter a description here...',
                        hintStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(borderSide: BorderSide(width: 2.0), borderRadius: BorderRadius.all(Radius.circular(8.0))),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(82, 151, 92, 71), width: 2.0)),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              if (controller.producteditId == false) {
                                if (controller.netweightController.value.text.isNotEmpty &&
                                    controller.descriptionController.value.text.isNotEmpty &&
                                    controller.quantityController.value.text.isNotEmpty &&
                                    controller.materialController.value.text.isNotEmpty &&
                                    controller.sizeController.value.text.isNotEmpty &&
                                    controller.mrpController.value.text.isNotEmpty &&
                                    controller.discountController.value.text.isNotEmpty &&
                                    controller.lengthController.value.text.isNotEmpty &&
                                    controller.breadthController.value.text.isNotEmpty &&
                                    controller.dropdownValue.value.isNotEmpty &&
                                    controller.dropdownValues.value.isNotEmpty &&
                                    controller.heightController.value.text.isNotEmpty &&
                                    controller.selectedColorcheck.value.isNotEmpty &&
                                    controller.sellingprice.value != 0.0) {
                                  controller.addvariants(context);
                                  controller.clickNext.value = false;
                                  controller.addProductVariantApi(context, controller.productId);
                                } else {
                                  CommonMethods.showToast("Please Fill All the Details");
                                }
                              } else {
                                controller.addvariants(context);
                                controller.clickNext.value = false;
                                controller.addProductVariantApi(context, controller.productId);
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.grey),
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            ),
                            child: Text(controller.producteditId == false ? 'Save as draft' : "Save", style: TextStyle(color: Colors.black)),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              Get.toNamed(RoutesClass.addproductmedia, arguments: {'productid': 0, 'producteditid': false, 'variantid': 0});
                              // if (controller.producteditId == false) {
                              //   if (controller.netweightController.value.text
                              //           .isNotEmpty &&
                              //       controller.descriptionController.value
                              //           .text.isNotEmpty &&
                              //       controller.quantityController.value.text
                              //           .isNotEmpty &&
                              //       controller.materialController.value.text
                              //           .isNotEmpty &&
                              //       controller.selectedSizecheck.value.isNotEmpty &&
                              //       controller.mrpController.value.text
                              //           .isNotEmpty &&
                              //       controller.discountController.value.text
                              //           .isNotEmpty &&
                              //       controller.lengthController.value.text
                              //           .isNotEmpty &&
                              //       controller.breadthController.value.text
                              //           .isNotEmpty &&
                              //       controller
                              //           .dropdownValue.value.isNotEmpty &&
                              //       controller
                              //           .dropdownValues.value.isNotEmpty &&
                              //       controller.heightController.value.text
                              //           .isNotEmpty &&
                              //       controller.selectedColorcheck.value
                              //           .isNotEmpty &&
                              //       controller.sellingprice.value != 0.0) {
                              //     controller.addvariants(context);
                              //     controller.clickNext.value = true;
                              //     controller.addProductVariantApi(
                              //         context, controller.productId);
                              //   } else {
                              //     CommonMethods.showToast(
                              //         "Please Fill All the Details");
                              //   }
                              // } else {
                              //   controller.addvariants(context);
                              //   controller.clickNext.value = true;
                              //   controller.addProductVariantApi(
                              //       context, controller.productId);
                              // }
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF5D2E17), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
                            child: const Row(
                              children: [
                                Text('Next step', style: TextStyle(color: Colors.white)),
                                Icon(Icons.arrow_forward, color: Colors.white),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          progressBarTransparent(controller.rxRequestStatus.value == Status.LOADING, MediaQuery.of(context).size.height, MediaQuery.of(context).size.width),
        ],
      ),
    );
  }
}
