#include <string>
#include <vector>
#include <map>

class Hand {
  protected:
      std::vector<int> cards_;
      int bid_;
      std::string cards_str_;
  public:
      Hand(std::string cards, std::string bid){ 
	  bid_ = std::stoi(bid);
	  cards_str_ = cards;
	  init_cards(cards);
      }

      virtual void init_cards(std::string cards){
          for(auto &ch : cards){
	      if(ch == 'A') cards_.push_back(14);
	      else if(ch == 'K') cards_.push_back(13);
	      else if(ch == 'Q') cards_.push_back(12);
	      else if(ch == 'J') cards_.push_back(11);
	      else if(ch == 'T') cards_.push_back(10);
	      else cards_.push_back(ch-'0');
	  }
      }
      
      std::vector<int> get_cards(){
          return cards_;
      }

      int get_bid() {
	  return bid_;
      }

      std::string get_str(){
          return cards_str_;
      }

      enum HandType {HIGH, ONEPAIR, TWOPAIR, THREE, FULL, FOUR, FIVE};

      virtual HandType get_hand_type() {
          std::map<int, int> card_count;
	  std::map<int, int> matches;
	  for (auto card : cards_){
	      card_count[card]+=1;
	  }
	  for(auto &[key, val] : card_count){
	      matches[val]+=1;
	  }
	  if(matches.find(5) != matches.end()) return HandType::FIVE;
	  if(matches.find(4) != matches.end()) return HandType::FOUR;
	  if(matches.find(3) != matches.end() && matches.find(2) != matches.end()) return HandType::FULL;
	  if(matches.find(3) != matches.end()) return HandType::THREE;
	  if(matches.find(2) != matches.end() && matches[2] == 2) return HandType::TWOPAIR;
	  if(matches.find(2) != matches.end() && matches[2] == 1) return HandType::ONEPAIR;
	  return HandType::HIGH;
      }

      bool highest_card_first(Hand &other) {
          auto other_cards = other.get_cards();
          for(int i = 0; i < cards_.size(); i++){
	      if(cards_[i] != other_cards[i]){
	          return cards_[i] > other_cards[i];
	      }
	  }
	  return true;
      }

      bool highest_card(Hand &other) {
	  auto this_high = std::max_element(cards_.begin(), cards_.end());
          auto other_cards = other.get_cards();
	  auto other_high = std::max_element(other_cards.begin(), other_cards.end());
	  return this_high > other_high;
      }

      bool is_more_powerful(Hand &other) {
	  auto this_hand_type = get_hand_type();
	  auto other_hand_type = other.get_hand_type();
          if (this_hand_type == other_hand_type){
	      return highest_card_first(other);
	  } else {
	      return this_hand_type > other_hand_type;
	  }
      }
};
