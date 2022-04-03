#ifndef __BANK_H__
#define __BANK_H__

#include<stdio.h>
#include<string.h>
#include<malloc.h>
/**
 * @brief enum user
 * 
 */
typedef enum user{
    SUCCESS = 0,
    NO_ACC_EXIST=2,
    EXISTS=6
}user;

/**
 * @brief Structure info
 * 
 */
typedef struct info{
    char name[60];
    int acc_no;
    int age;
    char address[60];
    char citizenship[15];
    int phone;
    char acc_type[10];
    float amt;
    int month;
    int day;
    int year;
    struct info *nt;
}info;


info *newacc(info *,char *,int,int,char *,char *,int,char *,float,int,int,int);

user add(info *,char *,int ,int ,char *,char *,int ,char *,float ,int ,int ,int );

user update(info *,int,int,int);

user deposit(float,info *,info *,int *);

user search(info *, int , info *, int *);

user withdraw(info *,float,info *,int *);

user display(info *);

#endif