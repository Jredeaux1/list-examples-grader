CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

if [[ -f student-submission/ListExamples.java ]]
then 
    echo 'ListExamples.java found'
else 
    echo 'ListExamples.java not found'
    echo 'Score: 0/4'

    exit 1
fi
cp student-submission/ListExamples.java grading-area
cp TestListExamples.java grading-area
cp -r lib grading-area

javac -cp $CPATH grading-area/*.java 2> err-output.txt

if [[ $? != 0 ]]
then
    echo 'Compile error'
    echo 'Score : 0/4'

fi

java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore grading-area/TestListExamples > jUnit-output.txt

FAILURES1=`grep -c "Failures: 1" jUnit-output.txt`
FAILURES2=`grep -c "Failures: 2" jUnit-output.txt`
FAILURES3=`grep -c "Failures: 3" jUnit-output.txt`
FAILURES4=`grep -c "Failures: 4" jUnit-output.txt`

if [[ $FAILURES1 -ne 0 ]]
then 
    echo 'score: 3/4'
elif [[ $FAILURES2 -ne 0 ]] 
then   
    echo 'score 2/4'
elif [[ $FAILURES3 -ne 0 ]] 
then   
    echo 'score 1/4'  
elif [[ $FAILURES4 -ne 0 ]] 
then   
    echo 'score 0/4' 
else 
    echo 'Score 4/4'
fi 

