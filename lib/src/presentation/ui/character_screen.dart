import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/presentation/bloc/character_bloc/main_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/character_bloc/main_bloc.dart';
import '../bloc/character_bloc/main_event.dart';
import '../components/character_card.dart';
import '../components/custom_appBar.dart';

@immutable
class CharactersScreen extends StatefulWidget {
  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late MainPageBloc _mainPageBloc;
  late ScrollController _scrollController;
  int _currentIndex = 0;

  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _mainPageBloc = BlocProvider.of<MainPageBloc>(context);
    _mainPageBloc.add(const GetTestDataOnMainPageEvent(1));
    _scrollController = ScrollController();
    _scrollController.addListener(_infinityScrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _mainPageBloc.close();
    super.dispose();
  }

  void _infinityScrollListener() {
    bool canFetch = (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent);
    if (canFetch) {
      _currentIndex = _scrollController.position.pixels.toInt();
      _mainPageBloc.add(const GetNextPageOnMainPageEvent());
      _jumpToIndex(_currentIndex);
    }
  }

  void _jumpToIndex(int index) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollController.jumpTo(index.toDouble());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: MyCustomAppBar(
      //   onSubmitedCallBack: (String) {},
      //   searchController: searchController,
      //   hintText: 'Search character',
      // ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => _mainPageBloc,
          child: BlocConsumer<MainPageBloc, MainPageState>(
            listener: (context, state) {},
            builder: (blocContext, state) {
              if (state is LoadingMainPageState) {
                return _loadingWidget();
              } else if (state is LoadingNextPageState) {
                return _successfulWidget(state);
              } else if (state is SuccessfulMainPageState) {
                return _successfulWidget(state);
              } else if (state is ErrorMainPageState) {
                return _alertMessageWidget(state.message);
              } else if (state is UnSuccessfulMainPageState) {
                return _emptyListWidget(context);
              } else {
                return Center(
                  child: _refreshButton(context),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _loadingWidget() {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: const CircularProgressIndicator(),
      ),
    );
  }

  Widget _successfulWidget(state) {
    _jumpToIndex(_currentIndex);
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 10),
            child: SizedBox(height: 60, child: SearchBarApp()),
          ),
          Expanded(
            flex: 10,
            child: ListView.builder(
              controller: _scrollController,
              cacheExtent: double.infinity,
              itemCount: state.characters.length + 1,
              itemBuilder: (context, index) {
                if (index == state.characters.length) {
                  return _loadingNextWidget();
                } else {
                  return CharacterCard(character: state.characters[index]);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _loadingNextWidget() {
    return Align(
      alignment: Alignment.topCenter,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Center(
          child: SizedBox(
            child: CircularProgressIndicator(
              strokeWidth: 4,
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.blueAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _alertMessageWidget(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            _refreshButton(context),
          ],
        ),
      ),
    );
  }

  Widget _refreshButton(context) {
    return IconButton(
      icon: Icon(
        Icons.refresh,
        size: 50,
      ),
      onPressed: () => _mainPageBloc.add(const GetTestDataOnMainPageEvent(1)),
    );
  }

  Widget _emptyListWidget(context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              child: Icon(
            Icons.hourglass_empty_sharp,
            size: 300,
            color: Colors.amber,
          )),
          Text(
            "No Data !",
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 40),
          ),
          SizedBox(
            height: 70,
          ),
          IconButton(
            icon: Icon(
              Icons.refresh,
              size: 50,
            ),
            onPressed: () =>
                _mainPageBloc.add(const GetTestDataOnMainPageEvent(1)),
          ),
        ],
      ),
    );
  }
}
