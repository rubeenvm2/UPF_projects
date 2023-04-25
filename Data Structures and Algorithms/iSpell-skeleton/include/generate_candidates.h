//
// EDA 2
//

#ifndef ISPELL_GENERATE_CANDIDATES_H
#define ISPELL_GENERATE_CANDIDATES_H

#endif //ISPELL_GENERATE_CANDIDATES_H
#include "linked_list.h"
#include "hash_table.h"

//LinkedList* candidates_by_substitution(char* word);
void candidates_by_substitution(char* word, HashTable *d, HashTable *c);
void candidates_by_insertion(char* word, HashTable *d, HashTable *c);
void candidates_by_swapping(char* word, HashTable *d, HashTable *c);
void candidates_by_deletion(char* word, HashTable *d, HashTable *c);
void generate_candidates(char* word, HashTable *d, HashTable *c);