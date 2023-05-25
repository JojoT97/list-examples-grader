CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

if [[ -d student-submission ]]
then
    rm -rf student-submission
fi

if [[ -d grading-area ]]
then
    rm -rf grading-area
fi

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

if [[ -f "student-submission/ListExamples.java" ]]
then
        echo 'ListExample.java found'
else
        echo 'ListExamples.java NOT found!'
        echo 'Score: 0/4!'
        exit 1
fi


cp student-submission/ListExamples.java ./GradingArea

javac -cp $CPATH GradingArea/*.java

if [[ $? -eq 0 ]]
then
        echo 'Compilation Succeeded'
else
        echo 'Compilation FAILED!'
        echo 'Score: 0/4!'
        exit 1
fi

java -cp $CPATH org.junit.runner.JUnitCOre TestListExamples > junit-output.txt

FAILURES = grep -c junit-output.txt

if [[ $FAILURES -eq 0 ]]
then
    echo 'SUCCESS 4/4!'
    exit 0
else
    echo 'You have FAILURES $FAILURES/4!'
    exit 1
fi
# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
