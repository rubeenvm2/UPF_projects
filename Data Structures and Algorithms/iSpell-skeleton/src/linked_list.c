#include "linked_list.h"

/**
 * TODO: Initializes the start Node pointer so that the list is empty.
*/
void init_list(LinkedList* l) {
    l->start = NULL;//Inicializamos todos los parametros de la linked list
}

/**
 * TODO: Clears all the nodes of the list, freeing the memory and leaving the list as
 * it would have just been initialized.
*/
void clear_list(LinkedList *l) {
    Node* p;
    Node* q;
    for (p = l->start; p != NULL; p = q) {//hacemos un bucle pasando por todos los nodos y los vamos limpiando, finalmente decimos que el inicial es Nulo para dejarlo como si estuviese inicializado
        q = p->next;
        free(p);
    }
    l->start = NULL;
}

/**
 * TODO: Reserves memory for a new Node and inserts it in the given linked list,
 * changing the start pointer as well as the prev/next pointers accordingly.
*/
void insert_into_list(LinkedList* l, char* c) {
    Node* newElem = (Node*) malloc(sizeof(Node));//Generamos espacio para incluir cosas a la lista
    strcpy(newElem->data, c);
    //Cambiamos cual es el start de la lista, y modificamos el previo y el next del que ya habia y del que añadimos
    newElem->next = l->start;
    if (l->start != NULL)
        l->start->prev = newElem;
    newElem->prev = NULL;
    l->start = newElem;
}

/**
 * TODO: Iterates over the different nodes searching for a WordInfo that contains the given word.
 * Returns: A pointer to the node if found or NULL otherwise.
*/
Node* find_in_list(LinkedList l, char* word) {
    Node* p = l.start;
    while (p != NULL){//Recorremos toda la lista, si algun elemento coincide con el buscado, devolvemos el puntero, en cualquier otro caso devolvemos nulo.
        if(strcmp(p->data, word) == 0){
            return p;
        } else{
            p = p->next;
        }
    }
    return NULL;
}

/**
 * TODO: Given a node and the list it belongs to, it removes it from the list freeing
 * its memory. It accounts for the start, and the prev/next pointers.
*/
void delete_node(LinkedList* l, Node* p) {
    //Buscamos el nodo a eliminar y modificamos el next del anterior y el previo del siguiente para poder eliminar el nodo.
    if(p->prev != NULL){
        p->prev->next = p->next;
    } else {
        l->start = p->next;
    } if (p->next != NULL){
        p->next->prev = p->prev;
    }
    free(p);//Finalmente liberamos el nodo.
}

/**
 * TODO: If a node in the list contains a WordInfo with the given word, it deletes it.
 * Returns true if a node was deleted and false otherwise.
*/
bool delete_from_list(LinkedList* l, char* word) {
    Node *p = find_in_list(*l, word);
    if(p != NULL){//Si el elemento a eliminar esta en la lista lo eliminamos, para esto llamamos a find in list y luego a delete node.
        delete_node(l, p);
        return true;
    }
    return false;
}

/**
 * TODO: Prints all word infos of the list using print_word_info.
*/
void print_list(LinkedList l) {
    Node* p;
    for (p = l.start; p != NULL; p = p->next)//Recorremos toda la lista y vamos printando la data de cada nodo.
        printf("%s\n", p->data);
}

