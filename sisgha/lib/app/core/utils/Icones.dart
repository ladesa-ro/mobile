// ignore_for_file: file_names, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sizer/sizer.dart';

class Icones {
  //IcoMoon
  static const IconData PersonVazio = IconData(0xe906, fontFamily: 'IcoMoon');

  static const IconData PersonCheio = IconData(0xe907, fontFamily: 'IcoMoon');

  static const IconData Relogio = IconData(0xe904, fontFamily: 'IcoMoon');

  static const IconData IconeSisgha = IconData(0xe903, fontFamily: 'IcoMoon');

  static const IconData CalendarVazio = IconData(0xe900, fontFamily: 'IcoMoon');

  static const IconData CalendarCheio = IconData(0xe901, fontFamily: 'IcoMoon');

  static const IconData Sair = IconData(0xe905, fontFamily: 'IcoMoon');

  static const IconData Disciplina = IconData(0xe902, fontFamily: 'IcoMoon');

  //iconify

  static const String Sino =
      '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M15 17v1a3 3 0 1 1-6 0v-1m6 0H9m6 0h3.59c.383 0 .575 0 .73-.052a1 1 0 0 0 .627-.628c.053-.156.053-.348.053-.734c0-.169 0-.253-.014-.334a.998.998 0 0 0-.173-.42c-.048-.067-.108-.127-.227-.246l-.39-.39a.67.67 0 0 1-.196-.474V10a7 7 0 1 0-14 0v3.722a.67.67 0 0 1-.196.474l-.39.39c-.12.12-.179.179-.226.245a1 1 0 0 0-.175.421c-.013.08-.013.165-.013.334c0 .386 0 .578.052.734a1 1 0 0 0 .629.628c.155.052.346.052.729.052H9"/></svg>';

  static const String SetaBaixo =
      '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><path fill="currentColor" fill-rule="evenodd" d="M7 9a1 1 0 0 0-.707 1.707l5 5a1 1 0 0 0 1.414 0l5-5A1 1 0 0 0 17 9z" clip-rule="evenodd"/></svg>';

  static const String Lapiz =
      '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 14 14"><path fill="currentColor" d="M10.715-.001a1.5 1.5 0 0 0-1.07.449L1.407 8.645a.5.5 0 0 0-.128.22l-1.26 4.5a.5.5 0 0 0 .616.616l4.5-1.26a.5.5 0 0 0 .22-.128l8.197-8.238l.002-.001a1.5 1.5 0 0 0 0-2.128l-.002-.001L11.786.449a1.499 1.499 0 0 0-1.071-.45"/></svg>';

  static const String setaEsquerda =
      '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 20 20"><path fill="currentColor" fill-rule="evenodd" d="m13.42 2.296l-8.047 6.94A.92.92 0 0 0 5 10q0 .472.41.797l8.01 6.907q.48.402 1.032.267q.45-.131.548-.607v-14.7a.76.76 0 0 0-.526-.628q-.574-.137-1.054.26"/></svg>';

  static const String setaDireita =
      '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 20 20"><path fill="currentColor" fill-rule="evenodd" d="M5 2.643v14.765q.138.48.619.572q.48.091.94-.255l8.107-6.993A.94.94 0 0 0 15 10a.94.94 0 0 0-.334-.73L6.58 2.295c-.232-.197-.639-.383-1.061-.253q-.423.13-.519.6"/></svg>';

  static const String setaVoltarEsquerda =
      '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 12h14m-6 6l6-6m-6-6l6 6"/></svg>';
  static const String setaVoltarDireita =
      '<svg xmlns="http://www.w3.org/2000/svg" width="512" height="512" viewBox="0 0 512 512"><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="48" d="M244 400L100 256l144-144M120 256h292"/></svg>';

  static const String visibilidadeSenhaOff =
      '<svg xmlns="http://www.w3.org/2000/svg" width="21" height="21" viewBox="0 0 21 21"><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" d="M6.211 6.26Q3.985 7.63 2 10.5Q5.805 16 10.5 16q2.135 0 4.085-1.137m1.588-1.14Q17.643 12.46 19 10.5Q15.195 5 10.5 5q-1.245 0-2.429.387M4 4l13 13.071"/></svg>';

  static const String visibilidadeSenhaOn =
      '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M12.005 15.154q1.524 0 2.586-1.067t1.063-2.591t-1.067-2.587t-2.591-1.063t-2.587 1.067t-1.063 2.592t1.067 2.586t2.592 1.063M12 14.2q-1.125 0-1.912-.787T9.3 11.5t.788-1.912T12 8.8t1.913.788t.787 1.912t-.787 1.913T12 14.2m0 3.8q-2.966 0-5.44-1.57t-3.996-4.114q-.125-.207-.178-.407t-.053-.41t.053-.41t.178-.405Q4.087 8.14 6.56 6.57T12 5t5.44 1.57t3.997 4.115q.125.205.178.405t.052.411t-.052.41t-.178.405q-1.523 2.545-3.997 4.115T12 18m0-1q2.825 0 5.188-1.487T20.8 11.5q-1.25-2.525-3.613-4.012T12 6T6.813 7.488T3.2 11.5q1.25 2.525 3.613 4.013T12 17"/></svg>';

  //Outros
// ignore: non_constant_identifier_names
  static Icon Lupa = Icon(
    Icons.search,
    color: ColorsTemaClaro.branco,
    size: 4.h,
  );
}
