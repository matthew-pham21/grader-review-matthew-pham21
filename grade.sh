CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

if [[ -f "./student-submission/ListExamples.java" ]] 
then
    echo "Correct file found!"
else
    echo "Incorrect file, please use ListExamples.java"
    exit
fi

cp *.java ./grading-area
cp ./student-submission/ListExamples.java ./grading-area
cp -r ./lib ./grading-area

cd grading-area

javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" *.java

if [[ $? == 0 ]]
then
    echo "Compiled successfully!"
else
    echo "Compile failure, please check for compilation errors."
    exit
fi


java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples > ./gradeResults.txt
# resultLine=`grep -n 'Tests run' ./gradeResults.txt`
# runTests1=$(echo ${resultLine} | cut -d ' ' -f 3)
# runTests2=$(echo ${runTests1} | cut -d ',' -f 1)
# failedTests=$(echo ${resultLine} | cut -d ' ' -f 5)
# echo "$(($runTests2 - $failedTests)) / $runTests2 was your test scores!"
newLine=`grep -n 'Tests' ./gradeResults.txt`
echoedLine=$(echo ${newLine} | cut -d ':' -f 1)
echo "$newLine"

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests