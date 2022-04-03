#To check if the OS is Windows or Linux and set the executable file extension and delete command accordingly
ifdef OS
   RM = del /q
   FixPath = $(subst /,\,$1)
   EXEC = exe
else
   ifeq ($(shell uname), Linux)
      RM = rm -rf
      FixPath = $1
	  EXEC = out -lm
   endif
endif
TEST_PROJ_NAME = Internet_Banking_System

COVERAGE_PROJ_NAME=COVERAGE_$(TEST_PROJ_NAMEPROJ_NAME)

PROJ_NAME= Internet_Banking_System

BUILD_DIR=Build
# All include folders with header files
INC =-Iinc -Iunity
# All source code files
SRC =  src/add.c\
src/deposit.c\
src/display.c\
src/newacc.c\
src/search.c\
src/update.c\
src/withdraw.c\

# Main source code file
PROJECT=main.c
# Unity files
UNITY=unity/unity.c
#TEST Files
TEST=test/test.c
# Makefile will not run target command if the name with file already exists. To override, use .PHONY
.PHONY : all test coverage run clean doc

# Call 'make execute' to run the main program
	
run:
	gcc $(SRC) $(PROJECT) $(INC) -o $(call FixPath,$(BUILD_DIR)/$(PROJ_NAME).$(EXEC))
	$(call FixPath,$(BUILD_DIR)/$(PROJ_NAME).$(EXEC))

# Call `make test` to run the test cases
test:
	gcc $(SRC) $(TEST) $(UNITY) $(INC) -o $(call FixPath,$(BUILD_DIR)/$(TEST_PROJ_NAME).$(EXEC))
	$(call FixPath,$(BUILD_DIR)/$(TEST_PROJ_NAME).$(EXEC))
#Call 'make cpp' for static code analysis
cpp:
	cppcheck enable=all $(SRC) $(TEST) $(PROJECT)
# Call 'make coverage' for code coverage
coverage:
	gcc $(INC) -fprofile-arcs -ftest-coverage $(SRC) $(TEST) $(UNITY) -o $(call FixPath,$(BUILD_DIR)/$(COVERAGE_PROJ_NAME).$(EXEC))
	$(call FixPath,$(BUILD_DIR)/$(COVERAGE_PROJ_NAME).$(EXEC))
	gcov -a $(SRC) $(TEST) $(UNITY)
# Call 'make memechek for memory leaks
memcheck:
	valgrind ./$(call FixPath,$(BUILD_DIR)/$(PROJ_NAME).$(EXEC))
	
clean:
	rm -rf $(BUILD)*.gcda *.gcno *.gcov

$(BUILD_DIR):
			mkdir $(BUILD_DIR)

	