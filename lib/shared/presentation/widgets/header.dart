import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String imagePath; // Ruta de la imagen
  final String title; // Título principal
  final String subtitle; // Subtítulo adicional
  final String item; // Subtítulo adicional
  final double heightScale;

  const Header(
      {Key? key,
      required this.imagePath,
      required this.title,
      required this.subtitle,
      required this.item,
      required this.heightScale})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20), // Ajusta el padding horizontal
          child: Center(
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Centra verticalmente
              children: [
                // Imagen
                Image.asset(
                  imagePath, // Ruta de la imagen
                  width: 70 * heightScale,
                  height: 100 * heightScale,
                ),
                const SizedBox(
                    width: 10), // Espacio entre la imagen y los textos

                // Textos
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 20.0 * heightScale), // Ajusta el padding
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Centra los textos
                    children: [
                      // Título principal
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 19 * heightScale,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      // Subtítulo (gris oscuro)
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 18 * heightScale,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),

                      // Descripción adicional
                      Text(
                        item,
                        style: TextStyle(
                          fontSize: 15 * heightScale,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 5), // Espacio extra después del header
      ],
    );
  }
}
