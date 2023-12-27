import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Node;

import 'package:graphview/GraphView.dart';

import '../../../../model/model_fam_tree.dart';

class GraphViewww extends StatefulWidget {
  const GraphViewww({super.key});

  @override
  State<GraphViewww> createState() => _GraphViewwwState();
}

class _GraphViewwwState extends State<GraphViewww> {
  @override
  Widget build(BuildContext context) {
    listNode.clear();
    listUser.clear();
    dataFinal = modelFamTreeFromJson(
      jsonEncode(misdi),
    );

    funcGenerate(data: dataFinal);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Wrap(
          //   children: [
          //     SizedBox(
          //       width: 100,
          //       child: TextFormField(
          //         initialValue: builder.siblingSeparation.toString(),
          //         decoration:
          //             const InputDecoration(labelText: "Sibling Separation"),
          //         onChanged: (text) {
          //           builder.siblingSeparation = int.tryParse(text) ?? 100;
          //           setState(() {});
          //         },
          //       ),
          //     ),
          //     SizedBox(
          //       width: 100,
          //       child: TextFormField(
          //         initialValue: builder.levelSeparation.toString(),
          //         decoration:
          //             const InputDecoration(labelText: "Level Separation"),
          //         onChanged: (text) {
          //           builder.levelSeparation = int.tryParse(text) ?? 100;
          //           setState(() {});
          //         },
          //       ),
          //     ),
          //     SizedBox(
          //       width: 100,
          //       child: TextFormField(
          //         initialValue: builder.subtreeSeparation.toString(),
          //         decoration:
          //             const InputDecoration(labelText: "Subtree separation"),
          //         onChanged: (text) {
          //           builder.subtreeSeparation = int.tryParse(text) ?? 100;
          //           this.setState(() {});
          //         },
          //       ),
          //     ),
          //     SizedBox(
          //       width: 100,
          //       child: TextFormField(
          //         initialValue: builder.orientation.toString(),
          //         decoration: const InputDecoration(labelText: "Orientation"),
          //         onChanged: (text) {
          //           builder.orientation = int.tryParse(text) ?? 100;
          //           this.setState(() {});
          //         },
          //       ),
          //     ),
          //     ElevatedButton(
          //       onPressed: () {
          //         final node12 = Node.Id(r.nextInt(100));
          //         var edge =
          //             graph.getNodeAtPosition(r.nextInt(graph.nodeCount()));
          //         print(edge);
          //         graph.addEdge(edge, node12);
          //         setState(() {});
          //       },
          //       child: const Text("Add"),
          //     )
          //   ],
          // ),
          Expanded(
            child: InteractiveViewer(
                constrained: false,
                boundaryMargin: const EdgeInsets.all(100),
                minScale: 0.1,
                maxScale: 100,
                child: GraphView(
                  graph: graph,
                  algorithm: BuchheimWalkerAlgorithm(
                      builder, TreeEdgeRenderer(builder)),
                  paint: Paint()
                    ..color = Colors.green
                    ..strokeWidth = 1
                    ..style = PaintingStyle.stroke,
                  builder: (Node node) {
                    // I can decide what widget should be shown here based on the id
                    var a = node.key!.value as int;
                    var data =
                        listUser.firstWhereOrNull((element) => element.id == a);
                    if (data != null) {
                      return rectangleWidget(data);
                    } else {
                      return rectangleWidget(
                        ModelFamTree(
                          name: "undefinied name",
                          id: Random.secure().nextInt(1000) + 5,
                        ),
                      );
                    }
                  },
                )),
          ),
        ],
      ),
    );
  }

  Random r = Random();

  Widget rectangleWidget(ModelFamTree data) {
    return InkWell(
      onTap: () {
        print('clicked');
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
          ],
        ),
        child: Text(
          data.name ?? "undefinied",
        ),
      ),
    );
  }

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  var listNode = <Node>[];
  var listUser = <ModelFamTree>[];
  funcGenerate({required List<ModelFamTree> data}) async {
    for (var i in data) {
      if (listUser.firstWhereOrNull((element) => element.id == i.id) == null) {
        listNode.add(Node.Id(i.id));
        listUser.add(
          i,
        );
      }

      for (var connect in i.child!) {
        graph.addEdge(
          Node.Id(i.id),
          Node.Id(connect.id),
        );
      }
      funcGenerate(data: i.child ?? <ModelFamTree>[]);
    }

    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }

  var misdi = [
    {
      "name": "misdi",
      "id": 1,
      "child": [
        {
          "name": "sulatin",
          "id": 2,
          "child": [
            {
              "name": "bashori",
              "id": 3,
              "child": [
                {
                  "name": "mud",
                  "id": 8,
                  "child": [
                    {
                      "name": "mbak ayuk",
                      "id": 9,
                      "child": [
                        {
                          "name": "mas nabil",
                          "id": 10,
                          "child": [],
                        },
                        {
                          "name": "aya",
                          "id": 11,
                          "child": [],
                        }
                      ],
                    },
                  ]
                }
              ]
            },
            {
              "name": "muharom",
              "id": 4,
              "child": [
                {
                  "name": "mur",
                  "id": 12,
                  "child": [
                    {
                      "name": "nanda",
                      "id": 13,
                      "child": [],
                    },
                    {
                      "name": "kessy",
                      "id": 14,
                      "child": [],
                    }
                  ],
                }
              ]
            },
            {
              "name": "agung",
              "id": 5,
              "child": [],
            },
            {
              "name": "patrin",
              "id": 6,
              "child": [],
            },
            {
              "name": "ikom",
              "id": 7,
              "child": [],
            }
          ]
        }
      ]
    },
    {
      "name": "SUPARDI",
      "id": 100,
      "child": [
        {
          "name": "SUPARfDI",
          "id": 101,
          "child": [
            {
              "name": "SUsPARDI",
              "id": 102,
              "child": [],
            },
          ],
        },
      ],
    },
  ];

  List<ModelFamTree> dataFinal = [];

  @override
  void initState() {
    super.initState();

    // final node1 = Node.Id(1);
    // final node2 = Node.Id(2);
    // final node3 = Node.Id(3);
    // final node4 = Node.Id(4);
    // final node5 = Node.Id(5);
    // final node6 = Node.Id(6);
    // final node7 = Node.Id(7);
    // // final node12 = Node.Id(12);

    // graph.addEdge(node1, node2);
    // graph.addEdge(node2, node3);
    // graph.addEdge(node2, node4);
    // graph.addEdge(node2, node5);
    // graph.addEdge(node2, node6);
    // graph.addEdge(node2, node7);
  }
}
