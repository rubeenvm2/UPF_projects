#ifndef LINKEDLIST_H
#define LINKEDLIST_H

#include "utils.h"

typedef struct _Node {
    //char* data;
    char data[MAX_WORD_LENGTH];
    struct _Node* next;
    struct _Node* prev;
} Node;

typedef struct {
    Node* start;
} LinkedList;

void init_list(LinkedList *l);
void clear_list(LinkedList *l);
void insert_into_list(LinkedList *l, char* c);
Node* find_in_list(LinkedList l, char* word);
bool delete_from_list(LinkedList* l, char* word);
void print_list(LinkedList l);


#endif
