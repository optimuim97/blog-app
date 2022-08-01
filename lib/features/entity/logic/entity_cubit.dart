import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:blogapp/constant.dart';
import 'package:blogapp/features/service/entity_provider.dart';
import 'package:blogapp/models/api_response.dart';

import 'package:meta/meta.dart';

part 'entity_state.dart';

class EntityCubit extends Cubit<EntityState> {
  EntityCubit() : super(EntityInitial());
  final EntityApiProvider _entityApiprovider = EntityApiProvider();
   Future getEntity() async {
    emit(EntityStateLoading());
    ApiResponse response = await _entityApiprovider.getEntity();
    log(response.error.toString());
    if (response.error == null) {
      final entity = response;
      emit(EntityStateLoaded(entity));
    } else if (response.error == unauthorized) {
      log('message');
    } else {
      
    }
  }
}
