#include <stdlib.h>
#include <stdio.h>

#include "../headers/sequence.h"

/**
 * TODO: Initializes a sequence, setting the initial values of the structure according to the implementation.
 *
 * Pre:
 * Post:
 */
void init_sequence(Sequence* sequence) {
    sequence->first = NULL;
    sequence->last = NULL;
    sequence->size = 0;
}

/**
 * TODO: Adds a step, creating it if needed, as the first step of the sequence.
 *
 * Pre:
 * Post:
 */
void add_step_as_first(Sequence* sequence, int position, int dice_value) {
    Step* step = (Step*) malloc(sizeof(Step));
    step->position = position;
    step->value = dice_value;
    step->prev = NULL;
    if (sequence->first == NULL){
        step->next = NULL;
        sequence->first = sequence->last = step;
    } else{
        step->next = sequence->first;
        sequence->first->prev = step;
        sequence->first = step;
    }
    sequence->size++;
}

/**
 * TODO: Adds a step, creating it if needed, as the last step of the sequence.
 *
 * Pre:
 * Post:
 */
void add_step_as_last(Sequence* sequence, int position, int dice_value) {
    Step* step = (Step*) malloc(sizeof (Step));
    step->position = position;
    step->value = dice_value;
    step->next = NULL;//Ya que esl el primero
    if (sequence->last == NULL){
        step->prev = NULL;
        sequence->first = sequence->last = step;
    } else{
        step->prev = sequence->last;
        sequence->last->next = step;
        sequence->last = step;
    }
    sequence->size++;
}

/**
 * TODO: Returns the number of steps stored in the sequence.
 *
 * Pre:
 * Post:
 */
int get_sequence_size(Sequence* sequence) {
    return sequence->size;
}

/**
 * Deletes (freeing if needed) all the steps stored in the sequence.
 * @param sequence The sequence to be cleared.
 *
 * Pre:
 * Post:
 */
 void clear_sequence(Sequence* sequence) {
    int i = 0;
    while (i < sequence->size){
        free(sequence->first);
        sequence->first = sequence->first->next;
        i++;
    }
}

/**
 * Prints the sequence of moves leading to the state.
 * @param sequence The sequence to be shown.
 *
 * Pre:
 * Post:
 */
void print_sequence(Sequence* sequence) {
    int i = 0;
    while (i < sequence->size){
        printf("With a %d, move to %d\n", sequence->first->value, sequence->first->position);
        i++;
        sequence->first = sequence->first->next;
    }
}
