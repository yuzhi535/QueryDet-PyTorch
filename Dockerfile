# pytorch1.9+apex+cuda11.3+python3.8
FROM  nvcr.io/nvidia/pytorch:21.05-py3

COPY ./ /workspace

WORKDIR /workspace

RUN apt-get update &&  \
  apt-get install git build-essential gcc ranger vim fish zsh  -y

RUN python -m pip install setuptools --upgrade

RUN cd detectron2 && \
  git checkout tags/v0.2.1 -b v0.2.1

RUN  python -m pip install -e detectron2  
RUN  cd detectron2_backbone && \
  python setup.py build develop 

RUN python -m pip install spconv-cu113 

# fix a bug
RUN python -m pip install fvcore==0.1.1.dev200512 -i https://mirrors.bfsu.edu.cn/pypi/web/simple
