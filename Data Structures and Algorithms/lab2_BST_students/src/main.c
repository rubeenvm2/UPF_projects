#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tree.h"
#include "main.h"
#include "utils.h"
#include "generate_candidates.h"

#if defined(__CYGWIN__) || defined(_WIN32) || defined(_WIN64) || defined(__WINDOWS__)
    #define SEP_TAB "\\"
    #define BASE_DATA_DIR "..\\data"
#else
    #define SEP_TAB "/"
    #define BASE_DATA_DIR "../data"
#endif

/*
 * Load the dictionary from a database file
 */
void load_dictionary(Tree *tree, char *filepath) {

    FILE *fd = fopen(filepath, "r");
    if (fd != NULL) {
        int count = 0;
        char line[MAX_LENGTH];
        while (fgets(line, MAX_LENGTH, fd) != NULL) {

            line[strcspn(line, "\n")] = 0;
            line[strcspn(line, " \n")] = 0;
            line[strcspn(line, "\r")] = 0;
//            printf("- %s \n",line);
            char *word = line;

            if (insert_into_tree(tree, word)) {
                printf("%s\n", word);
                count++;
            }
        }
        fclose(fd);
        printf("Loaded! There are %d new entries.\n", count);
    } else {
        printf("Error! Could not load data, check file '%s' is not missing.\n", filepath);
    }
}

/*
 * Load all the files contained in the data folder
 */
void menu_load_new_dictionary(Tree *tree) {

    clear_tree(tree);

    char file_name[MAX_PATH_LENGTH];
    char name[MAX_WORD_LENGTH];

    printf("\n");
    printf("Which dictionary do you want to load?\n");
    scanf("%s", name);
    flush_input();

    strcpy(file_name, "");
    strcat(file_name, BASE_DATA_DIR);
    strcat(file_name, SEP_TAB);
    strcat(file_name, name);

    printf("Loading dictionary from file: %s\n", file_name);

    load_dictionary(tree, file_name);
    printf("Dictionary loaded!\n");
}

/*
 * Menu find a word in the dictionary
 */
void menu_find_word(Tree *tree) {
    if (tree->size > 0) {
        char word[MAX_WORD_LENGTH];

        scan_line("Enter word: ", "%s", word);
        str_to_lowercase(word);

        if (find_in_tree(tree, word) != NULL) {
            printf("%s Found!\n", word);
        } else {
            printf("Not found!\n");
        }
    } else {
        printf("The dictionary is empty!\n");
        printf("Choose option 1 to load a dictionary or option 3 to add more words.\n");
    }
}

/*
 * Add a word into the dictionary
 */
void menu_add_new_word(Tree *tree) {
    char word[MAX_WORD_LENGTH];
    scan_line("Enter word: ", "%s", word);

    str_to_lowercase(word);

    if (find_in_tree(tree, word) != NULL) {
        printf("%s exists in the dictionary!\n", word);
    } else {
        if (insert_into_tree(tree, word)) {
            printf("New word is added!\n");
        } else {
            printf("Error! The word \"%s\" already exists.\n", word);
        }
    }
}

/*
 * check words by different techniques
 */

void check_spelling_menu(Tree *tree) {

    if (tree->size > 0) {
        char word[MAX_WORD_LENGTH];
        scan_line("Enter word: ", "%s", word);
        str_to_lowercase(word);
        if (find_in_tree(tree, word) != NULL) {
            printf("%s is correct!\n", word);
        } else {
            Tree substitutes;
            generate_candidates(word, tree, &substitutes);
            if(substitutes.size > 0){
                printf("Substitutes:\n");
                printInOrder(substitutes.root);
            }else{
                printf("Substitutes list is empty!\n");
            }
            clear_tree(&substitutes);
        }

    } else {
        printf("Dictionary is empty!\n");
        printf("Choose option 1 to load a dictionary.\n");
    }
}

/*
 * Delete a word in the selected dictionary
 */
void menu_delete_word(Tree *tree) {
    if(tree->size > 0){
        char word[MAX_WORD_LENGTH];
        scan_line("Enter word: ", "%s", word);
        str_to_lowercase(word);

        if (find_in_tree(tree, word) != NULL) {
            tree->root = deleteNode(tree->root, word);
            tree->size--;
            printf("Deleted!\n");
        } else {
            printf("Not found!\n");
        }
//        print_tree(tree);
    }else{
        printf("Dictionary is empty!\n");
        printf("Choose option 1 to load a dictionary.\n");
    }
}
void file_check_spell(Tree* tree){
    char line[MAX_LENGTH];
    char name[MAX_WORD_LENGTH];
    char file_errors_name[MAX_PATH_LENGTH];
    printf("\n");
    printf("Which file do you want to load to check the spell of the words?\n");
    scanf("%s", name);
    flush_input();

    strcpy(file_errors_name, "");
    strcat(file_errors_name, BASE_DATA_DIR);
    strcat(file_errors_name, SEP_TAB);
    strcat(file_errors_name, name);

    printf("Loading words to check spell from file: %s\n", file_errors_name);

    FILE* fd = fopen(file_errors_name, "r");
    if(fd == NULL){
        printf("No se ha podido abrir el archivo");
    }else{
        while (fgets(line, MAX_LENGTH, fd) != NULL){
            char word[MAX_LENGTH];
            sscanf(line, "%s\n", word);
            str_to_lowercase(word);
            if(find_in_tree(tree, word)!= NULL){
                printf("%s es correcta\n", word);
            }else{
                Tree substitutes;
                generate_candidates(word, tree, &substitutes);
                printf("Substitutes for %s:\n", word);
                if(substitutes.size > 0){
                    printInOrder(substitutes.root);
                }else{
                    printf("Esta palabra no está en el diccionario, prueba a añadir otro diccionario"
                           "con la opción 1 o quizá la palabra tenga demasiados errores para adivinar que"
                           "querias decir.\n");
                }
                clear_tree(&substitutes);
            }
        }
    }
}
/*
 * Main menu
 */
void main_menu(Tree *tree) {

    int option = -1;
    while (option != 0) {
        printf("\n========= Menu ===========\n");
        printf("1. Load a new dictionary\n");
        printf("2. Find a word\n");
        printf("3. Add a new word\n");
        printf("4. Delete a word\n");
        printf("5. Display dictionary (sorted)\n");
        printf("6. Check spelling\n");
        printf("7. Display dictionary  (preOrder)\n");
        printf("8. Display dictionary  (postOrder)\n");
        printf("9. Check Spelling of a file\n");
        printf("0. Exit\n");
        printf("==========================\n");
        option = read_int_option("Choose an option: ");
        printf("\n");
        switch (option) {
            case LOAD_DICTIONARY: // Load dictionary
                menu_load_new_dictionary(tree);
                break;
            case FIND_A_WORD: // Find a word
                menu_find_word(tree);
                break;
            case ADD_A_NEW_WORD: // Add new word
                menu_add_new_word(tree);
                break;
            case DELETE_A_WORD: // Delete a word
                menu_delete_word(tree);
                break;
            case DISPLAY_DICTIONARY: // print the whole dictionary sorted
                print_tree(tree);
                break;
            case CHECK_SPELLING:
                check_spelling_menu(tree);
                break;
            case PRE_ORDER: // print the whole dictionary pre order
                printPreOrder(tree->root);
                break;
            case POST_ORDER: // print the whole dictionary post order
                printPostOrder(tree->root);
                break;
            case FILE_CHECK_SPELL:
                file_check_spell(tree);
                break;
            case EXIT: // Exit the program
                printf("Closing The Application...\n");
                break;
            default:
                printf("Invalid option.\n");
        }
    }
}


int main(int argc, char *argv[]) {

    Tree T;
    init_tree(&T);

    char file_name[MAX_PATH_LENGTH];
    strcpy(file_name, "");
    strcat(file_name, BASE_DATA_DIR);
    strcat(file_name, SEP_TAB);
    strcat(file_name, "word_list_3.txt");
//    strcat(file_name, "word_list_en_1.txt");
    printf("Loading dictionary from file: %s\n", file_name);
    load_dictionary(&T, file_name);
    printf("Dictionary loaded!\n");

    // Display main menu
    main_menu(&T);

    clear_tree(&T);

    return 0;
}
