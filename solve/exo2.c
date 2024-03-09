#include <stdio.h>
#include <stdbool.h>

bool isBissextileYear(int year) {
    
    if (year % 100 == 0) {
        if (year % 400 == 0) return true;
    } else {
        if (year % 4 == 0) return true;
    }

    return false;
}

int main(void) {
    int months[] = {31 , 28 , 31 , 30 , 31, 30 , 31 , 31 , 30 , 31 , 30 , 31};

    int day , month , year;

    printf("type the year : "); scanf("%d \n" , &year);
    printf("type the month : "); scanf("%d \n" , &month);
    printf("type the day : "); scanf("%d \n" , &day);

    int number;

    printf("type the number of days you wanna add  : "); scanf("%d \n" , &number);


    printf("year : %d , month : %d , day : %d \n" , year,  month , day);
    printf("the number of days : %d\n" , number);

    if (isBissextileYear(year)) months[1] += 1;

    while (number != 0) {
        if (day + number > months[month - 1]) {
            number -= (months[month - 1] - day - 1);
            month++;
            day = 1;

            if (month == 13) {
                year++;
                month = 1;
            }
        } else {
            day += number;
            number = 0;
        }
    }

    printf("the new date is : %d//%d//%d \n" , year , month , day);
}

