import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final List data = [
    {
      'url':
          'https://media.istockphoto.com/id/532186572/pt/foto/carros-no-parque-de-estacionamento-em-linha.jpg?s=612x612&w=0&k=20&c=obDZpnC-juC_KhDA9KIqO5tWQUR2io2LAEOOodG-k0Y='
    },
    {
      'url':
          'https://garagem360.com.br/wp-content/uploads/2023/03/carros-da-chevrolet.jpg'
    },
    {
      'url':
          'https://www.automaxfiat.com.br/wp-content/uploads/2021/03/tipos-de-carros-1024x683.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.all(8.0)),
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            height: 250,
          ),
          items: data.map((item) {
            return GridTile(
              child: Image.network(item['url'], fit: BoxFit.cover),
            );
          }).toList(),
        ),
      ],
    );
  }
}
