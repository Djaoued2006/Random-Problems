#include <stdio.h>

//function

int findSum(int number) {
    int result = 0;

    //for loop form
    for (int i = 1 ; i <= number ; i++) result += i;

    /*  
        while loop form :

        i = 1;

        while (i <= number) {
            result += i;
            i++;
        }

        do while loop form:

        i = 1;

        do {
            result += i;
            i++;
        } while (i <= number);
    
    */

    return result;
}

int main(void) {
    printf("the sum is : %d \n" , findSum(30));

    //taking inputs from the user!

    int number;

    printf("type a number : ");
    scanf("%d\n" , &number); //this will take the input from the user and put it in the variable number!

    printf("the sum is : %d \n" , findSum(number));
e
    return 0;
}


