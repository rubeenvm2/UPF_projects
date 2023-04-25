#include "generate_candidates.h"

void candidates_by_substitution(char *word, Tree *dictionary, Tree *suggestions) {
    char *candidate;
    int l= strlen(word);
    char c;
    int i;
    for(i=0;i<l;i++) {
        candidate = (char*)malloc((l+1)*sizeof(char));
        strcpy(candidate,word);
        for (c = 'a'; c <= 'z'; c++) {
            candidate[i]=c;
            if(find_in_tree(dictionary,candidate)) {
                if(find_in_tree(suggestions, candidate) == NULL) { //Comprobamos si la palabra estaba ya en la lista de sugestiones antes de añadir la palabra.
                    insert_into_tree(suggestions, candidate);
                }
            }
        }
    }
}


void candidates_by_insertion(char *word, Tree *dictionary, Tree *suggestions) {
    char *candidate;
    int l= strlen(word);
    char c;
    int i;
    for(i=0;i<l+1;i++) {//Recorremos hasta length inicial +1 ya que generaremos un "espacio" donde probaremos todas las letras
        candidate = (char*)malloc((l+1)*sizeof(char));
        strcpy(candidate,word);
        for (int j = 0; j < l; ++j) {//Generamos un espacio en cada posicion de la palabra recorriendo toda la palabra
            char temp = candidate[j+1+i]; //Segun en la i que estemos, vamos desplazando las letras para dejar en cada iteracion un espacio con una letra repetida que será la que sustituiremos en el siguiente for.
            candidate[j+1+i] = candidate[i] ;
            candidate[i] = temp;
        }
        for (c = 'a'; c <= 'z'; c++) {
            candidate[i]=c;//Sustituimos la letra por todas las del abecedario, una en cada iteracion
            if(find_in_tree(dictionary,candidate)) {//Si esta en la lista la insertamos en la lista de sugerencias.
                if(find_in_tree(suggestions, candidate) == NULL) { //Comprobamos si la palabra estaba ya en la lista de sugestiones antes de añadir la palabra.
                    insert_into_tree(suggestions, candidate);
                }
            }
        }
    }

}


void candidates_by_swapping(char *word, Tree *dictionary, Tree *suggestions) {
    char *candidate;
    int l= strlen(word);
    char c;
    int i;
    for(i=0;i<l;i++) {
        candidate = (char*)malloc((l+1)*sizeof(char));
        strcpy(candidate,word);
        char temp = candidate [i];//Cambiamos una letra y la consecutiva en cada iteracion.
        candidate [i] = candidate [i+1];
        candidate [i+1] = temp;
        for (c = 'a'; c <= 'z'; c++) {
            candidate[i]=c;//Sustituimos la letra por todas las del abecedario, una en cada iteracion
            if(find_in_tree(dictionary,candidate)) {//Si esta en la lista la insertamos en la lista de sugerencias.
                if(find_in_tree(suggestions, candidate) == NULL){ //Comprobamos si la palabra estaba ya en la lista de sugestiones antes de añadir la palabra.
                    insert_into_tree(suggestions,candidate);
                }
            }
        }
    }
}

void candidates_by_deletion(char *word, Tree *dictionary, Tree *suggestions) {
    char *candidate;
    int l= strlen(word);
    char c;
    int i;
    for(i=0;i<l;i++) {
        candidate = (char*)malloc((l+1)*sizeof(char));
        strcpy(candidate,word);
        for (int j = 0; j < l; ++j) {
            candidate[j+i] = candidate[j+1+i] ;//Avanzamos una posicion la letra siguiente a la que queramos borrar ya que asi sobreescribiremos esa que queramos borrar
        }
        if(find_in_tree(dictionary,candidate)) {
            if(find_in_tree(suggestions, candidate) == NULL){ //Comprobamos si la palabra estaba ya en la lista de sugestiones antes de añadir la palabra.
                insert_into_tree(suggestions,candidate);
            }
        }
    }
}

void generate_candidates(char *word, Tree *dictionary, Tree *substitutes) {
    init_tree(substitutes);
    candidates_by_substitution(word, dictionary, substitutes);
    candidates_by_insertion(word, dictionary, substitutes);
    candidates_by_swapping(word, dictionary, substitutes);
    candidates_by_deletion(word, dictionary, substitutes);
}