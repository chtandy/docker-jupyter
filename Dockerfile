FROM ubuntu:18.04
MAINTAINER cht.andy@gmail.com
ENV LANGUAGE="zh_TW.UTF-8"
ENV LANG="zh_TW.UTF-8"
ENV LC_ALL="zh_TW.UTF-8"

RUN echo "######### apt update ##########" \
  && apt-get update \
  && apt-get install python3 python3-pip locales vim \
  --assume-yes \
  && rm -rf /var/lib/apt/lists/* && apt-get clean

RUN echo "######### dash > bash ##########" \
  && mv /bin/sh /bin/sh.old && ln -s bash /bin/sh

RUN echo "######### change locale Lang ##########" \
  && locale-gen zh_TW.UTF-8 && update-locale LANG=zh_TW.UTF-8

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
