#!/bin/zsh

# Made with Love - by @ahujaaa

cd ~

echo -e "\n\n Installing Miniconda - Python - Jupyter - Latest \n\n"

echo -e "----------\n"

pyenv install miniconda3-latest

pyenv global miniconda3-latest

conda update -y conda

echo -e "----------\n"

echo -e "\n\n Installing Pandas and AWS CLI \n\n"

pip install --upgrade pip

pip install pandas

pip install awscli

echo -e "\n\n Installing pyspark module \n\n"

pip install pyspark

echo -e "\n\n Installing pyarrow module \n\n"

pip install pyarrow

echo -e "\n\n Installing Jupyter Notebook Extensions \n\n"

pip install jupyterlab notebook

pip install jupyter_contrib_nbextensions

echo -e "\n\n Installing Apache Sedona and Dependencies \n\n"

pip install shapely geopandas attrs apache-sedona

echo -e "\n\n\n----------\n"


echo -e "All done. Restarting Shell"

exec "$SHELL"

cd ~