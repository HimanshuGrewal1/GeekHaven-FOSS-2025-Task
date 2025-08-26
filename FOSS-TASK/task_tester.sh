#!/bin/bash


BLUE="\e[34m"
YELLOW="\e[33m"
GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"

echo -e "${BLUE}--- Geekhaven FOSS Recruitment Task Tester ---${RESET}"


echo -e "${BLUE}[INFO] Checking if repository is initialized...${RESET}"
if [ -d ".git" ]; then
    echo -e "${GREEN}[SUCCESS] Git repository found.${RESET}"
else
    echo -e "${RED}[ERROR] No .git folder found. Initialize your repo first.${RESET}"
fi


echo -e "${BLUE}[INFO] Checking pre-commit hook output...${RESET}"
if [ -f "hooks/task_commands.sh" ]; then
    echo -e "${GREEN}[SUCCESS] task_commands.sh exists.${RESET}"
    echo -e "${YELLOW}[WARNING] Showing last 5 commands recorded:${RESET}"
    tail -n 5 hooks/task_commands.sh
else
    echo -e "${RED}[ERROR] task_commands.sh not found inside hooks/.${RESET}"
fi


echo -e "${BLUE}[INFO] Checking post-commit hook output...${RESET}"
if [ -f "hooks/commit_details.txt" ]; then
    echo -e "${GREEN}[SUCCESS] commit_details.txt exists.${RESET}"
    echo -e "${YELLOW}[WARNING] Showing last commit recorded:${RESET}"
    tail -n 1 hooks/commit_details.txt
else
    echo -e "${RED}[ERROR] commit_details.txt not found inside hooks/.${RESET}"
fi


echo -e "${BLUE}[INFO] Checking for overridden commits on a new branch...${RESET}"
branch_name="new-branch"
if git rev-parse --verify $branch_name >/dev/null 2>&1; then
    echo -e "${GREEN}[SUCCESS] Branch '$branch_name' exists.${RESET}"
    echo -e "${YELLOW}[WARNING] Checking author info in last commit:${RESET}"
    git log $branch_name -1 --pretty=format:"%h - %an <%ae>"
else
    echo -e "${RED}[ERROR] Branch '$branch_name' not found.${RESET}"
fi


echo -e "${BLUE}----------------------------------------------${RESET}"
echo -e "${GREEN}[DONE] Testing completed.${RESET}"
echo -e "${BLUE}----------------------------------------------${RESET}"
