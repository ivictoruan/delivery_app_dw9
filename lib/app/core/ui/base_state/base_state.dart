import 'package:bloc/bloc.dart';
import 'package:delivery_app_dw9/app/core/ui/helpers/loader_mixin.dart';
import 'package:delivery_app_dw9/app/core/ui/helpers/messages_mixin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class BaseState<T extends StatefulWidget, C extends BlocBase>
    extends State<T> with LoaderMixin, MessagesMixin {
      late final C controller; 

      @override
      void initState() {
        super.initState();
        controller = context.read<C>();
        WidgetsBinding.instance.addPostFrameCallback(((timeStamp) {
          onReady();
        }));
      }
      // método chamado quando a tela é contruída!
      void onReady(){} 
    }
