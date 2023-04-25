#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "utils.h"
#include "commons.h"
#include "tree.h"


void init_tree(Tree *t) {
    t->root = NULL;
    t->size = 0;
//    printf("Initialized...\n");
}

void clearPostOrder(Node *node) {
   //Borrar subarbol izquierdo
   //Borrar arbol derecho
   //Borrar la raiz.
   if(node !=NULL){
       clearPostOrder(node->left);
       clearPostOrder(node->right);
       free(node);
   }
}

void clear_tree(Tree *t) {
    clearPostOrder(t->root);
    init_tree(t);
}

Node *createNode(char *word) {

    Node *newNode = (Node *) malloc(sizeof(Node));
    strcpy(newNode->data, word);
    newNode->left = NULL;
    newNode->right = NULL;

    return newNode;
}


Node *insertNode(Node *node, char *word) {
    //Tal y como está la función solo lo insertará en el sitio correspondiente
    // ya que si strcmp == 0 entonces no hace nada, solo devuelve el nodo

    //El return es el arbol con el nodo insertado.
    //hay que hacer llamada recursiva.
    if (node == NULL) {
        //Creamos un nodo
        node = createNode(word);
    } else {
        if (strcmp(word, node->data) > 0) {
            //Si es mayor que el root va derecha
            node->right = insertNode(node->right, word);
        } else if (strcmp(word, node->data) < 0) {
            //Si es menor que el root va a la izquierda
            node->left = insertNode(node->left, word);
        }
    }
    return node;
}

Node *findNode(Node *node, char *word) {
//Si el nodo es NULL o si es el correspondiente devolverlo
//De otro modo, iterar a izq o der segun convenga y devolver el nodo.
    //Caso base: root es nula o word ya esta en el root.
    if(node == NULL || strcmp(node->data, word) == 0) {
        return node;
    }
    //word es mayor que la root's word
    if(strcmp(word, node->data)>0) {
        return findNode(node->right, word);
    }
    //Word es mas pequeña que la root's word
    if(strcmp(word, node->data)<0){
        return findNode(node->left, word);
    }
    return NULL;
}

bool insert_into_tree(Tree *t, char *word) {
    //Usar insertnode
    //Si el arbol esta vacio o NULL-> insertar word
    //De otro modo find_node y si no esta inseratrlo
    bool status = FALSE;
    if (t->root == NULL){
        t->root = createNode(word);
        t->size++;
        status = TRUE;
    }else{
        if(findNode(t->root, word) == NULL){
            insertNode(t->root, word);
            t->size++;
            status = TRUE;
        }
    }
    return status;
}

void printPreOrder(Node *node) {
    //Print root.
    //Recursivamente llamo a printInOrder en el subarbol izquierdo
    //Recursivamente llamo a printInOrder en el subarbol derecho
    if(node!= NULL){
        printf("%s\n", node->data);
        printPreOrder(node->left);
        printPreOrder(node->right);
    }
}

void printPostOrder(Node *node) {
    //Recursivamente llamo a printInOrder en el subarbol izquierdo
    //Recursivamente llamo a printInOrder en el subarbol derecho
    //Print root. CAMBIAR ORDEN PARA QUE SE AJUSTE A POSTORDER
    if(node!= NULL){
        printPostOrder(node->left);
        printPostOrder(node->right);
        printf("%s\n", node->data);
    }
}


void printInOrder(Node *node) {
    //Recursivamente llamo a printInOrder en el subarbol izquierdo
    //Print root.
    //Recursivamente llamo a printInOrder en el subarbol derecho
    if(node!= NULL){
        printInOrder(node->left);
        printf("%s\n", node->data);
        printInOrder(node->right);
    }
}

char *find_in_tree(Tree *t, char *word) {

    Node *elem = findNode(t->root, word);
    if (elem == NULL){
        return NULL;
    }
    return &elem->data;
}

Node* deleteNode(Node *root, char *word){
    /*Input; root(del arbol) y palabra a borrar
     * si no existe, devuelve root(arbol se queda como esta)
     * Comparar con root y recursivamente buscar en izq o derecha segun convenga hasta encontrar node
     *
     * Una vez encontrado:
     *  si no tiene hijos se elimina yyasta
     *  Si solo tiene un hijo, ponerlo donde estaba word yyasta
     *  Si tiene dos hijos, coger el mas pequeño del arbol derecho
     *  (acceder nodo derecho y recursivamente acceder al mas izquierdo)
     *  Sustituir arbol derecho(tengo que borrar nodo que acabo de subir)
     *  */
    if(root==NULL){
        return root;
    }
    if(strcmp(word,root->data)<0){
        root->left = deleteNode(root->left, word);
    } else if(strcmp(word, root->data)> 0){
        root->right = deleteNode(root->right, word);
    }else{
        //this is the node to be deleted
        //Case 0 children
        if(root->left == NULL && root->right == NULL){
            free(root);
            return root;
        }
        // case 1 children
        if(root->left == NULL && root->right != NULL){
            Node *temp = root->right;
            free(root);
            return temp;
        } else if(root->right == NULL && root->left != NULL){
            Node *temp = root->left;
            free(root);
            return temp;
        }
        //Case 2 children
        else{
            Node *temp = root->right;
            while(temp && temp->left != NULL){//puedo quitar temp del parentesis?
                temp = temp->left;
            }
            //replace the deleted word with a leftmost node
            strcpy(root->data, temp->data);//Hasta aqui ha hecho el profe.
            //Delete the next
            root->right = deleteNode(temp->right, word);
        }
    }
    return root;
}

int size_tree(Tree *t) {
    printf("Printing size...\n");
    return t->size;
}

void print_tree(Tree *t) {
//llamar a print inorder.
    printf("El arbol tiene %d elementos\n", t->size);
    printInOrder(t->root);
}

