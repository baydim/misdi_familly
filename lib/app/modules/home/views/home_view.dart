import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:misdi_familly/app/modules/home/views/graph/graph_view.dart';

import '../controllers/home_controller.dart';
import 'fancy/fancy_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => GraphViewww());
                  },
                  child: Text("GRAPH"),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => MyTreeView());
                  },
                  child: Text("FANCY"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
