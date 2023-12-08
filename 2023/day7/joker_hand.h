#include <string>
#include <vector>
#include <map>
#include <iostream>

#include "hand.h"

class JokerHand : public Hand {
  public:
      
      JokerHand(std::string hand_init, std::string bid_init): Hand(hand_init, bid_init) {
          std::cout << "HELLO1!!" << std::endl;
	  cards_.clear();
	  init_cards(hand_init);
      }

      void init_cards(std::string cards) override {
          std::cout << "HELLO2!!" << std::endl;
          for(auto &ch : cards){
	      if(ch == 'A') cards_.push_back(14);
	      else if(ch == 'K') cards_.push_back(13);
	      else if(ch == 'Q') cards_.push_back(12);
	      else if(ch == 'J') cards_.push_back(1);
	      else if(ch == 'T') cards_.push_back(10);
	      else cards_.push_back(ch-'0');
	  }
      } 

      bool highest_card_first(JokerHand &other){
          std::cout << "HELLO4!!" << std::endl;
          auto other_cards = other.get_cards();
          for(int i = 0; i < cards_.size(); i++){
	      if(cards_[i] != other_cards[i]){
	          return cards_[i] > other_cards[i];
	      }
	  }
	  return true;
      }

      HandType get_hand_type() override {
          std::cout << "HELLO3!!" << std::endl;
          std::map<int, int> card_count;
	  std::map<int, int> matches;
	  int num_jokers = 0;
	  for (auto card : cards_){
	      if (card == 1){
		  num_jokers += 1;
	      }
	      card_count[card]+=1;
	  }
	  int max_k = -1;
	  int max_v = -1;
          for(auto &[key, val] : card_count){
	      if (val > max_v) {
	          max_v = val;
		  max_k = key;
	      }
	  }
	  if (max_k != 1) card_count[max_k] += num_jokers;

	  for(auto &[key, val] : card_count){
	      matches[val]+=1;
	  }
	  if(matches.find(5) != matches.end()) return HandType::FIVE;
	  if(matches.find(4) != matches.end()) return HandType::FOUR;
	  if(matches.find(3) != matches.end() && matches.find(2) != matches.end()) return HandType::FULL;
	  // new posible edge case for full houses, only possible in joker hands
          //if(matches.find(3) != matches.end() && matches.find(3) != matches.end()) return HandType::FULL; 
	  if(matches.find(3) != matches.end()) return HandType::THREE;
	  if(matches.find(2) != matches.end() && matches[2] >= 2) return HandType::TWOPAIR;
	  if(matches.find(2) != matches.end() && matches[2] == 1) return HandType::ONEPAIR;
	  return HandType::HIGH;
      }
     
      bool is_more_powerful(JokerHand &other) {
          std::cout << "HELLO5!!" << std::endl;
	  auto this_hand_type = get_hand_type();
	  auto other_hand_type = other.get_hand_type();
          if (this_hand_type == other_hand_type){
	      return highest_card_first(other);
	  } else {
	      return this_hand_type > other_hand_type;
	  }
      }


};
