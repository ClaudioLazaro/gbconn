Apos executar o container, acesse o ambiente home e execute o connvpn.sh

```Bash
docker run -it \
   -e DISPLAY \
   -e VPNSITE=vpnusersebt.mysite.com.br \
   -e VPNPIN=12345 \
   -e VPNNAME=myname \
   -v /tmp/.X11-unix:/tmp/.X11-unix \
   -v ${HOME}/.pidgin:/admin/config \
   -v ${HOME}/.sky2:/admin/.sky2 \
   -v ${HOME}/Público:/Público \
   --privileged \
   --hostname wtimedbs001.mysite.com.br \
   --name gbconn \
   --shm-size=2g \
   clazarsky/gbconn:latest
   ```
   
   
   Apos intalacao, use o apt update para atualizar todos os pacotes, e instale o pacote tzdata.
   Apenas as seguintes opcoes sao obrigatorias:
   
      -e VPNSITE=vpnusersebt.mysite.com.br \
      --privileged \
No diretorio home, voce vai econtrar : connvpn.sh
Edite e altere o pin e user name
Para efetuar a conexao : connvpn.sh -c
