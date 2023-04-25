#include <unistd.h>
#include "utils.h"
#include "hash_table.h"
#include "generate_candidates.h"
#define BASE_DATA_DIR "/home/ruben/CLionProjects/iSpell-skeleton/data"
#define SEP_TAB_WIN "\\"
#define SEP_TAB_LIN "/"

/*
 * Load the dictionary from a database file
 */
void load_dictionary(HashTable *dictionary, char *filepath) {

    FILE *fd = fopen(filepath, "r");
    if (fd != NULL) {
        int count = 0;
        char line[MAX_LENGTH];
        while (fgets(line, MAX_LENGTH, fd) != NULL) {

            line[strcspn(line, "\n")] = 0;
            line[strcspn(line, " \n")] = 0;
            line[strcspn(line, "\r")] = 0;
            printf("- %s \n",line);
            char* word = line;

            if (insert_word_info(dictionary, word)) {
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
void menu_load_new_dictionary(HashTable *dictionary) {

    clear_table(dictionary);

    char* file_name=(char*)malloc(MAX_PATH_LENGTH*sizeof(char));
    char* name=(char*)malloc(MAX_WORD_LENGTH*sizeof(char));
  
    printf("\n");
    printf("Which file do you want to load?\n");
    scanf("%s", name);
    flush_input();


    strcpy(file_name,"");
    strcat(file_name,BASE_DATA_DIR);
    strcat(file_name,SEP_TAB_LIN);
    strcat(file_name,name);

    printf("Loading dictionary from file: %s\n",file_name);

    load_dictionary(dictionary,file_name);
    printf("Dictionary loaded!\n");

}

/*
 * Menu find a word in the dictionary selected
 */
void menu_find_word(HashTable* dictionary) {
    if(dictionary->size > 0){
        char word[MAX_WORD_LENGTH];

        scan_line("Enter word: ", "%s", word);
        str_to_lowercase(word);

        if (find_word_info(dictionary, word)) {
            printf("%s Found!\n", word);
        } else{
            printf("Not found!\n");
        }
    }else{
        printf("The dictionary is empty!\n");
        printf("Choose option 1 to load a dictionary or option 3 to add more words.\n");
    }
}

/*
 * Add a word into the selected dictionary
 */
void menu_add_new_word(HashTable *dictionary) {
    char word[MAX_WORD_LENGTH];

    scan_line("Enter word: ", "%s", word);

    str_to_lowercase(word);

    if (find_word_info(dictionary, word)) {
        printf("%s exists in the table!\n", word);
    } else{
        if (insert_word_info(dictionary, word)) {
            printf("New word is added!\n");
        } else {
            printf("Error! The word \"%s\" already exists.\n", word);
        }
    }


}

/*
 * Delete a word in the selected dictionary
 */
void menu_delete_word(HashTable *dictionary) {
    if(dictionary->size > 0){
        char word[MAX_WORD_LENGTH];
        scan_line("Enter word: ", "%s", word);
        str_to_lowercase(word);
        bool deleted = delete_word_info(dictionary, word);
        if (deleted) {
            printf("Deleted!\n");
        } else {
            printf("Not found!\n");
        }
    }else{
        printf("Dictionary is empty!\n");
        printf("Choose option 1 to load a dictionary.\n");
    }
}

/*
 * check words by different techniques
 */

void check_spelling_menu(HashTable *dictionary){



    if(dictionary->size > 0){
        char word[MAX_WORD_LENGTH];
        scan_line("Enter word: ", "%s", word);
        str_to_lowercase(word);
        if(find_word_info(dictionary,word)) {
            printf("%s  es correcta\n",word);
        } else {
            HashTable substitutes; //this table will contain the candidates results
            generate_candidates(word,dictionary,&substitutes);
            print_table(&substitutes);
            clear_table(&substitutes);
        }

    }else{
        printf("Dictionary is empty!\n");
        printf("Choose option 1 to load a dictionary.\n");
    }

}

/*
 * Main menu
 */
int main_menu(HashTable *dictionary){

    int option = -1;
    while (option != 0) {
        printf("\n========= Menu ===========\n");
        printf("1. Load a new dictionary\n");
        printf("2. Find a word\n");
        printf("3. Add a new word\n");
        printf("4. Delete a word\n");
        printf("5. Display dictionary\n");
        printf("6. Check spelling\n");
        printf("0. Exit\n");
        printf("==========================\n");
        option = read_int_option("Choose an option: \n");
        printf("\n");
        switch (option) {
            case LOAD_DICTIONARY: // Load dictionary
                menu_load_new_dictionary(dictionary);
                break;
            case FIND_A_WORD: // Find a word
                menu_find_word(dictionary);
                break;
            case ADD_A_NEW_WORD: // Add new word
                menu_add_new_word(dictionary);
                break;
            case DELETE_A_WORD: // Delete a word
                menu_delete_word(dictionary);
                break;
            case DISPLAY_DICTIONARY: // print the whole dictionary
                print_table_by_bucket(dictionary);
                break;
            case CHECK_SPELLING:
                check_spelling_menu(dictionary);
                break;
            case EXIT: // Exit the program
                printf("Closing The Application...\n");
                break;
            default:
                printf("Invalid option.\n");
        }
    }
}

/*
 * Main
 */



int main(int argc, char *argv[]) {
    HashTable dictionary; //here we create the root dictionary
    init_table(&dictionary, "Dictionary"); // reset it

    char* file_name=(char*)malloc(MAX_PATH_LENGTH*sizeof(char));
  

    strcpy(file_name,"");
    strcat(file_name,BASE_DATA_DIR);
    strcat(file_name,SEP_TAB_LIN);
    strcat(file_name,"word_list_en_1.txt");

    printf("Loading dictionary from file: %s\n",file_name);

    load_dictionary(&dictionary,file_name);
    printf("Dictionary loaded!\n");

    main_menu(&dictionary);

    clear_table(&dictionary);
    return 0;
}