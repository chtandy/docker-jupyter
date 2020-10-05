### 設定密碼方式
```
from notebook.auth import passwd
passwd()
Out[2]: 'sha1:67c9e60bb8b6:9ffede0825894254b2e042ea597d771089e11aed'
```
- ~/.jupyter/jupyter_notebook_config.py
```
c.NotebookApp.password = 'sha1:67c9e60bb8b6:9ffede0825894254b2e042ea597d771089e11aed'
```
