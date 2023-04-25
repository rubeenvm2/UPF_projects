#ifndef HASHTABLE_H
#define HASHTABLE_H

#include "utils.h"
#include "linked_list.h"

#define N 11        // number of slots in the hash dictionary (number of letters)

typedef struct {
    LinkedList list[N];
    int size;
    char name[MAX_WORD_LENGTH];
} HashTable;

int hash_mod(char *word,int n);
int hash_function(char *word);
void init_table(HashTable* dictionary, char* name);
void clear_table(HashTable* dictionary);


bool insert_word_info(HashTable* dictionary, char* word);
bool find_word_info(HashTable* dictionary, char* word);


bool delete_word_info(HashTable* dictionary, char* word);


void print_table(HashTable* dictionary);
void print_table_by_bucket(HashTable* dictionary);

#endif
