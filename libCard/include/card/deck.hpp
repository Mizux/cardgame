#pragma once

#include <vector>
#include "card.hpp"

namespace cg {

struct Deck {
  Deck(std::string&& name);

  void shuffle();

 protected:
  std::string m_name;
  std::vector<Card> m_cards;
};
}
