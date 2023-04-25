#ifndef STATE_H
#define STATE_H

#include "board.h"
#include "common.h"
#include "sequence.h"

#define SNAKE_FOUND 2
#define LADDER_FOUND 3

typedef struct {
    Board* board;
    int position;
    int finished;
    Sequence sequence; //sequence of dices and moves
} State;

void init_state(State* state, Board* board);

int get_current_position(State* state);
void set_current_position(State* state, int position);

int is_finished(State* state);
void set_finished(State* state, int finished);

void reset(State* state);

int move(State* state, int dice_value);

void add_step(State* state, int dice_value);
void print_state_sequence(State* state);
#endif //DUNGEON_STATE_H
