FROM ubuntu:18.04
MAINTAINER cht.andy@gmail.com

RUN echo "######### apt update ##########" \
  && apt-get update \
  && apt-get install sudo git vim jq curl wget python python3 python3-pip \
  bash-completion \ 
  --assume-yes \
  && rm -rf /var/lib/apt/lists/* && apt-get clean
  
RUN echo "######### dash > bash ##########" \
  && mv /bin/sh /bin/sh.old && ln -s bash /bin/sh

RUN echo "######### install pip ##########" \
  && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
  && python get-pip.py \
  && rm -f get-pip.py

RUN echo "######### install jupyter ##########" \
  && pip3 install notebook \
  && jupyter notebook --generate-config \
  && echo "c.NotebookApp.ip='*'" >> /root/.jupyter/jupyter_notebook_config.py \
  && echo "c.NotebookApp.token = ''" >> /root/.jupyter/jupyter_notebook_config.py \
  && echo "c.NotebookApp.open_browser = False" >> /root/.jupyter/jupyter_notebook_config.py \
  && echo "c.NotebookApp.notebook_dir = '/data'" >> /root/.jupyter/jupyter_notebook_config.py \
  && echo "c.NotebookApp.default_url = '/tree'" >> /root/.jupyter/jupyter_notebook_config.py 

ENTRYPOINT ["/usr/local/bin/jupyter", "notebook"]
CMD ["--allow-root"]


