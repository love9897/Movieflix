import 'package:flutter/material.dart';

import '../others/data_model.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.name,
    required this.show,
  });
  final String? name;
  final Show? show;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    String imageURl = '${widget.show?.image?.original}';
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.name}'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Card(
            surfaceTintColor: Colors.white,
            child: Column(
              children: [
                imageURl == 'null'
                    ? Image.asset('images/no-image.png')
                    : Image.network(
                        '${widget.show?.image?.original}',
                        fit: BoxFit.fitHeight,
                        height: 250,
                        scale: 1.0,
                        width: MediaQuery.sizeOf(context).width,
                        alignment: Alignment.center,
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12, right: 8.0),
                      child: Text(
                        '${widget.show!.premiered}' == "null"
                            ? ""
                            : '${widget.show!.premiered}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        '${widget.show!.ended}' == 'null'
                            ? ''
                            : '${widget.show!.ended}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Rating: ${widget.show!.rating!.average}',
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.amberAccent),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${widget.name}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 10),
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                        text: 'Summary:',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        children: [
                          TextSpan(
                            text: widget.show!.summary,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.black54),
                          )
                        ]),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 10),
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                        text: 'Language:  ',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                        children: [
                          TextSpan(
                            text: widget.show!.language,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.black54),
                          ),
                        ]),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 10),
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                        text: 'Genres:  ',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                        children: [
                          TextSpan(
                            text: widget.show!.genres.toString(),
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.black54),
                          ),
                        ]),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 10),
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                        text: 'Status:  ',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                        children: [
                          TextSpan(
                            text: widget.show!.status,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.black54),
                          ),
                        ]),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 10),
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                        text: 'Official Site:  ',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                        children: [
                          TextSpan(
                            text: widget.show!.officialSite == 'null'
                                ? 'null'
                                : widget.show!.officialSite,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.blue),
                          ),
                        ]),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}
