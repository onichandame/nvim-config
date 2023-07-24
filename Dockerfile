FROM tamasfe/taplo:full as taplo

FROM alpine:3.18
COPY --from=taplo /usr/bin/taplo /usr/bin/taplo

RUN apk update && apk add neovim neovim-doc nodejs npm yarn ripgrep git gcc libstdc++-dev g++ fd rustup curl
RUN apk add --update --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ lua-language-server
RUN yarn global add typescript typescript-language-server vscode-langservers-extracted yaml-language-server @prisma/language-server dockerfile-language-server-nodejs bash-language-server prettier
RUN rustup-init -y
ENV PATH=/root/.cargo/bin:${PATH}
RUN rustup component add rust-analyzer
RUN ln -s /root/.rustup/toolchains/stable-x86_64-unknown-linux-musl/bin/rust-analyzer /root/.cargo/bin/rust-analyzer
ADD . /root/.config/nvim 
RUN nvim --headless "+Lazy! sync" +qa
