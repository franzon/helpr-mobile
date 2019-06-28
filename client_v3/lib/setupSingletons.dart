import 'package:client_v3/providers/SocketProvider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:client_v3/providers/CategoriesProvider.dart';
import 'package:client_v3/providers/ClientProvider.dart';
import 'package:client_v3/providers/ProvidersProvider.dart';
import 'package:client_v3/repositories/AddressRepository.dart';
import 'package:client_v3/repositories/CategoriesRepository.dart';
import 'package:client_v3/repositories/ClientRepository.dart';
import 'package:client_v3/repositories/ProvidersRepository.dart';

final GetIt getIt = GetIt();

void setupRepositories() {
  getIt.registerSingleton<ClientRepository>(ClientRepository());
  getIt.registerSingleton<AddressRepository>(AddressRepository());
  getIt.registerSingleton<CategoriesRepository>(CategoriesRepository());
  getIt.registerSingleton<ProvidersRepository>(ProvidersRepository());
}

void setupProviders() {
  getIt.registerSingleton<CategoriesProvider>(CategoriesProvider());
  getIt.registerSingleton<ClientProvider>(ClientProvider());
  getIt.registerSingleton<ProvidersProvider>(ProvidersProvider());
  getIt.registerSingleton<SocketProvider>(SocketProvider());
}
