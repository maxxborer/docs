RED='\033[0;31m'
NC='\033[0m' # No Color

nodemon $PWD/codewars.js

if [ $? -eq 0 ]; then
    echo OK
else
    echo "\nRequired \n${RED}Node.js${NC} (https://nodejs.org/en/download) \n${RED}nodemon${NC} (npm i -g nodemon)\n${NC}"
fi
