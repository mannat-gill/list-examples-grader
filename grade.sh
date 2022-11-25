set -e 
CP=".:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar"
score=0
PASSED="OK"
FAILED="Failures"
message=""

rm -rf student-submission
git clone $1 student-submission 2> clone.txt 
cd student-submission/

#checking if the file exists. If file exists then 10 points else 0 points 
if ! [[ -f "ListExamples.java" ]] ; then 
    message+="Could not find ListExample.java."
else 
    ((score = score + 10 )) 
    message+="ListExamples.java file found. Great Job!"
fi

# going into my doc and copying over TestListExamples.java 
cd /Users/mannat/Documents/GitHub/list-examples-grader/
cp TestListExamples.java student-submission 
cp -r lib student-submission

cd /Users/mannat/Documents/GitHub/list-examples-grader/student-submission/

set +e

#JUnit tests
javac -cp $CP *.java 2> javacTest.txt
java -cp $CP org.junit.runner.JUnitCore TestListExamples > javaTest.txt
#successful running tests automatically get 40 points for 50% total 
if [ $? -eq 0 ] ; then 
    ((score = score + 40 )) 
    message+=" You passed all JUnit tests!"
else 
    message+=" Some JUnit tests didn't pass :(. But no worries great job trying!"
fi

grep . /Users/mannat/Documents/GitHub/list-examples-grader/student-submission/javaTest.txt > grepOutput.txt

TAILOUT=$(tail -n 1 /Users/mannat/Documents/GitHub/list-examples-grader/student-submission/grepOutput.txt) 

if [[ "$TAILOUT" == *"$PASSED"* ]]; then
((score = score + 50 ))
fi

#if it has failing test we will extract the number of failed tests 
if [[ "$TAILOUT" == *"$FAILED"* ]]; then
SUBSTR=$(echo $TAILOUT | cut -d' ' -f 5)
fi

FailedTEST=$((SUBSTR))

#Point where at least getting JUnit tests to run 
for (( i=0 ; i<$FailedTEST ; i++ )); 
do 
    ((score = score + 20 ))
    #echo $i
done

#if any tests failed then add to message feedback 
if [ $FailedTEST -gt 0 ]; then
    message+=" There were "$FailedTEST" failed tests."
fi

echo $message
echo "FINAL SCORE IS: "$score"%"