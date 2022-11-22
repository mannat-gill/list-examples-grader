# Create your grading script here
#stop the second there is one error
set -e 
CP=".:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar"
score=100
echo $score

rm -rf student-submission
git clone $1 student-submission 2> clone.txt 
cd student-submission/
echo "In student-submission dir"



#check if the file has the correct name
#-f: uses find to check 
#-e: checks if it exists 

#checking if the file exists. WORKS !
if ! [[ -f "ListExamples.java" ]] ; then 
    ((score = score - 10 )) 
    echo $score 
    echo "The File Does not exist"
else 
    echo $score 
    echo "File found"
fi

echo "Made it here"
# going into my doc and copying over TestListExamples.java 
cd /Users/mannat/Documents/GitHub/list-examples-grader/
cp TestListExamples.java student-submission 

cd /Users/mannat/Documents/GitHub/lab3
cp ListTests.java student-submission

if ! [[ -f "TestListExamples.java" ]] ; then 
    ((score = score - 10 )) 
    echo $score
    echo "TestListExamples.java does not exist in this directory"
else
    echo $score
    echo "Found TestListExamples.java"
    
fi


echo "Before Javac"
#turn off set -e to print out all errors 
set +e

#testing file if it exists 
javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java
java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples

#javac -cp $CP *.java > javacTest_output.txt 2> javacTest_errorOutput.java
#java -cp $CP org.junit.runner.JUnitCore TestListExamples > javaTest_output.txt 2> javaTest_errorOutput.java

if [ $? -eq 0 ] ; then 
    echo $score
    echo "Successful"
else 
    ((score = score - 50 )) 
    echo $score
    echo "Not successful"
fi

echo "After Javac"


