#include <gtest/gtest.h>

#include "card_test.hpp"
#include "deck_test.hpp"
#include "player_test.hpp"
#include "board_test.hpp"

int main(int argc, char** argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
