#!/bin/zsh

# Made with Love - by @ahujaaa

cd ~

echo -e "\n\n Installing Anaconda - Python - Jupyter \n\n"

echo -e "----------\n"

pyenv install anaconda3-2023.09-0

pyenv global anaconda3-2023.09-0

conda update -y conda

echo -e "----------\n"

echo -e "\n\n Installing AWS CLI \n\n"

pip install --upgrade pip

pip install awscli

echo -e "\n\n Installing pyspark module \n\n"

pip install pyspark

echo -e "\n\n Installing pyarrow module \n\n"

pip install pyarrow

echo -e "\n\n Installing Jupyter Notebook Extensions \n\n"

pip install jupyter_contrib_nbextensions && jupyter contrib nbextension install --user

echo -e "\n\n Installing Apache Sedona and Dependencies \n\n"

pip install shapely
pip install geopandas
pip install attrs

pip install apache-sedona

echo -e "\n\n\n----------\n"


echo -e "All done. Restarting Shell"

exec "$SHELL"

cd ~