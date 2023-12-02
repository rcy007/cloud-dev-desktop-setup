#!/bin/zsh

# Made with Love - by @ahujaaa

# Updated for new pyenv versions breaking pyenv global env

# 1 = Everything [Recommended for new Developer Desktop Setups]
# 2 = Just Python [Installs Pyenv, Anaconda-2023-09, PIP, Python 3.11.5, Jupyter Notebook Extensions and AWS-CLI]
# 3 = Just Spark [Python 3.6+ and PIP should be preinstalled.]

echo -e "\n\n--------------\n\nWelcome to Abhinav's super awesome ----- glorious ----- developer desktop setup script. \n\n--------------\n\n"
echo -e "What would you like to Install? \n"
echo -e "1 = Everything [Recommended for new Developer Desktop Setups] \n"
echo -e "2 = Just Python [Installs Pyenv, Anaconda-2023-09, PIP, Python 3.11.5, Jupyter Notebook Extensions and AWS-CLI] \n"
echo -e "3 = Just Spark [Python 3.6+ and PIP should be pre-installed.] \n\n"

echo -e "Enter your input [1/2/3]:"

read var

while [ "${var:-0}" != 1 -a "${var:-0}" != 2 -a "${var:-0}" != 3 ]
do
	echo -e "Please choose between 1,2 or 3."
	read var
done

cd ~

if [ $var != 2 ]
then


echo -e "\n\n Donwloading Spark \n\n"
mkdir Softwares
cd Softwares
wget https://archive.apache.org/dist/spark/spark-3.5.0/spark-3.5.0-bin-hadoop3.tgz


echo -e "\n\n Extracting Spark \n\n"
tar zxf spark-3.5.0-bin-hadoop3.tgz -C ~/

cd ~
mv spark-3.5.0-bin-hadoop3 spark

echo -e "\n\n Adding S3 compatibility to Spark \n\n"
cd spark/jars/
wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.1/hadoop-aws-3.3.1.jar
wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.901/aws-java-sdk-bundle-1.11.901.jar
cd ~

echo -e "\n\n Updating zsh to include Spark and Java Paths \n\n"

echo -e "----------\n"

echo "export JAVA_HOME=/apollo/env/envImprovement/jdk1.8">>.zshrc
echo "export PATH=\$JAVA_HOME/bin:\$PATH">>.zshrc
echo "export SPARK_HOME='/home/$USER/spark'">>.zshrc
echo "export PATH=\$SPARK_HOME:\$PATH">>.zshrc
echo "export PYTHONPATH=\$SPARK_HOME/python:\$PYTHONPATH">>.zshrc

echo -e "-----------\n"

fi

if [ $var == 3 ]
then

echo -e "\n\n Installing pyspark module \n\n"

pip install pyspark

pip install pyarrow

echo -e "\n\n Job done! Spark install complete... Happy Distributing :)"
exit 1

fi


echo -e "\n\n Installing Pyenv \n\n"

curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

echo -e "\n\n Adding pyenv Paths to zshrc \n\n"

echo -e "---\n"

# echo "export PATH=\"/home/$USER/.pyenv/bin:\$PATH\"">>.zshrc
# echo "eval \"\$(pyenv init -)\"">>.zshrc
# echo "eval \"\$(pyenv virtualenv-init -)\"">>.zshrc

echo "export PYENV_ROOT=\"\$HOME/.pyenv\"">>.zshrc
echo "export PATH=\"\$PYENV_ROOT/bin:\$PATH\"">>.zshrc
echo "eval \"\$(pyenv init --path)\"">>.zshrc
echo "eval \"\$(pyenv init -)\"">>.zshrc

echo -e "---\n"

echo "Done..... Now restarting Shell. To complete the setup Run PART 2 now!!"
exec "$SHELL"

cd ~

