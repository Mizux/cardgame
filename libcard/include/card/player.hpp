#pragma once

#include <string>
#include <vector>
#include "card.hpp"
#include "deck.hpp"
#include "ressource.hpp"

namespace cg {
struct Player {
  Player(std::string&& name);

  std::string name() const;

 protected:
  std::string m_name;
  std::vector<Card> m_hand;
  Deck m_deck;
  Deck m_discard;
  std::vector<Ressource> m_ressources;
};
}
