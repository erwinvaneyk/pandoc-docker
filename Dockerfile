# Forked from https://github.com/jagregory/pandoc-docker
FROM haskell:8.0

# install latex packages
RUN apt-get update -y \
  && apt-get install -y -o Acquire::Retries=10 --no-install-recommends \
    texlive-latex-base \
    texlive-xetex latex-xcolor \
    texlive-math-extra \
    texlive-latex-extra \
    texlive-fonts-extra \
    texlive-bibtex-extra \
    fontconfig \
    lmodern

# will ease up the update process
# updating this env variable will trigger the automatic build of the Docker image
ENV PANDOC_VERSION "2.1"

# install pandoc and additional packages
RUN cabal update
RUN cabal install pandoc-${PANDOC_VERSION}
# Plugins
RUN cabal install pandoc-include

WORKDIR /source

ENTRYPOINT ["/root/.cabal/bin/pandoc", "--filter pandoc-include"]

CMD ["--help"]
