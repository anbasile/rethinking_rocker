ARG DOWNLOAD_STATIC_LIBV8=1

FROM rocker/tidyverse:4.2.3

RUN apt-get update && apt-get install -y curl g++ build-essential

RUN install2.r --error --skipinstalled -r https://mc-stan.org/r-packages/ -r getOption \
    V8 \
    abind \
    checkmate \
    cmdstanr \
    coda \
    dagitty \
    devtools \
    distributional \
    loo \
    matrixStats \
    mvtnorm \
    numDeriv \
    posterior \
    shape \
    tensorA


# Install CmdStan
RUN R -e 'library(cmdstanr); install_cmdstan()'

# Run CmdStan Tests
RUN cd /root/.cmdstan/cmdstan-* && \
    make examples/bernoulli/bernoulli && \
    ./examples/bernoulli/bernoulli sample data file=examples/bernoulli/bernoulli.data.json && \
    test -f output.csv && \
    wc -l output.csv && \
    bin/stansummary output.csv && \
    rm output.csv

# Install Rethinking
RUN R -e 'devtools::install_github("rmcelreath/rethinking")'

# Install vscode
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Create VSCode Server config
RUN mkdir -p ~/.config/code-server && \
    echo "bind-addr: 0.0.0.0:8080" > ~/.config/code-server/config.yaml && \
    echo "auth: password" >> ~/.config/code-server/config.yaml && \
    echo "password: yourpassword" >> ~/.config/code-server/config.yaml

# Expose ports for RStudio and VSCode
EXPOSE 8787 8080

# Start VSCode Server in the background
CMD code-server --bind-addr 0.0.0.0:8080 --auth password

# To start RStudio Server instead, comment the previous line and uncomment the next one
# CMD /init
