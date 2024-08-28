# /bin/bash

red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

printf "\n${cyn}### INICIANDO ###${end}\n"
#cd /home/traefik/psicontacto-integrated
printf "\n${cyn}### GIT PULL ###${end}\n"
#git pull

read -p "Needs docker build? (y/N) " needsBuild
case "$needsBuild" in
  y|Y )
    printf "\n${YELLOW}Rebuilding...${NC}\n"
   #docker compose -f compose.traefik.prod.yaml build
    ;;
  * ) printf "\n${YELLOW}Skipping rebuild${NC}\n";;
esac

printf "\n${cyn}### Docker containers restart ###${end}\n"
#docker compose -f compose.traefik.prod.yaml down
#docker compose -f compose.traefik.prod.yaml up -d
