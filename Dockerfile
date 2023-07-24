FROM alpine:3.18

RUN apk update && apk add neovim neovim-doc nodejs npm yarn ripgrep git gcc libstdc++-dev g++ fd rustup curl
RUN yarn global add typescript typescript-language-server vscode-langservers-extracted yaml-language-server @prisma/language-server dockerfile-language-server-nodejs bash-language-server prettier
RUN rustup-init -y
ENV PATH=/root/.cargo/bin:${PATH}
RUN rustup component add rust-analyzer
RUN ln -s /root/.rustup/toolchains/stable-x86_64-unknown-linux-musl/bin/rust-analyzer /root/.cargo/bin/rust-analyzer
RUN cargo install --features lsp --locked taplo-cli
ADD . /root/.config/nvim 
RUN nvim --headless "+Lazy! sync" +qa
