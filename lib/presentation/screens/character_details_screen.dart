import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import '../../business_logic/cubit/characters_cubit.dart';
import '../../constans/my_colors.dart';
import '../../data/models/characters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailsScreen({super.key, required this.character});

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        //centerTitle: true,
        title: Text(
          character.nickName,
          style: const TextStyle(color: MyColors.myWhite),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
                color: MyColors.myWhite,
                fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent){
    return Divider(
      color: MyColors.myYellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }


  Widget checkIfQuotesAreLoaded(CharactersState state){
    if(state is QuotesLoaded){
      return displayRandomQuotesOrEmptySpace(state);
    }else{
      return showProgressIndicator();
    }
  }

  Widget displayRandomQuotesOrEmptySpace(state){ 
    var quotes = (state).quotes; 
    if(quotes.length !=0){ 
      int randomQuoteIndex = Random().nextInt(quotes.length -1); 
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: MyColors.myWhite,
            fontSize: 20,
            shadows: [
               Shadow(blurRadius: 7,color: MyColors.myYellow,offset: Offset(0,0))
            ],
            ),
          child: AnimatedTextKit(
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),  
            ],
            repeatForever: true, 
          ),
          ),
      );
    }else{
      return Container();
    }
  }

  Widget showProgressIndicator(){
    return const Center(
      child: CircularProgressIndicator(color: MyColors.myYellow),
    );
  }


  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getQuotes(character.name); 
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo('job : ',character.jobs.join(' / ')), 
                    buildDivider(315),

                    characterInfo('Appeared in : ',character.categoryForTwoSeries), 
                    buildDivider(250),

                    characterInfo('Seasons : ',character.appearenceOfSeasons.join(' / ')),  
                    buildDivider(280),

                    characterInfo('Status : ',character.statusIfDeadOrAlive), 
                    buildDivider(300),

                    character.betterCallSaulAppearence.isEmpty 
                    ? Container() 
                    : characterInfo('Better Call Sul Seassons : ',character.betterCallSaulAppearence.join(' / ')), 
                    character.betterCallSaulAppearence.isEmpty 
                    ? Container() 
                    :  buildDivider(280), 

                    characterInfo('Actor/Actress : ',character.actorName), 
                    buildDivider(235), 

                    const SizedBox(height: 20,),

                    BlocBuilder<CharactersCubit,CharactersState>(
                      builder: (context,state){
                        return checkIfQuotesAreLoaded(state);
                      },
                      ),

                  ],
                ),
              ),
              const SizedBox(height: 1100,),
            ],
            ),
          ),
        ],
      ),
    );
  }
}
