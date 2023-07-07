FROM alpine:3.18

RUN apk update && apk add neovim neovim-doc nodejs npm yarn ripgrep git gcc libstdc++-dev g++ fd rustup curl
RUN yarn global add typescript typescript-language-server vscode-langservers-extracted yaml-language-server @prisma/language-server dockerfile-language-server-nodejs bash-language-server prettier
RUN curl https://github.com/LuaLS/lua-language-server/releases/download/3.6.23/lua-language-server-3.6.23-linux-x64-musl.tar.gz -L -o lua-ls.tgz && mkdir lua-ls && mv lua-ls.tgz lua-ls && cd lua-ls && tar -zxf lua-ls.tgz && rm -rf lua-ls.tgz && cd - && mv lua-ls ~/.lua-ls && echo -e '#!/bin/bash\nexec "~/.lua-ls/bin/lua-language-server" "$@"' > /usr/local/bin/lua-language-server && chmod +x /usr/local/bin/lua-language-server
RUN rustup-init -y
RUN rustup component add rust-analyzer
RUN cargo install --features lsp --locked taplo-cli
ADD . /root/.config/nvim 
RUN nvim --headless "+Lazy! sync" +qa
