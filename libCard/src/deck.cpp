#include <card/deck.hpp>

#include <algorithm>
#include <random>

namespace cg {
Deck::Deck(std::string&& name) : m_name(name), m_cards() {}

void Deck::shuffle() {
  std::shuffle(m_cards.begin(), m_cards.end(),
               std::mt19937{std::random_device{}()});
}
}
