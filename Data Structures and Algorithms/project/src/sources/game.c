#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/select.h>
#include <unistd.h>

#include "../headers/game.h"
#include "../headers/utils.h"
#include "../headers/state.h"
#include "../headers/board_utils.h"

#define MAX_ITERATIONS 1000

char show_game_options() {

    char option = read_char_option("Press T for throwing the dice, P for showing the sequence, Q for quit\n");
    return option;
}

int wait_keypress(int usec) {
    struct timeval timeout = {0, usec};
    fd_set fds;
    FD_ZERO(&fds);
    FD_SET(STDIN_FILENO, &fds);
    int ret = select(1, &fds, NULL, NULL, &timeout);
    if (ret == -1) {
        //printf("Oops! Something wrong happened...\n");
    } else if (ret == 0) {
        //printf("Doesn't matter. You're too slow!\n");
    } else {
        flush_input();
    }
    return ret;
}

int throw_dice(int with_rolling) {
    int value = (rand() % 6) + 1;

    if (with_rolling == TRUE) {
        int iterations = 0;
        int keypressed = FALSE;
        while (keypressed == FALSE && iterations < MAX_ITERATIONS) {
            value = (rand() % 6) + 1;
            printf("\rRolling... %d (Press Enter)", value);
            fflush(NULL);
            keypressed = wait_keypress(10000);
            iterations++;
        }
        if (iterations >= MAX_ITERATIONS) {
            printf("\n");
        }
        value = (rand() % 6) + 1;
        printf("\rLast roll: %d!\n", value);
    } else {
        printf("Dice roll... %d!\n", value);
    }

    return value;
}

void start_game(Board *board) {

    State state;
    init_state(&state, board);


    int quit = FALSE;
    printf("Starting game...\n\n");
    while (quit == FALSE) {

        int current_position = get_current_position(&state);

        draw_zigzag_board(stdout, board, current_position);
        char option = show_game_options();

        if (option == THROW_DICE) {
            int dice_value = throw_dice(FALSE);

            int move_status = move(&state, dice_value);
            if (move_status == SNAKE_FOUND) {
                printf("You found a snake... :(\n");

            } else if (move_status == LADDER_FOUND) {
                printf("You found a ladder! :D\n");
            }

            if (is_finished(&state) == TRUE) {
                quit = TRUE;
            }
            add_step(&state, dice_value);

        } else if (option == SHOW_SEQUENCE) {
            printf("Steps:\n");
            print_state_sequence(&state);

        } else if (option == QUIT) {
            quit = TRUE;

        } else {
            printf("Invalid option! Try again...\n");
        }
    }

    if (is_finished(&state) == TRUE) {
        int current_position = get_current_position(&state);
        draw_zigzag_board(stdout, board, current_position);
        printf("You won!\n");
    }
}

Sequence* try_dice_values(State state, int count, int max_depth);

/**
 * TODO: First, checks if the step count reached the max_depth. If so, returns NULL. If there is room for more steps,
 * does a move (calling move function which updates the state), checking the result. If the finish square was reached by
 * this movement, creates a sequence, initializing it. If it doesn't, calls try_dice_values to continue searching. This
 * call should return the shortest sequence or NULL. Finally, the step should be added to the sequence, if there is one.
 *
 * @param state The state to move from.
 * @param count The number of steps taken already.
 * @param max_depth The maximum depth allowed.
 *
 * Pre:
 * Post:
 */
Sequence* do_recursive_move(State state, int dice_value, int count, int max_depth) {
    if (count >= max_depth) {
        return NULL;
    }
    move(&state, dice_value);
    Sequence* sequence;

    if (is_finished(&state)){
        sequence = (Sequence*) malloc(sizeof(Sequence));
        init_sequence(sequence);
    }
    else{
        sequence = try_dice_values(state, count+1, max_depth);
    }
    if (sequence){
        add_step_as_first(sequence, state.position, dice_value);
    }
    return sequence;
}


/**
 * TODO: Given a state, checks the sequence of steps following a dice value by calling do_recursive_move with each dice
 * value. For each resulting sequence, it returns the shortest one.
 *
 * @param state The state to move from.
 * @param count The number of steps taken already.
 * @param max_depth The maximum depth allowed.
 *
 * Pre:
 * Post:
 */
Sequence* try_dice_values(State state, int count, int max_depth) {
    Sequence* sequence[6];
    Sequence* candidate = NULL;
    for (int i = 0; i < 6; ++i) {
        int dice_value = i + 1;
        sequence[i] = do_recursive_move(state, dice_value, count, max_depth);
        if (sequence[i]) {
            if (!candidate) {
                candidate = sequence[i];
            }else if(get_sequence_size(sequence[i]) < get_sequence_size(candidate)) {
                candidate = sequence[i];
            }
        }
    }
    for (int i = 0; i < 6; ++i) {
        if (sequence[i] && sequence[i] != candidate){
            clear_sequence(sequence[i]);
            free(sequence[i]);
        }
    }
    return candidate;
}


/**
 * TODO: Explores the different sequences of dice values that leads to the finish square, printing the best one, if any.
 * Uses the size of the board to limit the number of steps explored, it is, the board will be considered unsolvable if
 * no sequence is found under that number of steps.
 *
 * @param board The playing board.
 *
 * Pre:
 * Post:
 */
void solve(Board *board) {
    State state;
    init_state(&state, board);
    int max_depth = get_size(board);
    int count = 0;
    Sequence* candidate = try_dice_values(state, count, max_depth);
    if (!candidate){
        printf("No solution found! (max depth: %d)", 0);
    } else{
        print_sequence(candidate);
        clear_sequence(candidate);
        free(candidate);
    }
}