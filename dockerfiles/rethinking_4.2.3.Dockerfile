FROM rocker/tidyverse:4.2.3

COPY scripts /rocker_scripts/

RUN /rocker_scripts/install_rethinking.sh

EXPOSE 8787

CMD ["/init"]
