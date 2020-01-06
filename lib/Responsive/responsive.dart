import 'package:flutter/material.dart';

//tela home resposiva celular

double height(BuildContext context,
    {double heightV, double maxV, double heightH, double maxH}) {
  MediaQueryData data = MediaQuery.of(context);

  //Configurando valores nulos add valores padrões
  heightH = heightH ?? heightV;
  maxV = maxV ?? data.size.height;
  maxH = maxH ?? data.size.height;

  heightV = data.size.height * heightV;
  heightH = data.size.height * heightH;

  bool orientation =
      data.orientation.toString() == "Orientation.portrait" ? true : false;

  if (orientation) {
    bool check = heightV < maxV ? true : false;
    // print("vertical");
    // print("heightV:${heightV.truncate()} maxV:${maxV.truncate()}");
    // print("heightV < maxV ? $check");
    //  print("Return ${check ? heghtV: maxV}");
    return check ? heightV : maxV;
  } else {
    bool check = heightH < maxH ? true : false;
    //  print("Horizoltal");
    //  print("heightH:${heightH.truncate()} maxH:${maxH.truncate()}");
    //  print("heightH < maxH ? $check");
    //  print("Return ${check ? heghtH: maxH}");
    return check ? heightH : maxH;
  }
}

double width(BuildContext context,
    {double widthV, double maxV, double widthH, double maxH}) {
  MediaQueryData data = MediaQuery.of(context);

  //Configurando valores nulos add valores padrões
  widthH = widthH ?? widthV;
  maxV = maxV ?? data.size.width;
  maxH = maxH ?? data.size.width;

  widthV = data.size.width * widthV;
  widthH = data.size.width * widthH;

  bool orientation =
      data.orientation.toString() == "Orientation.portrait" ? true : false;

  if (orientation) {
    bool check = widthV < maxV ? true : false;
    // print("vertical");
    // print("widthV:${widthV.truncate()} maxV:${maxV.truncate()}");
    // print("widthV < maxV ? $check");
    // print("Return ${check ? widthV: maxV}");
    return check ? widthV : maxV;
  } else {
    bool check = widthH < maxH ? true : false;
    // print("Horizoltal");
    // print("widthH:${widthH.truncate()} maxH:${maxH.truncate()}");
    // print("widthH < maxH ? $check");
    // print("Return ${check ? widthH: maxH}");
    return check ? widthH : maxH;
  }
}

//converter valor fixo para responsivo

// convert() {
//   double v = 55;
//   double t = 0;
//   for (double i = 0; t.round() != v; i = i + 0.001) {
//     print("passo: $i\n");
//     t = height(context, heightV: i);
//     print(t);
//   }
// }
