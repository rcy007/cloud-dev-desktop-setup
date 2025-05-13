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

echo -e "Detecting Machine Architecture..."
echo -e "\n\n\n"

ARCH=$(uname -m)
case "$ARCH" in
  x86_64|amd64)
    echo "Detected x86_64"
    ;;
  aarch64|arm64)
    echo "Detected ARM64"
    ;;
  *)
    echo "Unknown architecture: $ARCH" >&2
    exit 1
    ;;
esac



while [ "${var:-0}" != 1 -a "${var:-0}" != 2 -a "${var:-0}" != 3 ]
do
	echo -e "Please choose between 1,2 or 3."
	read var
done

cd ~

if [ $var != 2 ]
then


echo -e "\n\n Donwloading Spark \n\n"
mkdir -p Softwares
cd Softwares
wget https://archive.apache.org/dist/spark/spark-3.5.0/spark-3.5.0-bin-hadoop3.tgz


echo -e "\n\n Extracting Spark \n\n"
tar xzf spark-3.5.0-bin-hadoop3.tgz -C ~/

cd ~
mv spark-3.5.0-bin-hadoop3 spark

echo -e "\n\n Adding S3 compatibility to Spark \n\n"
cd spark/jars/
wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.1/hadoop-aws-3.3.1.jar
wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.901/aws-java-sdk-bundle-1.11.901.jar
cd ~

echo -e "\n\n Downloading Java 17 for Spark \n\n"

cd Softwares

if [ "$ARCH" = "x86_64" ] || [ "$ARCH" = "amd64" ]; then
	JDK_URL="https://corretto.aws/downloads/latest/amazon-corretto-17-x64-linux-jdk.tar.gz"
elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
	JDK_URL="https://corretto.aws/downloads/latest/amazon-corretto-17-aarch64-linux-jdk.tar.gz"
else
  echo "Unknown architecture: $ARCH" >&2
  exit 1
fi




JDK_TAR="${JDK_URL##*/}"

echo -e "\nDownloading $JDK_TAR …\n"
curl -L -o "$JDK_TAR" "$JDK_URL"

# Figure out the top-level directory name inside the tarball
JDK_DIR=$(tar tzf "$JDK_TAR" | head -1 | cut -d/ -f1)

echo -e "\nExtracting to \$HOME/java/$JDK_DIR …\n"
mkdir -p "$HOME/java"
tar xzf  "$JDK_TAR" -C "$HOME/java"  # keeps the versioned folder

cd ~

echo -e "\n\n Java 17 Installation Complete. \n\n"


echo -e "\n\n Updating zsh to include Spark and Java Paths \n\n"

echo -e "----------\n"

# ---- idempotent zshrc update - Java ----
BLOCK_START="# >>> Corretto JAVA_HOME >>>"
BLOCK_END="# <<< Corretto JAVA_HOME <<<"
sed -i "/$BLOCK_START/,/$BLOCK_END/d" "$HOME/.zshrc"
cat >> "$HOME/.zshrc" <<EOF
$BLOCK_START
export JAVA_HOME="\$HOME/java/$JDK_DIR"
export PATH="\$JAVA_HOME/bin:\$PATH"
$BLOCK_END
EOF


# ---- idempotent zshrc update - Spark ----
BLOCK_START="# >>> Spark SPARK_HOME >>>"
BLOCK_END="# <<< Spark SPARK_HOME <<<"
sed -i "/$BLOCK_START/,/$BLOCK_END/d" "$HOME/.zshrc"
cat >> "$HOME/.zshrc" <<EOF
$BLOCK_START
export SPARK_HOME="/home/$USER/spark"
export PATH=\$SPARK_HOME:\$PATH
export PYTHONPATH=\$SPARK_HOME/python:\$PYTHONPATH
$BLOCK_END
EOF


echo -e "-----------\n"

fi

if [ $var == 3 ]
then

echo -e "\n\n Installing pyspark module \n\n"

pip install pyspark

pip install pyarrow

echo -e "\n\n Job done! Spark install complete... Happy Distributing :)"
exit 0

fi


echo -e "\n\n Installing Pyenv \n\n"

curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

echo -e "\n\n Adding pyenv Paths to zshrc \n\n"

echo -e "---\n"

PYENV_START="# >>> pyenv >>>"
PYENV_END="# <<< pyenv <<<"
sed -i "/$PYENV_START/,/$PYENV_END/d" ~/.zshrc
cat >> ~/.zshrc <<EOF
$PYENV_START
export PYENV_ROOT="\$HOME/.pyenv"
export PATH="\$PYENV_ROOT/bin:\$PATH"
eval "\$(pyenv init --path)"
eval "\$(pyenv init -)"
$PYENV_END
EOF


echo -e "---\n"

echo "Done..... Now restarting Shell. To complete the setup Run PART 2 now!!"
exec "$SHELL"

cd ~

