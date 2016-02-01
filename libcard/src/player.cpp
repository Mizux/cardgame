#include <card/player.hpp>

namespace cg {

Player::Player(std::string&& name)
    : m_name(name), m_hand(), m_deck("Empty"), m_discard("Discard") {}

std::string Player::name() const {
  return m_name;
}
}
