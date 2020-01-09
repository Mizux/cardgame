#include <gtest/gtest.h>

#include <card/player.hpp>

class PlayerTest : public ::testing::Test {
 protected:
  PlayerTest() : Test(), m_player("Init") {}

  virtual void SetUp() { m_player = cg::Player("Init"); }
  virtual void TearDown() {}

  // The mock bar library shaed by all tests
  cg::Player m_player;
};

TEST_F(PlayerTest, name) {
  m_player = cg::Player("Foo");
  EXPECT_EQ("Foo", m_player.name());
}
