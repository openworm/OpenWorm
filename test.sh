set -ex

ruff format *.py
ruff check *.py

quick_test=0

if [[ ($# -eq 1) && ($1 == '-q') ]]; then
    echo "Running quick test only..."
    quick_test=1
else
    echo "Running full test..."
fi

./stop.sh || true

if [ "$quick_test" == 1 ]; then

    ./build.sh

else
    ./rebuild.sh
fi

time ./run.sh 


echo
echo "  Done!"
echo
  

