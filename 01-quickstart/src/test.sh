#!/bin/bash

# Default log file
LOG_FILE=""

# Colors
RESET="\033[0m"      # Reset color
YELLOW="\033[33m"    # Yellow
GREEN="\033[32m"     # Green
RED="\033[31m"       # Red
BLUE="\033[34m"      # Blue

# Counters for test cases
TOTAL_TESTS=0
CRASH_COUNT=0

# Function to print a separator for better readability
print_separator() {
    echo -e "${BLUE}=====================================${RESET}"
}

# Helper function to test the program with an input file
test_input() {
    input_file=$1
    ((TOTAL_TESTS++)) # Increment total test counter

    print_separator
    echo -e "${YELLOW}Testing input: $input_file${RESET}"
    
    # Log to the log file if specified
    if [ -n "$LOG_FILE" ]; then
        echo "=====================================" >> "$LOG_FILE"
        echo "Testing input: $input_file" >> "$LOG_FILE"
    fi

    # Run the vulnerable program with the input
    ./vulnerable < "$input_file"
    EXIT_CODE=$?

    # Check the exit code to determine if the program crashed
    if [ $EXIT_CODE -ne 0 ]; then
        ((CRASH_COUNT++)) # Increment crash counter
        echo -e "${RED}Crash detected with input: $input_file${RESET}"
        if [ -n "$LOG_FILE" ]; then
            echo "Crash detected with input: $input_file" >> "$LOG_FILE"
        fi
    else
        echo -e "${GREEN}No crash for input: $input_file${RESET}"
        if [ -n "$LOG_FILE" ]; then
            echo "No crash for input: $input_file" >> "$LOG_FILE"
        fi
    fi
}

# Process command-line arguments
while getopts "l:" opt; do
    case $opt in
        l)
            LOG_FILE="$OPTARG"
            echo "Logging enabled. Results will be written to: $LOG_FILE"
            ;;
        *)
            echo "Usage: $0 [-l log_file]"
            exit 1
            ;;
    esac
done

# Directories containing AFL-generated inputs
CRASHES_DIR="out/crashes"
QUEUE_DIR="out/queue"

# Test all inputs in the crashes directory
if [ -d "$CRASHES_DIR" ]; then
    echo -e "${YELLOW}Testing inputs from crashes directory...${RESET}"
    if [ -n "$LOG_FILE" ]; then
        echo "Testing inputs from crashes directory..." >> "$LOG_FILE"
    fi

    for input in "$CRASHES_DIR"/*; do
        test_input "$input"
    done
else
    echo -e "${RED}No crashes directory found.${RESET}"
    if [ -n "$LOG_FILE" ]; then
        echo "No crashes directory found." >> "$LOG_FILE"
    fi
fi

# Test all inputs in the queue directory
if [ -d "$QUEUE_DIR" ]; then
    echo -e "${YELLOW}\nTesting inputs from queue directory...${RESET}"
    if [ -n "$LOG_FILE" ]; then
        echo "\nTesting inputs from queue directory..." >> "$LOG_FILE"
    fi

    for input in "$QUEUE_DIR"/*; do
        test_input "$input"
    done
else
    echo -e "${RED}No queue directory found.${RESET}"
    if [ -n "$LOG_FILE" ]; then
        echo "No queue directory found." >> "$LOG_FILE"
    fi
fi

# Calculate and display crash rate
print_separator
echo -e "${BLUE}Total Test Cases: ${RESET}$TOTAL_TESTS"
echo -e "${RED}Total Crashes: ${RESET}$CRASH_COUNT"

if [ $TOTAL_TESTS -gt 0 ]; then
    CRASH_RATE=$(echo "scale=2; $CRASH_COUNT / $TOTAL_TESTS * 100" | bc)
else
    CRASH_RATE=0
fi

echo -e "${YELLOW}Crash Rate: ${RESET}$CRASH_RATE%"
print_separator

if [ -n "$LOG_FILE" ]; then
    echo "=====================================" >> "$LOG_FILE"
    echo "Total Test Cases: $TOTAL_TESTS" >> "$LOG_FILE"
    echo "Total Crashes: $CRASH_COUNT" >> "$LOG_FILE"
    echo "Crash Rate: $CRASH_RATE%" >> "$LOG_FILE"
    echo "=====================================" >> "$LOG_FILE"
fi

echo -e "${GREEN}Testing completed.${RESET}"
if [ -n "$LOG_FILE" ]; then
    echo "Testing completed." >> "$LOG_FILE"
fi
