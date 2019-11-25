Apos executar o container, acesse o ambiente home e execute o connvpn.sh

```Bash
docker run -it \
   -e DISPLAY \
   -e VPNSITE=vpnusersebt.mysite.com.br \
   -v /tmp/.X11-unix:/tmp/.X11-unix \
   -v ${HOME}/.pidgin:/admin/config \
   -v ${HOME}/.sky2:/admin/.sky2 \
   -v ${HOME}/Público:/Público \
   --privileged \
   --hostname wtimedbs001.mysite.com.br \
   --name gbconn \
   --shm-size=2g \
   gbconn:latest
   ```
