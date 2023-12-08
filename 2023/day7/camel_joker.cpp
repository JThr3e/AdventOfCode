#include <iostream>
#include <vector>
#include <string>
#include <fstream>
#include <bits/stdc++.h>

#include "joker_hand.h"


struct sort_key {
    inline bool operator()(JokerHand &hand1, JokerHand &hand2) {
        return hand1.is_more_powerful(hand2);
    }
};


int main ()
{
  std::string hand_init;
  std::string bid_init;
  std::ifstream ipt_file("input");
  std::vector<JokerHand> hands;
  if (ipt_file.is_open())
  {
    while (std::getline(ipt_file, hand_init, ' ')) {
      std::getline(ipt_file, bid_init, '\n');
      JokerHand hand(hand_init, bid_init);
      hands.push_back(hand);
    }
    ipt_file.close();
  }
  std::sort(hands.begin(), hands.end(), sort_key());
  for(auto hand : hands) {
      std::cout << hand.get_str() << std::endl;
  }
  int score = 0;
  for(int i = 0; i < hands.size(); i++){
      int multiplier = hands.size() - i;
      std::cout << hands[i].get_str() << ", bid: " << hands[i].get_bid() << ", multiplier: " << multiplier << std::endl;
      score += hands[i].get_bid() * multiplier;
  }
  std::cout << score << std::endl;
  return 0;
}
