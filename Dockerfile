FROM nvidia/cuda:8.0-cudnn5-devel
MAINTAINER Vincent FENET <vincent@fenet.fr>

RUN apt-get update && apt-get install -y --no-install-recommends build-essential curl git libssl-dev nano rsync software-properties-common sudo unzip libnanomsg-dev && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -O https://repo.continuum.io/miniconda/Miniconda2-4.2.12-Linux-x86_64.sh && bash Miniconda2-4.2.12-Linux-x86_64.sh -b -p /anaconda2 && rm Miniconda2-4.2.12-Linux-x86_64.sh
RUN echo 'export PATH="/anaconda2/bin:$PATH"' >> /root/.bashrc
RUN /anaconda2/bin/pip --no-cache-dir install ipython==5.3.0
RUN /anaconda2/bin/pip --no-cache-dir install ipykernel jupyter matplotlib numpy scipy sklearn Pillow pandas Quandl gym lxml && /anaconda2/bin/python -m ipykernel.kernelspec

RUN /anaconda2/bin/conda install pytorch torchvision -c soumith --yes
RUN /anaconda2/bin/conda install lua=5.1 lua-science -c alexbw --yes
RUN /anaconda2/bin/conda install anaconda-client --yes

RUN /anaconda2/bin/luarocks install nn

RUN git clone https://github.com/torch/distro.git ~/torch && cd ~/torch && ./clean.sh && bash install-deps && cd .. && rm -rf torch
RUN git clone https://github.com/torch/distro.git ~/torch --recursive && cd ~/torch && ./clean.sh && ./install.sh && cd ..
RUN git clone https://github.com/imodpasteur/lutorpy.git && cd lutorpy && /anaconda2/bin/python setup.py install && cd .. && rm -rf lutorpy

